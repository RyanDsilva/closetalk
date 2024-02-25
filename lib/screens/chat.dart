import 'package:closetalk/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:closetalk/constants/colors.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final userController = Get.put(UserController());
    return const MaterialApp(
      key: Key('chat'),
      home: ChatPage(), //Obx(
      //() => Text(userController.currentUser.value.name ?? 'test'),
      //     Container(
      //   decoration: const BoxDecoration(
      //     color: apnaWhite),
      // ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apnaMaroon,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
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
            leading: RandomAvatar("string1"), // Your leading widget
            // Uncomment title if you need it
            // title: const Text("Flutter app2"),
          ),
        ),
      ),
      body: Chats(), // Your chats widget
    );
  }
}

class Chats extends StatelessWidget {
  //const Chats({super.key});

  // Dummy data for messages
  final List<Message> messages = [
    Message(sender: 'Me', text: 'Hi there!'),
    Message(sender: 'Bob', text: 'Hello! How are you?'),
    Message(sender: 'Me', text: 'I\'m good, thanks!'),
    Message(sender: 'Bob', text: 'Great to hear!'),
    Message(sender: 'Me', text: 'Hi there!'),
    Message(sender: 'Bob', text: 'Hello! How are you?'),
    Message(sender: 'Me', text: 'I\'m good, thanks!'),
    Message(sender: 'Bob', text: 'Great to hear!'),
    Message(sender: 'Me', text: 'Hi there!'),
    Message(sender: 'Bob', text: 'Hello! How are you?'),
    Message(sender: 'Me', text: 'I\'m good, thanks!'),
    Message(sender: 'Bob', text: 'Great to hear!'),
    Message(sender: 'Me', text: 'Hi there!'),
    Message(sender: 'Bob', text: 'Hello! How are you?'),
    Message(sender: 'Me', text: 'I\'m good, thanks!'),
    Message(sender: 'Bob', text: 'Great to hear!'),
    Message(sender: 'Me', text: 'Hi there!'),
    Message(sender: 'Bob', text: 'Hello! How are you?'),
    Message(sender: 'Me', text: 'I\'m good, thanks!'),
    Message(sender: 'Bob', text: 'Great to hear!'),
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(236, 206, 222, 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      //body: Padding(
      //padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Lets talk to get close...',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    //sendMessage();
                  },
                  child: Text('CloseTalk icon'),
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

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}

class ChatBubble extends StatelessWidget {
  final Message message;
  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.sender == 'Me';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMe
              ? Expanded(child: Container()) // Empty container for alignment
              : CircleAvatar(
                  child: Text(message.sender[0]),
                ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.sender,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isMe
                      ? Color.fromRGBO(223, 171, 195, 1)
                      : Color.fromRGBO(180, 78, 126, 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          isMe
              ? CircleAvatar(
                  child: Text(message.sender[0]),
                )
              : Expanded(child: Container()), // Empty container for alignment
        ],
      ),
    );
  }
}
