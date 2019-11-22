import 'package:flutter/material.dart';

import '../models/Task.dart';

class TaskCard extends StatelessWidget {
  Task task;

  TaskCard({this.task});

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
    return GestureDetector(
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
                ),
                Text(
                  task.description,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
