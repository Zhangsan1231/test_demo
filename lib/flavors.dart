/*
 * @Author: 张仕鹏 1120148291@qq.com
 * @Date: 2025-02-25 16:17:04
 * @LastEditors: 张仕鹏 1120148291@qq.com
 * @LastEditTime: 2025-03-13 15:38:27
 * @FilePath: /flutter-template-getx/lib/flavors.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:logger/web.dart';
import 'package:mmkv/mmkv.dart';
import 'package:test_demo/app/core/service/storage_service.dart';
import 'package:test_demo/app/core/values/app_values.dart';



/// API 区域枚举
enum ApiRegion {
  /// 国内
  cn,
  /// 国外
  global,
}

/// 应用环境枚举
/// 
/// 用于区分不同的应用环境：
/// - dev: 开发环境
/// - prod: 生产环境
enum Flavor {
  /// 开发环境
  dev,
  /// 生产环境
  prod,
}

/// 应用环境配置类
/// 
/// 用于管理不同环境下的应用配置，包括：
/// - 应用名称
/// - API基础URL（国内/国外）
/// - 日志开关
/// - 其他环境相关配置
class F {
  /// 当前应用环境
  static Flavor? appFlavor;

  /// 获取当前环境名称
  /// 
  /// 返回当前环境的名称字符串，如果未设置则返回空字符串
  static String get name => appFlavor?.name ?? '';

  /// 获取应用标题
  /// 
  /// 根据当前环境返回对应的应用标题：
  /// - 开发环境：'模板Dev'
  /// - 生产环境：'模板Prod'
  /// - 默认：'title'
  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '模板Dev';
      case Flavor.prod:
        return '模板Prod';
      default:
        return 'title';
    }
  }

  /// 获取国内API基础URL
  /// 
  /// 根据当前环境返回对应的国内API基础地址：
  /// - 开发环境：'https://dev-cn.api.com'
  /// - 生产环境：'https://prod-cn.api.com'
  /// - 默认：空字符串
  static String get apiBaseUrlCN {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://81.71.13.182'; // 开发环境的国内 API 地址
      case Flavor.prod:
        return 'https://prod-cn.api.com'; // 生产环境的国内 API 地址
      default:
        return '';
    }
  }

  /// 获取国外API基础URL
  /// 
  /// 根据当前环境返回对应的国外API基础地址：
  /// - 开发环境：'https://dev-global.api.com'
  /// - 生产环境：'https://prod-global.api.com'
  /// - 默认：空字符串
  static String get apiBaseUrlGlobal {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://dev-global.api.com'; // 开发环境的国外 API 地址
      case Flavor.prod:
        return 'https://prod-global.api.com'; // 生产环境的国外 API 地址
      default:
        return '';
    }
  }

  /// 获取当前使用的API基础URL
  /// 
  /// 根据本地存储的 API 区域设置返回对应的API基础地址：
  /// - 国内：返回国内API地址
  /// - 国外：返回国外API地址
  /// - 默认：返回国内API地址
  static Future<String> get apiBaseUrl async {
    final storage = SecureStorageService.instance;
    final regionValue = await storage.getInt(AppValues.apiRegionKey);
    
    // 将存储的整数值转换为 ApiRegion 枚举
    final region = regionValue != null ? ApiRegion.values[regionValue] : null;
    
    switch (region) {
      case ApiRegion.global:
        return apiBaseUrlGlobal;
      case ApiRegion.cn:
      default:
        return apiBaseUrlCN;
    }
  }

  /// 获取日志开关状态
  /// 
  /// 根据当前环境返回是否启用日志：
  /// - 开发环境：true（启用日志）
  /// - 生产环境：false（禁用日志）
  /// - 默认：false
  static bool get enableLogging {
    switch (appFlavor) {
      case Flavor.dev:
        return true; // 开发环境开启日志
      case Flavor.prod:
        return false; // 生产环境关闭日志
      default:
        return false;
    }
  }

  /// 设置 API 区域
  /// 
  /// [region] API 区域枚举值
  /// 设置后将自动切换对应的 API 地址
  static Future<void> setApiRegion(ApiRegion region) async {
    final storage = SecureStorageService.instance;
    // 将枚举值转换为整数存储
    storage.setInt(AppValues.apiRegionKey, region.index);
  }
}
