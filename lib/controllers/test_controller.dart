import 'package:get/get.dart';

import '../models/test_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(Task task) {
    tasks.add(task);
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
  }
}
