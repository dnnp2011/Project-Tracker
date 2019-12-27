import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_tracker/themes/theme.dart';

import '../models/Task.dart';

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
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: Constants.defaultPaddingEdgeInset,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Current Task:',
                style: Theme.of(context).textTheme.subtitle,
              ),
              Constants.columnSpacer,
              Card(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: Constants.defaultPadding,
                    left: Constants.defaultPadding,
                    bottom: Constants.defaultPadding,
                    top: 3,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.task.title,
                            style: Theme.of(context).textTheme.body2,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(360),
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Material(
                                color: Colors.transparent,
                                child: Tooltip(
                                  message: "Edit task details",
                                  child: InkResponse(
                                    containedInkWell: true,
                                    radius: 48,
                                    onTap: () => print("Tapped ink response"),
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Constants.columnSpacer,
                      Text(
                        widget.task.description,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: Constants.taskStopwatchIconSize,
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
                          margin: Constants.defaultPaddingEdgeInset,
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
                          margin: Constants.defaultPaddingEdgeInset,
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
            ],
          ),
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
