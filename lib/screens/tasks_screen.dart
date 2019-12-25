import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:project_tracker/themes/android_theme.dart';
import 'package:project_tracker/widgets/fab.dart';
import 'package:project_tracker/widgets/new_task_form.dart';
import 'package:provider/provider.dart';

import '../widgets/task_card.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class TasksScreen extends StatelessWidget {
  GlobalKey<AnimatedListState> _animatedListKey;

  TasksScreen(animatedListKey) {
    this._animatedListKey = animatedListKey;
  }

  void openNewTaskForm(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(animatedListKey: _animatedListKey),
        shape: RoundedRectangleBorder(),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCollection>(
      builder: (context, taskCollection, child) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Project Logger"),
        ),
        floatingActionButton: Builder(
          builder: (context) => Fab(context, this.openNewTaskForm),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Tasks',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Container(
                      width: 100,
                      child: Divider(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
                width: double.infinity,
              ),
              Expanded(
//                child: ListView.builder(
//                  scrollDirection: Axis.vertical,
//                  itemCount: taskCollection.totalTasks,
//                  itemBuilder: (BuildContext context, int index) {
//                    return TaskCard(task: taskCollection.getTasks[index], context: context);
//                  },
//                ),
                child: AnimatedList(
                  key: _animatedListKey,
                  initialItemCount: taskCollection.totalTasks,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      position: animation.drive(Animations.slideInFromLeft),
                      child: TaskCard(task: taskCollection.getTasks[index], index: index, animatedListKey: _animatedListKey),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
