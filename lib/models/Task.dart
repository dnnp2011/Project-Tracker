import 'package:flutter/foundation.dart' show required;

import '../services/TimerService.dart';

/// A data representation of time spent on a single task, spread throughout some number of "[_Sprint]s" (ie. sessions)
class Task {
  String title;
  String description;
  DateTime createdAt;
  DateTime modifiedAt;
  TimerService timerService;
  List<_Sprint> sprints;

  Task({@required title, @required description}) {
    this.title = title;
    this.description = description;
    this.createdAt = DateTime.now();
    this.modifiedAt = DateTime.now();
    this.sprints = [];
    this.timerService = new TimerService();
  }

  _Sprint get getLastSprint => sprints.length > 0 ? sprints[sprints.length - 1] : null;
  Duration get getLastSprintDuration => getLastSprint?._elapsed;
  Duration get getPreviousSprintDuration => sprints[sprints.length - 2]?._elapsed;
  int get numSprints => sprints?.length;
  bool get isRunning => timerService?.isRunning;
  Duration get getCurrentDuration => timerService?.currentDuration;
  Task get getTask => this;
  void addNewSprint(_Sprint sprint) => sprints.add(sprint);

  void start() {
    if (isRunning) {
      print('Timer is already running for task $title');

      return;
    }

    print('Starting new timer for task $title');
//    this.sprints.add(new _Sprint())
    timerService.start();
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
    sprints?.add(new _Sprint(start, stop));
    addNewSprint(new _Sprint(start, stop));
    print('Current Sprints: $sprints');

//    print('Stopping Timer at $getLastSprintDuration');

    timerService?.stop();
  }

  // Reset the clock and start a new Sprint
  void lap() {
    Duration elapsed = getCurrentDuration;
    if (!isRunning) {
      timerService.reset();

      return;
    }

    DateTime start = DateTime.now().subtract(elapsed);
    DateTime stop = DateTime.now();
    print('Adding new Sprint ->\nStart: $start\nStop: $stop\nElapsed: $elapsed');
    addNewSprint(new _Sprint(start, stop));
    print('Current Sprints: $sprints');
    timerService.reset();
    timerService.start();
  }

  void reset() => timerService.reset();

  void subscribe(onUpdateTimer) => timerService.addListener(onUpdateTimer);

  void unsubscribe(onUpdateTimer) => timerService.removeListener(onUpdateTimer);

  String toString() =>
      'TASK: { title: $title, description: $description, numSprints: $numSprints, lastTime: $getLastSprintDuration, createdAt: $createdAt }';
}

/// A single [Task] session, represented by when the [Task] was started([_startTime]), stopped([_stopTime]), and the total [elapsed] time
class _Sprint {
  DateTime _startTime;
  DateTime _stopTime;
  Duration _elapsed;
  Duration get elapsed => _elapsed ?? _stopTime.difference(_startTime);

  _Sprint(this._startTime, this._stopTime) : _elapsed = _stopTime.difference(_startTime);
}

/// A representation of what will be a tabular display of Start, Stop, and Duration values of all [_Sprint] in [Task.sprints]
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
