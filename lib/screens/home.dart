import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userController = Get.put(UserController());
    return Scaffold(
      key: const Key('home'),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          int sensitivity = 8;
          if (details.delta.dx > sensitivity) {
            // Right
            Get.offAndToNamed('/discover');
          } else if (details.delta.dx < -sensitivity) {
            // Left
            Get.offAndToNamed('/profile');
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.greenAccent),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: Text('Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
