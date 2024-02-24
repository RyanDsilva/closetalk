import 'package:closetalk/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      key: const Key('home'),
      body: Obx(
        () => Text(userController.currentUser.value.name ?? 'test'),
      ),
    );
  }
}
