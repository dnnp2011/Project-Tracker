import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:project_tracker/themes/theme.dart';
import 'package:provider/provider.dart';

import '../models/Task.dart';

class TaskCard extends StatelessWidget {
  Task task;
  int index;
  GlobalKey<AnimatedListState> animatedListKey;

  TaskCard({this.task, this.index, this.animatedListKey});

  void handleOnTap(BuildContext context) => Navigator.pushNamed(
        context,
        '/task',
        arguments: {'task': task},
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCollection>(
      key: UniqueKey(),
      builder: (context, taskCollection, child) => Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          print('Deleting ${this.task}');

          animatedListKey.currentState.removeItem(this.index, (context, animation) => null);
          taskCollection.removeTask(this.task);

          Scaffold.of(context).showSnackBar(
            SnackBar(
              action: SnackBarAction(
                textColor: Colors.white,
                label: "Undo",
                onPressed: () {
                  print('Recovered ${this.task}');
                  animatedListKey.currentState.insertItem(this.index);
                  taskCollection.addTask(this.task);
                },
              ),
              content: Text("Deleted ${this.task.title}"),
            ),
          );
        },
        background: Container(color: ThemeColors.error),
        child: Container(
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            child: ListTile(
              key: ValueKey(this.task),
              onTap: () => this.handleOnTap(context),
              leading: Container(
                height: double.infinity,
                child: Icon(
                  Icons.assignment,
                  size: 35,
                  color: ThemeColors.secondaryDp2,
                ),
              ),
              title: Text(
                this.task.title,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                this.task.description,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
