import 'dart:collection' show UnmodifiableListView;

import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'Task.dart';

class TaskCollection extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get getTasks => _tasks;
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  int get totalTasks => this._tasks.length;
  bool get isEmpty => totalTasks <= 0;
  bool get isNotEmpty => !isEmpty;

  void addTask(Task task) {
    _tasks.add(task);

    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);

    notifyListeners();
  }
}
