import 'package:flutter/material.dart';
import 'package:project_logger/models/Task.dart' show Task, TaskInsight;
import 'package:project_logger/models/TaskHandler.dart';
import 'package:project_logger/screens/task_history_screen.dart';
import 'package:project_logger/themes/android_theme.dart';
import 'package:project_logger/widgets/active_task.dart' show ActiveTask;
import 'package:project_logger/widgets/screen.dart';

class TaskScreen extends StatefulWidget {
  Task task;
  Widget currentWidget;
  Widget timerWidget;
  Widget insightsWidget;

  TaskScreen(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    assert(args['task'] != null, 'TaskScreen constructor - Route Arguments.task is null!');
    this.task = args['task'] as Task;
    timerWidget = ActiveTask(task);
    insightsWidget = TaskHistoryScreen(task);
    currentWidget = timerWidget;

    print(task.toString());
  }

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> implements TaskHandler {
  @override
  void handleNewTask(Task task) {
    assert(task != null, 'TaskScreenState handleNewTask() -> task is null');

    Navigator.pushReplacementNamed(context, '/', arguments: {'task': task});
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      newTaskHandler: handleNewTask,
      title: 'Active Task',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () => setState(() {
                      widget.currentWidget = widget.timerWidget;
                    }),
                    color: Colors.transparent,
                    splashColor: ThemeColors.primaryLight,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Timer',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Container(
                          width: 75,
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(context).textTheme.subtitle.color,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () => setState(() {
                      widget.currentWidget = widget.insightsWidget;
                    }),
                    color: Colors.transparent,
                    splashColor: ThemeColors.primaryLight,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Insights',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Container(
                          width: 75,
                          child: Divider(
                            thickness: 1,
                            color: Theme.of(context).textTheme.subtitle.color,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 18,
            child: Container(
              height: double.infinity,
              child: widget.currentWidget,
            ),
          ),
        ],
      ),
    );
  }
}
