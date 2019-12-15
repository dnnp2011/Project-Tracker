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
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  SizedBox(height: 6),
                  Card(
                    color: Colors.white70,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://www.pinclipart.com/picdir/middle/293-2933849_graph-clipart-bar-graph-png-download.png'),
                          fit: BoxFit.contain,
                        ),
                        shape: BoxShape.circle,
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
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  SizedBox(height: 6),
                  Expanded(
                    child: Card(
                      color: Colors.white70,
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Container(
                              height: 20,
                              width: double.infinity,
                              color: Colors.black26.withOpacity(0.3),
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
