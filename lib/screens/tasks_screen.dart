import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:provider/provider.dart';

import '../widgets/screen.dart';
import '../widgets/task_card.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCollection>(
      builder: (context, taskCollection, child) => Screen(
        title: 'Project Logger',
        body: Container(
          width: double.infinity,
          color: Colors.white,
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
                      child: Divider(
                        height: 3,
                        color: Theme.of(context).textTheme.subtitle.color,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
                width: double.infinity,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: taskCollection.totalTasks,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskCard(task: taskCollection.getTasks[index]);
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
