import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../models/benchmark_model.dart';

class BluetoothService {
  static Map<String, BenchmarkResult> benchmarkResults = {};

  /// ✅ Runs Bluetooth Benchmark and Stores Locally
  static Future<void> runBluetoothBenchmark() async {
    try {
      final result = await _testBluetoothSpeed();

      final benchmark = BenchmarkResult(
        speed: result['speed'] as double,    // Mbps
        latency: result['latency'] as int,   // ms
        difficulty: 3,                       // Medium difficulty setup
        security: 3,                         // Medium security
        reason: 'Bluetooth offers moderate speed with average security.',
      );

      benchmarkResults['bluetooth'] = benchmark;

      // Store the result locally
      await _storeResults();
    } catch (e) {
      print('Bluetooth Benchmark Error: $e');
    }
  }

  /// ✅ Bluetooth Speed and Latency Test (Real Data)
  static Future<Map<String, dynamic>> _testBluetoothSpeed() async {
    final stopwatch = Stopwatch();
    double speedMbps = 0.0;
    int latencyMs = 0;

    try {
      // ✅ Start scanning
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));

      // Wait until devices are found
      List<ScanResult> scanResults = await FlutterBluePlus.scanResults.first;
      FlutterBluePlus.stopScan();

      if (scanResults.isEmpty) {
        throw Exception('No Bluetooth devices found');
      }

      final device = scanResults.first.device;

      // ✅ Connect to the device
      await device.connect();

      // ✅ Discover services properly
      List<BluetoothService> services = await device.discoverServices();
      BluetoothCharacteristic? characteristic;

      for (var service in services) {
        for (var char in service.characteristics) {
          if (char.properties.write && char.properties.read) {
            characteristic = char;
            break;
          }
        }
      }

      if (characteristic == null) {
        throw Exception('No writable characteristic found');
      }

      // ✅ Send 1MB of data and measure the transfer speed
      const int dataSize = 1024 * 1024; // 1 MB
      final bytes = Uint8List(dataSize);

      stopwatch.start();

      for (int i = 0; i < 10; i++) {
        await characteristic.write(bytes, withoutResponse: true);
      }

      stopwatch.stop();

      // ✅ Calculate speed in Mbps
      final elapsedSeconds = stopwatch.elapsedMilliseconds / 1000;
      speedMbps = ((dataSize * 10 * 8) / (elapsedSeconds * 1000000));

      // ✅ Measure latency
      latencyMs = await _measureLatency(device);

      await device.disconnect();
    } catch (e) {
      print('Bluetooth Test Error: $e');
    }

    return {'speed': speedMbps, 'latency': latencyMs};
  }

  /// ✅ Measure Bluetooth Latency (Real Data)
  static Future<int> _measureLatency(BluetoothDevice device) async {
    try {
      final stopwatch = Stopwatch()..start();

      List<BluetoothService> services = await device.discoverServices();
      BluetoothCharacteristic? characteristic;

      for (var service in services) {
        for (var char in service.characteristics) {
          if (char.properties.write && char.properties.read) {
            characteristic = char;
            break;
          }
        }
      }

      if (characteristic == null) {
        return 9999; // No characteristic found
      }

      Uint8List testData = Uint8List.fromList([0x01]);
      await characteristic.write(testData);
      await characteristic.read();

      stopwatch.stop();
      return stopwatch.elapsedMilliseconds;
    } catch (e) {
      print('Latency Error: $e');
      return 9999;
    }
  }

  /// ✅ Store Bluetooth Benchmark Results Locally (Proper JSON Encoding)
  static Future<void> _storeResults() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/bluetooth_benchmark_results.json');

      final jsonResults = benchmarkResults.map((key, value) => MapEntry(key, value.toJson()));

      // ✅ Store results in proper JSON format
      await file.writeAsString(jsonEncode(jsonResults));
    } catch (e) {
      print('Error storing Bluetooth benchmark results: $e');
    }
  }

  /// ✅ Load Bluetooth Results from Local Storage (Proper Decoding)
  static Future<void> loadResults() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/bluetooth_benchmark_results.json');

      if (file.existsSync()) {
        final content = await file.readAsString();

        // ✅ Properly decode JSON content
        final Map<String, dynamic> jsonResults = jsonDecode(content);

        benchmarkResults = jsonResults.map(
              (key, value) => MapEntry(key, BenchmarkResult.fromJson(value)),
        );
      }
    } catch (e) {
      print('Error loading Bluetooth benchmark results: $e');
    }
  }
}
