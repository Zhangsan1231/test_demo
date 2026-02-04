import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "用户名"),
              // 实时更新 Controller 里的值
              onChanged: (val) => controller.username.value = val,
            ),
            const SizedBox(height: 20),
            // Obx 会在 isLoading 变化时自动刷新包裹的组件
            Obx(() => controller.isLoading.value 
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => controller.login(),
                  child: const Text("登录"),
                ),
            ),
          ],
        ),
      ),
    );
  }
}