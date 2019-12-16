import 'package:flutter/material.dart';

import '../models/Task.dart';
import '../themes/android_theme.dart';

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
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 1, child: TaskSummary(context, widget.task)),
          SizedBox(
            height: 25,
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Text(
                    'Task Timer:',
                    style: Theme.of(context).primaryTextTheme.subtitle,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Icon(
                              Icons.access_time,
                              color: ThemeColors.dark,
                              size: 200,
                              semanticLabel: 'Clock Icon',
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              widget.currentTime.toString().substring(0, 10) ?? '00:00:00',
                              style: Theme.of(context).textTheme.display3,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    margin: EdgeInsets.all(13),
                                    child: !widget.isTimerRunning
                                        ? RaisedButton(
                                            child: Text(
                                              'Start',
                                              style: Theme.of(context).textTheme.button,
                                            ),
                                            onPressed: start,
                                          )
                                        : RaisedButton(
                                            child: Text(
                                              'Stop',
                                              style: Theme.of(context).textTheme.button,
                                            ),
                                            onPressed: stop,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    margin: EdgeInsets.all(13),
                                    child: RaisedButton(
                                      child: Text(
                                        'Lap',
                                        style: Theme.of(context).textTheme.button,
                                      ),
                                      onPressed: lap,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            style: Theme.of(context).primaryTextTheme.subtitle,
          ),
        ),
        SizedBox(
          height: 3,
          width: double.infinity,
        ),
        Expanded(
          child: Container(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(task.description),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
