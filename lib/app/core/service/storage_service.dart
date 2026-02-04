import 'dart:convert';
import 'package:mmkv/mmkv.dart';

class SecureStorageService {
  // 单例实例
  static final SecureStorageService instance = SecureStorageService._internal();

  // 工厂构造函数，返回单例实例
  factory SecureStorageService() => instance;
  
  // MMKV 实例
  late MMKV _mmkv;

  // 私有构造保持纯粹，不写逻辑
  SecureStorageService._internal();

  // 手动异步初始化
  Future<void> init() async {
    await MMKV.initialize(); // 确保真的初始化完了
    _mmkv = MMKV.defaultMMKV();
  }

  // ==================== String 类型 ====================
  /// 存储字符串
  Future<bool> setString(String key, String value) async {
    return _mmkv.encodeString(key, value);
  }

  /// 获取字符串
  String? getString(String key, {String? defaultValue}) {
    return _mmkv.decodeString(key) ?? defaultValue;
  }

  // ==================== int 类型 ====================
  /// 存储整数
  Future<bool> setInt(String key, int value) async {
    return _mmkv.encodeInt(key, value);
  }

  /// 获取整数
  int? getInt(String key, {int? defaultValue}) {
    final value = _mmkv.decodeInt(key);
    return value ?? defaultValue;
  }

  // ==================== bool 类型 ====================
  /// 存储布尔值
  Future<bool> setBool(String key, bool value) async {
    return _mmkv.encodeBool(key, value);
  }

  /// 获取布尔值
  bool? getBool(String key, {bool? defaultValue}) {
    final value = _mmkv.decodeBool(key);
    return value ?? defaultValue;
  }

  // ==================== double 类型 ====================
  /// 存储浮点数
  Future<bool> setDouble(String key, double value) async {
    return _mmkv.encodeDouble(key, value);
  }

  /// 获取浮点数
  double? getDouble(String key, {double? defaultValue}) {
    final value = _mmkv.decodeDouble(key);
    return value ?? defaultValue;
  }

  // ==================== List 类型 ====================
  /// 存储列表（通过 JSON 序列化）
  Future<bool> setList<T>(String key, List<T> value) async {
    try {
      final jsonString = jsonEncode(value);
      return _mmkv.encodeString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  /// 获取列表（通过 JSON 反序列化）
  List<T>? getList<T>(String key, {List<T>? defaultValue}) {
    try {
      final jsonString = _mmkv.decodeString(key);
      if (jsonString == null) return defaultValue;
      final decoded = jsonDecode(jsonString) as List;
      return decoded.cast<T>();
    } catch (e) {
      return defaultValue;
    }
  }

  // ==================== Map 类型 ====================
  /// 存储 Map（通过 JSON 序列化）
  Future<bool> setMap(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return _mmkv.encodeString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  /// 获取 Map（通过 JSON 反序列化）
  Map<String, dynamic>? getMap(String key, {Map<String, dynamic>? defaultValue}) {
    try {
      final jsonString = _mmkv.decodeString(key);
      if (jsonString == null) return defaultValue;
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      return decoded;
    } catch (e) {
      return defaultValue;
    }
  }

  // ==================== 自定义对象类型 ====================
  /// 存储自定义对象（通过 JSON 序列化）
  /// 对象需要实现 toJson 方法，或者直接传入 Map
  Future<bool> setObject<T>(String key, T value) async {
    try {
      // 如果对象有 toJson 方法，使用它；否则尝试直接序列化
      dynamic jsonData;
      if (value is Map) {
        jsonData = value;
      } else {
        // 尝试调用 toJson 方法
        jsonData = (value as dynamic).toJson();
      }
      final jsonString = jsonEncode(jsonData);
      return _mmkv.encodeString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  /// 获取自定义对象（通过 JSON 反序列化）
  /// 需要提供 fromJson 函数来反序列化
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson, {T? defaultValue}) {
    try {
      final jsonString = _mmkv.decodeString(key);
      if (jsonString == null) return defaultValue;
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(decoded);
    } catch (e) {
      return defaultValue;
    }
  }

//   // ==================== 工具方法 ====================
//   /// 删除指定 key
//   Future<bool> remove(String key) async {
//     _mmkv.remove(key);
//     return true;
//   }

//   /// 清空所有数据
//   Future<void> clear() async {
//     _mmkv.clear();
//   }

//   /// 检查 key 是否存在
//   bool containsKey(String key) {
//     return _mmkv.containsKey(key);
//   }
}
