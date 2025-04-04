import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../../models/benchmark_model.dart';

class WifiService {
  static Map<String, BenchmarkResult> benchmarkResults = {};

  /// ✅ Run Wi-Fi Benchmark and Store Locally
  static Future<void> runWifiBenchmark() async {
    try {
      final result = await _testWifiSpeed();

      final benchmark = BenchmarkResult(
        speed: result['speed'] as double,    // Mbps
        latency: result['latency'] as int,   // ms
        difficulty: 2,                       // Easy to use
        security: 4,                         // Secure (WPA2/WPA3)
        reason: 'Wi-Fi offers high-speed and secure transfer over LAN.',
      );

      benchmarkResults['wifi'] = benchmark;

      // Store the result locally
      await _storeResults();
    } catch (e) {
      print('Wi-Fi Benchmark Error: $e');
    }
  }

  /// ✅ Wi-Fi Speed and Latency Test (Real Data)
  static Future<Map<String, dynamic>> _testWifiSpeed() async {
    final info = NetworkInfo();
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.wifi) {
      throw Exception('No Wi-Fi connection available');
    }

    final stopwatch = Stopwatch();
    double speedMbps = 0.0;
    int latencyMs = 0;

    try {
      final wifiName = await info.getWifiName();
      final wifiIP = await info.getWifiIP();

      if (wifiIP == null || wifiName == null) {
        throw Exception('Unable to retrieve Wi-Fi info');
      }

      print('Connected to: $wifiName ($wifiIP)');

      // Start Wi-Fi Benchmark
      stopwatch.start();

      // Simulate large file download (10 MB)
      const url = 'http://speedtest.tele2.net/10MB.zip';
      final request = await HttpClient().getUrl(Uri.parse(url));
      final response = await request.close();

      final contentLength = response.contentLength;
      await response.drain();

      stopwatch.stop();

      final elapsedSeconds = stopwatch.elapsedMilliseconds / 1000;
      speedMbps = (contentLength * 8) / (elapsedSeconds * 1000000); // Mbps

      latencyMs = await _measureWifiLatency(wifiIP);
    } catch (e) {
      print('Wi-Fi Test Error: $e');
    }

    return {'speed': speedMbps, 'latency': latencyMs};
  }

  /// ✅ Measure Wi-Fi Latency (Real Data)
  static Future<int> _measureWifiLatency(String ip) async {
    try {
      final stopwatch = Stopwatch()..start();
      final result = await Process.run('ping', ['-c', '1', ip]);

      if (result.exitCode != 0) {
        return 9999; // Unreachable
      }

      stopwatch.stop();
      return stopwatch.elapsedMilliseconds;
    } catch (e) {
      print('Latency Error: $e');
      return 9999;
    }
  }

  /// ✅ Store Wi-Fi Benchmark Results Locally (Correct JSON Encoding)
  static Future<void> _storeResults() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/wifi_benchmark_results.json');

      final jsonResults = benchmarkResults.map((key, value) => MapEntry(key, value.toJson()));

      // ✅ Properly encode the map into JSON format before saving
      await file.writeAsString(jsonEncode(jsonResults));
    } catch (e) {
      print('Error storing Wi-Fi benchmark results: $e');
    }
  }

  /// ✅ Load Wi-Fi Results from Local Storage with Error Handling
  static Future<void> loadResults() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/wifi_benchmark_results.json');

      if (file.existsSync()) {
        final content = await file.readAsString();

        // ✅ Decode the JSON content properly
        final Map<String, dynamic> jsonResults = jsonDecode(content);

        benchmarkResults = jsonResults.map(
              (key, value) => MapEntry(key, BenchmarkResult.fromJson(value)),
        );
      }
    } catch (e) {
      print('Error loading Wi-Fi benchmark results: $e');
    }
  }
}
