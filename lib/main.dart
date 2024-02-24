import 'package:closetalk/screens/chat.dart';
import 'package:closetalk/screens/global_chat.dart';
import 'package:closetalk/screens/home.dart';
import 'package:closetalk/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/chat', page: () => const ChatScreen()),
        GetPage(name: '/global_chat', page: () => const GlobalChatScreen()),
      ],
    ),
  );
}
