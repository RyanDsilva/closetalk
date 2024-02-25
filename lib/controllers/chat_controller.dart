import 'package:closetalk/models/chat_message.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/chat.dart';
import '../models/user.dart';

class ChatController extends GetxController {
  var chats = <String, Chat>{}.obs;

  Box<Chat> db = Hive.box('chats');

  @override
  void onInit() {
    super.onInit();
    for (var element in db.values) {
      chats.assign(element.user!.id!, element);
    }
  }

  void checkAndAddNewConversation(User user) async {
    final chatObj = Chat(
      user: user,
      messages: [],
    );
    chats.addIf(
      !chats.containsKey(user.id),
      user.id!,
      chatObj,
    );
    await db.put(user.id, chatObj);
    update();
  }

  Future<void> sendMessage(
    String message,
    String recipientId,
    User owner,
    String type,
    NearbyService nearbyService,
  ) async {
    final content = '$type://$message';
    await nearbyService.sendMessage(recipientId, content);
    await addMessageToConversation(message, owner, recipientId);
  }

  Future<void> addMessageToConversation(
      String message, User owner, String chatId) async {
    final chat = chats[chatId];
    final m = ChatMessage(text: message, owner: owner);
    chat?.messages?.add(m);
    update();
    await db.put(chatId, chat!);
  }
}
