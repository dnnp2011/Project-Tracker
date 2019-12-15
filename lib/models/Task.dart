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

  Task({@required title, @required description}) {
    this.title = title;
    this.description = description;
    this.createdAt = DateTime.now();
    this.modifiedAt = DateTime.now();
    this.sprints = [];
    this.timerService = new TimerService();
    this.timerService.addListener(this.onUpdateTimer);
  }

  Sprint get getLastSprint => sprints.length > 0 ? sprints[sprints.length - 1] : null;

  Duration get getLastSprintDuration => getLastSprint?._elapsed;

  Duration get getPreviousSprintDuration => sprints[sprints.length - 2]?._elapsed;

  int get numSprints => sprints?.length;

  bool get isRunning => timerService?.isRunning;

  Duration get getCurrentDuration => timerService?.currentDuration;

  Task get getTask => this;

  void addNewSprint(Sprint sprint) => sprints.add(sprint);

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
    print('Adding new Sprint ->\nStart: $start\nStop: $stop\nElapsed: $elapsed');
    sprints?.add(new Sprint(start, stop));
    addNewSprint(new Sprint(start, stop));
    print('Current Sprints: $sprints');

//    print('Stopping Timer at $getLastSprintDuration');

    timerService?.stop();
    notifyListeners();
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

/// A single [Task] session, represented by when the [Task] was started([_startTime]), stopped([_stopTime]), and the total [elapsed] time
class Sprint {
  DateTime _startTime;
  DateTime _stopTime;
  Duration _elapsed;

  Duration get elapsed => _elapsed ?? _stopTime.difference(_startTime);

  Sprint(this._startTime, this._stopTime) : _elapsed = _stopTime.difference(_startTime);
}

/// A representation of what will be a tabular display of Start, Stop, and Duration values of all [Sprint] in [Task.sprints]
class TaskHistory {
  List<Map> history;

  TaskHistory(Task task) {
    history = task.sprints.map((sprint) {
      return {'start': sprint._startTime, 'stop': sprint._stopTime, 'elapsed': sprint._elapsed};
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

//void main() {
//  final timerService = TimerService();
//  runApp(
//    TimerServiceProvider( // provide timer service to all widgets of your app
//      service: timerService,
//      child: MyApp(),
//    ),
//  );
//}
