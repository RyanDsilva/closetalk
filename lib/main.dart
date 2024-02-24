import 'package:closetalk/models/chat.dart';
import 'package:closetalk/models/chat_message.dart';
import 'package:closetalk/models/group_chat.dart';
import 'package:closetalk/models/user.dart';
import 'package:closetalk/screens/chat.dart';
import 'package:closetalk/screens/discover.dart';
import 'package:closetalk/screens/global_chat.dart';
import 'package:closetalk/screens/home.dart';
import 'package:closetalk/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(ChatAdapter());
  Hive.registerAdapter(GroupChatAdapter());
  await Hive.openBox<User>('user');
  await Hive.openBox<Chat>('chats');
  await Hive.openBox('group_chats');
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
          transition: Transition.topLevel,
        ),
        GetPage(
          name: '/discover',
          page: () => const DiscoverScreen(),
          transition: Transition.topLevel,
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
          transition: Transition.topLevel,
        ),
        GetPage(
          name: '/chat',
          page: () => const ChatScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/global_chat',
          page: () => const GlobalChatScreen(),
          transition: Transition.fade,
        ),
      ],
    ),
  );
}
