import '../models/Task.dart';

abstract class TaskHandler {
  void handleNewTask(Task task);
}
