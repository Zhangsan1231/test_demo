 import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  // 通用的加载状态
  final isLoading = false.obs;

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;
}