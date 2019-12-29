import 'package:Sprintz/models/TaskCollection.dart';
import 'package:Sprintz/themes/theme.dart';
import 'package:Sprintz/utility/better_modal_bottom_sheet.dart';
import 'package:Sprintz/views/side_drawer_view.dart';
import 'package:Sprintz/widgets/fab.dart';
import 'package:Sprintz/widgets/new_task_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/task_card.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool darkModeEnabled = true;

class TasksScreen extends StatelessWidget {
  GlobalKey<AnimatedListState> animatedListKey;

  TasksScreen(this.animatedListKey);

  void openNewTaskForm(BuildContext context) => showBetterModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(animatedListKey: animatedListKey),
//        shape: RoundedRectangleBorder(),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCollection>(builder: (context, taskCollection, child) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Task Details"),
        ),
        endDrawer: SideDrawer(),
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
                child: AnimatedList(
                  key: animatedListKey,
                  initialItemCount: taskCollection.totalTasks,
                  itemBuilder: (context, index, animation) {
                    if (index > taskCollection.totalTasks - 1) {
//                      print("index out of bounds");
//                      print("Index: $index -> Collection Count: ${taskCollection.totalTasks}");
//                      print("Collection: \n${taskCollection.toString()}");
                      return null;
                    }

                    return SlideTransition(
                      position: animation.drive(Animations.slideInFromLeft),
                      child: TaskCard(task: taskCollection.tasks[index], index: index, animatedListKey: animatedListKey),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
