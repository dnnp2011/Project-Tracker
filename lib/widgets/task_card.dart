import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:project_tracker/themes/android_theme.dart';
import 'package:provider/provider.dart';

import '../models/Task.dart';

class TaskCard extends StatelessWidget {
  Task task;
  int index;
  GlobalKey<AnimatedListState> animatedListKey;

  TaskCard({this.task, this.index, this.animatedListKey});

  void handleOnTap(BuildContext context) async {
    print('Tapped Task');
    print(task ?? 'Task is null');

    final newTask = await Navigator.pushNamed(
      context,
      '/task',
      arguments: {'task': task},
    );

    if (newTask != null) print('New Task $newTask returned from ActiveTask');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCollection>(
      builder: (context, taskCollection, child) => Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          print('Dismissing ${this.task}');

          /// The dismiss animation is already handled by Dismissable
          animatedListKey.currentState.removeItem(this.index, (context, animation) => null);
          taskCollection.removeTask(this.task);

          Scaffold.of(context).showSnackBar(
            SnackBar(
              action: SnackBarAction(
                label: "Undo",
                onPressed: () {
                  print('Re-inserting ${this.task}');
                  animatedListKey.currentState.insertItem(this.index);
                  taskCollection.addTask(this.task);
                },
              ),
              content: Text("Dismissed ${this.task.title}"),
            ),
          );
        },
        background: Container(color: ThemeColors.error),
        child: GestureDetector(
          onTap: () => handleOnTap(context),
          child: Card(
            color: Theme.of(context).cardTheme.color,
            margin: EdgeInsets.all(7.0),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      task.description,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      key: UniqueKey(),
    );
  }
}
