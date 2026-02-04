import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_demo/app/core/service/storage_service.dart';
import 'package:test_demo/app/core/utils/logger_singleton.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 这一行是 App 的“保命符”
  await SecureStorageService.instance.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
