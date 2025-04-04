import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'app_directory_path.dart';
import '../common/utils/utils.dart';

class StoreManager implements Disposable {
  static bool _hasInitialized = false;

  static const _secureData = "secureData";

  static const _encryptionKey = "encryptionKey";

  static const _prefKey = "preferences";

  static late final Box _prefBox;

  static late final Box<Map<String, dynamic>> _secureBox;

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static const StoreManager instance = StoreManager();

  const StoreManager();

  Future<StoreManager> initialize() async {
    if (_hasInitialized) return instance;

    await AppDirectory.initPath();

    if (!Utils.isWeb) {
      Hive.init(AppDirectory.path);
    }
    await _initPreferenceBox();
    await _initEncryptedBox();

    _hasInitialized = true;
    return instance;
  }

  static Future<void> _initPreferenceBox() async =>
      _prefBox = await Hive.openBox(_prefKey);

  static Future<void> _initEncryptedBox() async {
    final encryptionKeyString = await _secureStorage.read(key: _encryptionKey);
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await _secureStorage.write(
        key: _encryptionKey,
        value: base64UrlEncode(key),
      );
    }
    final key = await _secureStorage.read(key: _encryptionKey);
    final encryptionKeyUint8List = base64Url.decode(key!);
    _secureBox = await Hive.openBox(_secureData,
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  }

  Future<void> put(dynamic key, dynamic value) {
    if (value == null) return Future.value(null);
    return _prefBox.put(key, value);
  }

  dynamic get(dynamic key) => _prefBox.get(key, defaultValue: null);

  Future<void> remove(dynamic key) => _prefBox.delete(key);

  Map<String, dynamic>? getSecureData(String key) =>
      _secureBox.get(key, defaultValue: null);

  Future<void> putSecureData(String key, Map<String, dynamic>? value) {
    if (value == null) return Future.value(null);
    return _secureBox.put(key, value);
  }

  Future<void> removeSecureData(String key) => _secureBox.delete(key);

  @override
  void onDispose() {
    _prefBox.close();
    _secureBox.close();
  }
}
