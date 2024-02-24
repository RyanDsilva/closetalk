import 'package:closetalk/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final testController = Get.put(TaskController());
    return Scaffold(
      body: Obx(
        () => SizedBox(
          child: Text(testController.tasks[0].title),
        ),
      ),
    );
  }
}
