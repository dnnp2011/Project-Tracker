import 'package:flutter/material.dart';
import 'package:project_tracker/widgets/fab.dart';
import 'package:project_tracker/widgets/new_task_form.dart';

import '../models/Task.dart' show Task, TaskInsight;
import '../screens/task_insights_view.dart';
import '../themes/android_theme.dart';
import 'active_task_view.dart' show ActiveTask;

class TaskDetailsScreen extends StatefulWidget {
  Task task;
  Widget currentWidget;
  Widget timerWidget;
  Widget insightsWidget;
  GlobalKey<AnimatedListState> animatedListKey;

  TaskDetailsScreen(BuildContext context, GlobalKey<AnimatedListState> animatedListKey) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    assert(args['task'] != null, 'TaskDetailsScreen constructor - Route Arguments.task is null!');
    this.task = args['task'] as Task;
    this.animatedListKey = animatedListKey;
    timerWidget = ActiveTask(task);
    insightsWidget = TaskHistoryScreen(task);
    currentWidget = timerWidget;

    print(task.toString());
  }

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openNewTaskForm(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(
          animatedListKey: widget.animatedListKey,
        ),
        shape: RoundedRectangleBorder(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Task Details"),
      ),
      floatingActionButton: Builder(
        builder: (context) => Fab(context, this.openNewTaskForm),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
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
            flex: 32,
            child: widget.currentWidget,
          ),
        ],
      ),
    );
  }
}
