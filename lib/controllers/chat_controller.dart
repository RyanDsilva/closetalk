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
}
