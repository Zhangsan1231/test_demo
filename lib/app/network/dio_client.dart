import 'package:dio/dio.dart';
import 'package:test_demo/app/core/service/storage_service.dart';

import '../core/values/storage_keys.dart';

class DioClient {
  static final DioClient instance = DioClient._internal();
  factory DioClient() => instance;

  late Dio _dio;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com', // 替换为真实 API
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    // 拦截器：自动在请求头带上 Token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = SecureStorageService().getString(StorageKeys.token);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<Response> get(String url) => _dio.get(url);
}