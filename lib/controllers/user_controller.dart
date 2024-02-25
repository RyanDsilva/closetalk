import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/user.dart';

class UserController extends GetxController {
  var currentUser = User().obs;
  var isCurrentUserSet = false.obs;
  Box<User> db = Hive.box('user');

  void updateUser(User user) {
    currentUser.value = user;
    isCurrentUserSet.value = true;
    db.put('currentUser', user);
    debugPrint(user.toString());
  }
}
