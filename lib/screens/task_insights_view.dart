import 'package:flutter/material.dart';

import '../models/Task.dart';

class TaskHistoryScreen extends StatelessWidget {
  Task task;

  TaskHistoryScreen(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Statistics:',
                  ),
                  SizedBox(height: 6),
                  Card(
                    child: Container(
                      height: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Placeholder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'History:',
                  ),
                  SizedBox(height: 6),
                  Expanded(
                    child: Card(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Container(
                              height: 20,
                              width: double.infinity,
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Start'),
                                  Text('Stop'),
                                  Text('Duration'),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
