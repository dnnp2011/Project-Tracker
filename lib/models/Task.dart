import 'package:Sprintz/models/Sprint.dart';
import 'package:flutter/foundation.dart' show required, ChangeNotifier;

import '../services/TimerService.dart';

/// A data representation of time spent on a single task, spread throughout some number of "[Sprint]s" (ie. sessions)
class Task extends ChangeNotifier {
  String title;
  String description;
  DateTime createdAt;
  DateTime modifiedAt;
  TimerService timerService;
  List<Sprint> sprints;

  Task({@required title, @required description, sprints, createdAt, modifiedAt}) {
    this.title = title;
    this.description = description;
    this.createdAt = createdAt ?? DateTime.now();
    this.modifiedAt = modifiedAt ?? DateTime.now();
    this.sprints = sprints ?? [];
    this.timerService = new TimerService();
    this.timerService.addListener(this.onUpdateTimer);
  }

  factory Task.fromJson(Map<String, dynamic> taskMap) {
    Task taskRes = Task(
      title: taskMap["title"],
      description: taskMap["description"],
      createdAt: DateTime.parse(taskMap["createdAt"]),
      modifiedAt: DateTime.parse(taskMap['modifiedAt']),
      sprints: Sprint.fromJson(taskMap["sprints"]),
    );

    print("Task.fromJson res: $taskRes");

    return taskRes;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "description": this.description,
      "createdAt": this.createdAt.toString(),
      "modifiedAt": this.modifiedAt.toString(),
      "sprints": sprintsToJson(this.sprints),
    };
  }

  Map<String, dynamic> sprintsToJson(List<Sprint> sprintList) {
    Map<String, dynamic> result = {};

    for (var i = 0; i < sprintList.length; i++) {
      result[i.toString()] = sprintList[i].toJson();
    }

    return result;
  }

  void updateLastSprintEndTime(DateTime timestamp) {
    Sprint lastSprint = this.getLastSprint;
    if (lastSprint != null) {
      print("lastSprint is defined: $lastSprint");
      lastSprint?.updateStopTime(timestamp);
    } else
      print("lastSprint is null: $lastSprint");
  }

  Sprint get getLastSprint => sprints.length > 0 ? sprints[sprints.length - 1] : null;

  Duration get getLastSprintDuration => getLastSprint?.elapsed;

  Duration get getPreviousSprintDuration => sprints[sprints.length - 2]?.elapsed;

  int get numSprints => sprints?.length;

  bool get isRunning => timerService?.isRunning;

  Duration get getCurrentDuration => timerService?.currentDuration;

  Task get getTask => this;

  void addNewSprint(Sprint sprint) => sprints.add(sprint);

  void continueLastSprint(DateTime start, DateTime stop) {
    Sprint lastSprint = this.getLastSprint;

    lastSprint.updateStartTime(start);
    lastSprint.updateStopTime(stop);
  }

  void start() {
    if (isRunning) {
      print('Timer is already running for task $title');

      return;
    }

    print('Starting new timer for task $title');
    timerService.start();
    notifyListeners();
  }

  void stop() {
    if (!isRunning) {
      print('Timer is not currently running for task $title');

      return;
    }

    Duration elapsed = timerService.currentDuration;
    DateTime start = DateTime.now().subtract(elapsed);
    DateTime stop = DateTime.now();
    print('Updating last sprint ->\nStart: $start\nStop: $stop\nElapsed: $elapsed');
    continueLastSprint(start, stop);
    print('Current Sprints: $sprints');

//    notifyListeners();
    timerService?.stop();
  }

  // Reset the clock and start a new Sprint
  void lap() {
    Duration elapsed = getCurrentDuration;
    bool wasRunning = isRunning;

    if (elapsed.inSeconds < 1) {
      print('Less than 1 second elapsed. Resetting...');
      timerService.reset();
      return;
    }

    DateTime start = DateTime.now().subtract(elapsed);
    DateTime stop = DateTime.now();
    print('Adding new Sprint ->\nStart: $start\nStop: $stop\nElapsed: $elapsed');
    addNewSprint(new Sprint(start, stop));
    print('Current Sprints: $sprints');
    timerService.reset();
    if (wasRunning) timerService.start();
    notifyListeners();
  }

  void reset() {
    timerService.reset();
    notifyListeners();
  }

  void onUpdateTimer() => notifyListeners();

  String toString() => 'TASK: { title: $title, description: $description, numSprints: $numSprints, lastTime: $getLastSprintDuration, createdAt: $createdAt }';
}

/// A representation of what will be a tabular display of Start, Stop, and Duration values of all [Sprint] in [Task.sprints]
class TaskHistory {
  List<Map> history;

  TaskHistory(Task task) {
    history = task.sprints.map((sprint) {
      return {'start': sprint.startTime, 'stop': sprint.stopTime, 'elapsed': sprint.elapsed};
    }).toList();
  }
}

/// A representation of Insights gleamed by performing various calculations on a particular [Task]s [Task.sprints] History
class TaskInsight {
  String abstract;
  ChartType chartType;
  Map<String, dynamic> dataPoints;
}

/// The type of chart that should be used to display [TaskInsight.dataPoints]
enum ChartType {
  BarGraph,
  LineGraph,
  Curve,
}
