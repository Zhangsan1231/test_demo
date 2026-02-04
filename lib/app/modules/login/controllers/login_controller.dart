import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  // .obs 让变量变成响应式
  final username = ''.obs;
  final isLoading = false.obs;

  void login() async {
    if (username.value.isEmpty) {
      Get.snackbar("错误", "用户名不能为空");
      return;
    }
    
    isLoading.value = true;
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    // 登录成功后跳转到 Home 页
    Get.offAllNamed('/home'); 
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
