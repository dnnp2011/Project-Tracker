import 'package:flutter/material.dart';

import '../models/Task.dart' show Task, TaskInsight;
import '../screens/task_history_screen.dart';
import '../themes/android_theme.dart';
import '../widgets/active_task.dart' show ActiveTask;
import '../widgets/screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  Task task;
  Widget currentWidget;
  Widget timerWidget;
  Widget insightsWidget;

  TaskDetailsScreen(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    assert(args['task'] != null, 'TaskDetailsScreen constructor - Route Arguments.task is null!');
    this.task = args['task'] as Task;
    timerWidget = ActiveTask(task);
    insightsWidget = TaskHistoryScreen(task);
    currentWidget = timerWidget;

    print(task.toString());
  }

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
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
