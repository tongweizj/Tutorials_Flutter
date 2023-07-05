import 'dart:convert';
import 'package:app/core/constants/global.dart';
import 'package:app/core/utils/security.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class StorageUtil {
  static StorageUtil _instance = new StorageUtil._();
  factory StorageUtil() => _instance;
  static SharedPreferences _prefs;

  StorageUtil._();

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  /// 设置 json 对象
  Future<bool> setJSON(String key, dynamic jsonVal) async {
    String jsonString = jsonEncode(jsonVal);
    // print('jsonString');
    // print(jsonString);
    return _prefs.setString(key, jsonString);
  }

  /// 获取 json 对象
  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  /// 删除 json 对象
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  /// 存储 登出用户的历史数据
  dynamic setLogoutUserData(String key, dynamic jsonVal) async {
    // print('setLogoutUserData');
    String jsonString = jsonEncode(jsonVal);

    /// 加密数据
    /// 用户登录邮箱做为key值
    String _key =
        IotKeyLock.encodeBase64(Global.profile.username.toUpperCase());
    var encrypted = encryptAESCryptoJS(jsonString, _key);

    return _prefs.setString(_key, encrypted);
  }

  /// 获取 已登出用户的历史数据
  dynamic getLogoutUserData(String key) {
    String _key =
        IotKeyLock.encodeBase64(Global.profile.username.toUpperCase());
    String encrypted = _prefs.getString(_key);
    var decrypted = 'null';
    if (encrypted != null) {
      decrypted = decryptAESCryptoJS(encrypted, _key);
    }

    return decrypted == 'null' ? null : jsonDecode(decrypted);
  }

  /// 获取 已登出用户的历史数据
  dynamic getLogoutUserData2(String key) {
    String _key =
        IotKeyLock.encodeBase64(Global.profile.username.toUpperCase());
    String encrypted = _prefs.getString(_key);
    var decrypted = 'null';
    if (encrypted != null) {
      decrypted = decryptAESCryptoJS(encrypted, _key);
    }

    return decrypted == 'null' ? null : jsonDecode(decrypted);
  }
}
