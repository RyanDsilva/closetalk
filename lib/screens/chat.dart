import 'dart:async';

import 'package:closetalk/constants/colors.dart';
import 'package:closetalk/controllers/chat_controller.dart';
import 'package:closetalk/controllers/nearby_controller.dart';
import 'package:closetalk/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

import '../controllers/user_controller.dart';
import '../models/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final userController = Get.find<UserController>();
  final Chat chat = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apnaMaroon,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: apnaMaroon,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), // Bottom left radius
              bottomRight: Radius.circular(20), // Bottom right radius
            ),
          ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Removes shadow
            title: Column(
              children: [
                Text(
                  chat.user?.name ?? '',
                  style: const TextStyle(
                    color: apnaWhite,
                  ),
                ),
                Text(
                  chat.user?.introduction ?? '',
                  style: const TextStyle(
                    color: apnaWhite,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RandomAvatar(
                userController.currentUser.value.avatar ??
                    DateTime.now().toIso8601String(),
              ),
            ), // Your leading widget
            // Uncomment title if you need it
            // title: const Text("Flutter app2"),
          ),
        ),
      ),
      body: Chats(
        chatId: chat.user!.id!,
        currentUserId: userController.currentUser.value.id!,
      ), // Your chats widget
    );
  }
}

class Chats extends StatefulWidget {
  //const Chats({super.key});
  final String chatId;
  final String currentUserId;

  const Chats({
    super.key,
    required this.chatId,
    required this.currentUserId,
  });

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final messageController = TextEditingController();
  final ChatController chatController = Get.find<ChatController>();
  final UserController userController = Get.find<UserController>();
  final NearbyServiceController nearbyServiceController =
      Get.find<NearbyServiceController>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendMessage() async {
    await chatController.sendMessage(
      messageController.text,
      widget.chatId,
      userController.currentUser.value,
      'IND',
      nearbyServiceController.nearbyService,
    );
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(236, 206, 222, 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<NearbyServiceController>(
              builder: (_) {
                return GetX<ChatController>(
                  builder: (chatController) {
                    // Chat? chat = chatController.chats[widget.chatId];
                    return ListView.builder(
                      itemCount:
                          chatController.chats[widget.chatId]?.messages?.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          message:
                              chatController.chats[widget.chatId]!.messages![index],
                          currentUserId: widget.currentUserId,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 35.0,
              left: 12,
              right: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Send a message ...',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await sendMessage();
                  },
                  child: const Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final String currentUserId;
  const ChatBubble({
    super.key,
    required this.message,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.owner?.id == currentUserId;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          isMe
              ? Expanded(child: Container()) // Empty container for alignment
              : RandomAvatar(
                  height: 36,
                  width: 36,
                  message.owner?.avatar ?? 'random',
                ),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.owner?.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isMe
                      ? const Color.fromRGBO(223, 171, 195, 1)
                      : const Color.fromRGBO(180, 78, 126, 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  message.text ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8.0),
          isMe
              ? RandomAvatar(
                  height: 36,
                  width: 36,
                  message.owner?.avatar ?? 'random',
                )
              : Expanded(
                  child: Container(),
                ), // Empty container for alignment
        ],
      ),
    );
  }
}
