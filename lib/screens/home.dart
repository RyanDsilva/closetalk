import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:closetalk/constants/colors.dart';
import 'package:closetalk/controllers/notification_controller.dart';
import 'package:closetalk/controllers/user_controller.dart';
import 'package:closetalk/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  @override
  Widget build(BuildContext context) {
    // final userController = Get.put(UserController());
    return Scaffold(
      key: const Key('home'),
      backgroundColor: apnaMaroon,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: apnaMaroon, // AppBar color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), // Bottom left radius
              bottomRight: Radius.circular(20), // Bottom right radius
            ),
          ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Removes shadow
            title: const Text(
              'CloseTalk',
              style: TextStyle(
                color: apnaWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: RandomAvatar(
                userController.currentUser.value.avatar ??
                    DateTime.now().toIso8601String(),
              ),
            ), // Your leading widget
          ),
        ),
      ),
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
        child: const ChatScreenMain(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAndToNamed('/discover');
        }, // Plus icon
        backgroundColor: apnaMaroon,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
