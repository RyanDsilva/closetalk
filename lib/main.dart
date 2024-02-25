import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:closetalk/constants/colors.dart';
import 'package:closetalk/controllers/chat_controller.dart';
import 'package:closetalk/controllers/nearby_controller.dart';
import 'package:closetalk/controllers/user_controller.dart';
import 'package:closetalk/models/chat.dart';
import 'package:closetalk/models/chat_message.dart';
import 'package:closetalk/models/group_chat.dart';
import 'package:closetalk/models/user.dart';
import 'package:closetalk/screens/chat.dart';
import 'package:closetalk/screens/discover.dart';
import 'package:closetalk/screens/global_chat.dart';
import 'package:closetalk/screens/home.dart';
import 'package:closetalk/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://mipmap/ic_launcher',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'CloseTalk Notifications',
        defaultColor: apnaMaroon,
        ledColor: apnaWhite,
      )
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic Group')
    ],
    debug: true,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(ChatAdapter());
  Hive.registerAdapter(GroupChatAdapter());
  // await Hive.deleteFromDisk();
  await Hive.openBox<User>('user');
  await Hive.openBox<Chat>('chats');
  await Hive.openBox<GroupChat>('group_chats');
  final userController = Get.put<UserController>(UserController());
  final _ = Get.put<ChatController>(ChatController());
  final __ = Get.put<NearbyServiceController>(NearbyServiceController());
  debugPrint(userController.currentUser.value.toString());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans'),
      initialRoute: userController.isCurrentUserSet.value == true ? '/' : '/profile',
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
