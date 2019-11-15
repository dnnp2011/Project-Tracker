import 'package:project_logger/models/Task.dart';

abstract class TaskHandler {
  void handleNewTask(Task task);
}
