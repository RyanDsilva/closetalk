import 'package:closetalk/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var currentUser = User().obs;

  void setupUser(User user) {
    currentUser.value = user;
  }
}
