import 'package:flutter/material.dart';
import 'package:project_tracker/themes/android_theme.dart';

import '../models/Task.dart';

/// TODO: Rebuild the TimerService from scratch given what I now know of the requirements in this Widget
/// TODO: Start small by creating a local Periodic to drive to Timer, then move to more complex management schemes

class ActiveTask extends StatefulWidget {
  Task task;

  bool get isTimerRunning => task.timerService.isRunning;
  Duration currentTime;

  ActiveTask(this.task) : currentTime = task.getLastSprintDuration ?? Duration(hours: 0, minutes: 0, seconds: 0);

  @override
  _ActiveTaskState createState() => _ActiveTaskState();
}

class _ActiveTaskState extends State<ActiveTask> {
  @override
  void initState() {
    super.initState();

    widget.task.addListener(handleUpdateTimer);
  }

  void handleUpdateTimer() {
    setState(() {
      widget.currentTime = widget.task.getCurrentDuration;
    });
  }

  /// Stop the running timer if User leaves page without manually stopping it
  void dispose() {
    super.dispose();

    print('ActiveTask.dispose()');
    widget.task.stop();
    widget.task.removeListener(handleUpdateTimer);
  }

  /// Initiate the Periodic Timer
  void start() {
    print('ActiveTask.start()');
    widget.task.start();
  }

  /// Pause execution of the current Periodic Timer, also store the run Duration to the Task instance
  void stop() {
    print('ActiveTask.stop()');
    widget.task.stop();
  }

  /// If there is a currently running Periodic, stop it, then initiate a new Periodic Timer from DateTime.now()
  void lap() {
    print('ActiveTask.lap()');
    widget.task.lap();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(MediaQuery.of(context).size),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.access_time,
              size: 200,
              color: ThemeColors.primaryLight,
            ),
            Text(
              widget.currentTime.toString().substring(0, 10) ?? '00:00:00',
              style: Theme.of(context).textTheme.display3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(13),
                  child: !widget.isTimerRunning
                      ? RaisedButton(
                          child: Text(
                            'Start',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          onPressed: start,
                        )
                      : RaisedButton(
                          child: Text(
                            'Stop',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          onPressed: stop,
                        ),
                ),
                Container(
                  margin: EdgeInsets.all(13),
                  child: RaisedButton(
                    child: Text(
                      'Lap',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    onPressed: lap,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget TaskSummary(BuildContext context, Task task) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Text(
            'Your Task:',
          ),
        ),
        SizedBox(
          height: 3,
          width: double.infinity,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 80),
            child: Card(
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
