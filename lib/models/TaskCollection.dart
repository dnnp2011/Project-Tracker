import 'dart:collection' show UnmodifiableListView;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'Task.dart';

Future<String> getFilePath() async => await getApplicationDocumentsDirectory().then((dir) => dir.path);

class TaskCollection extends ChangeNotifier {
  List<Task> _tasks = [];
  String _dataPath;
  final String _fileName = "project_logger_data.json";

  List<Task> get getTasks => _tasks;
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(getTasks);
  int get totalTasks => this.tasks.length;
  bool get isEmpty => totalTasks <= 0;
  bool get isNotEmpty => !isEmpty;

  TaskCollection(GlobalKey<AnimatedListState> animatedListKey) {
    print('Instantiating TaskCollection()');

    getTasksFromDeviceStorage(animatedListKey);
  }

  void addTask(Task task) {
    _tasks.add(task);

    saveTasksToDeviceStorage();
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);

    saveTasksToDeviceStorage();
    notifyListeners();
  }

  void getTasksFromDeviceStorage(GlobalKey<AnimatedListState> animatedListKey) async {
    print("Getting Tasks from storage");
    String path;

    if (_dataPath == null) {
      path = await getFilePath();
    } else
      path = _dataPath;

    File dataFile = File('$path/$_fileName');

    if (dataFile.existsSync()) {
      String contents = await dataFile.readAsString();
      _tasks = this.fromJson(contents);
    } else {
      print("No DataFile found, generating defaults");
      var tmpList = List.generate(2, (int i) => Task(title: "Create a Task", description: "Tap the + button to get started!"));
      _tasks = tmpList;
    }

    // Force the AnimatedList to render the inserted Tasks
    for (int i = 0; i < _tasks.length; i++) {
      animatedListKey.currentState.insertItem(i);
    }

    // Trigger all listeners to rebuild
    notifyListeners();
  }

  void saveTasksToDeviceStorage() async {
    print("Saving Tasks to storage");
    String path;

    if (_dataPath == null)
      path = await getFilePath();
    else
      path = _dataPath;

    File dataFile = File('$path/$_fileName');

    var encodedTasks = this.toJson();
    print("Encoded Tasks: $encodedTasks");

    dataFile.writeAsString(encodedTasks);
  }

  String toString() => 'Total Elements: $totalTasks';

  List<Task> fromJson(String content) {
    Map<String, dynamic> decodedContent = jsonDecode(content);
    print("Decoded Tasks: $decodedContent");
    List<Task> taskListRes = [];

    for (var i = 0; i < decodedContent.length; i++) {
      Map<String, dynamic> thisTask = decodedContent[i.toString()];
      Task taskRes = Task.fromJson(thisTask);
      taskListRes.add(taskRes);
    }

    return taskListRes;
  }

  String toJson() {
    Map<String, dynamic> result = {};

    for (int i = 0; i < tasks.length; i++) {
      result[i.toString()] = tasks[i].toJson();
    }

    return jsonEncode(result);
  }
}
