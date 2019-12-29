import 'package:Sprintz/themes/theme.dart';
import 'package:Sprintz/utility/better_modal_bottom_sheet.dart';
import 'package:Sprintz/views/side_drawer_view.dart';
import 'package:Sprintz/widgets/fab.dart';
import 'package:Sprintz/widgets/new_task_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/Task.dart' show Task;
import '../views/active_task_view.dart' show ActiveTask;
import '../views/task_insights_view.dart';

class TaskDetailsScreen extends StatefulWidget {
  Task task;
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
  }

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetailsScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  void openNewTaskForm(BuildContext context) => showBetterModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(
          animatedListKey: widget.animatedListKey,
        ),
      );

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Task Details"),
      ),
      endDrawer: SideDrawer(),
      floatingActionButton: Builder(
        builder: (context) => Fab(context, this.openNewTaskForm),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TabBar(
            controller: _tabController,
            indicatorColor: ThemeColors.secondary,
            tabs: <Tab>[
              Tab(
                icon: Icon(
                  Icons.timer,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.assessment,
                ),
              ),
            ],
          ),
          Flexible(
            fit: FlexFit.loose,
            child: TabBarView(
              children: <Widget>[
                widget.timerWidget,
                widget.insightsWidget,
              ],
              controller: _tabController,
              physics: ClampingScrollPhysics(),
              key: UniqueKey(),
              dragStartBehavior: DragStartBehavior.start,
            ),
          ),
        ],
      ),
    );
  }
}

enum ActivePage {
  timer,
  insights,
}
