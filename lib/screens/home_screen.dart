import 'package:closetalk/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatScreenMain extends StatelessWidget {
  const ChatScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(223, 186, 204, 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GetX<ChatController>(
        builder: (chatController) {
          if (chatController.chats.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  'Feels a little lonely here',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            );
          }
          debugPrint(chatController.chats.toString());
          return ListView.builder(
              itemCount: chatController.chats.length, // Number of chat messages
              itemBuilder: (context, index) {
                final allChats =
                    chatController.chats.entries.map((e) => e.value).toList();
                final chat = allChats[index];
                return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: RandomAvatar(chat.user?.avatar ?? 'test'),
                    ),
                    title: Text(chat.user?.name ?? 'Unknown'),
                    subtitle: Text(chat.user?.introduction ?? 'No Introduction'),
                    trailing: const Text('11:59'),
                    onTap: () {
                      Get.toNamed('/chat', arguments: chat);
                    });
                // message: 'Message ', // Message content
                // sender: 'Sender ', // Sender's name
                // timestamp: '10:00 AM',
              });
        },
      ),
    );
  }
}
