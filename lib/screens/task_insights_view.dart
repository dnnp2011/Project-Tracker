import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Task.dart';

class TaskHistoryScreen extends StatelessWidget {
  Task task;

  TaskHistoryScreen(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        key: UniqueKey(),
        scrollDirection: Axis.vertical,
        child: ListBody(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Overview:',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  SizedBox(height: 6),
                  Card(
                    child: Container(
                      height: 165,
                      margin: EdgeInsets.all(15),
                      child: charts.BarChart(List.generate(this.task.sprints.length <= 10 ? this.task.sprints.length : 10, (int index) {
                        return charts.Series<Sprint, String>(
                          data: [this.task.sprints.reversed.toList()[index]],
                          colorFn: (_, __) => charts.Color(r: 26, g: 186, b: 134),
                          domainFn: (Sprint sprint, _) => index.toString(),
                          measureFn: (Sprint sprint, _) => sprint.elapsed.inMilliseconds,
                          id: 'Sprint Duration',
                          displayName: "Sprint Duration",
                        );
                      })),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Sprints:',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  SizedBox(height: 6),
                  Container(
                    child: Card(
                        borderOnForeground: true,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 50),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            constraints: BoxConstraints(
                              minWidth: double.infinity,
                            ),
                            child: DataTable(
                              dataRowHeight: 40,
                              columnSpacing: 15,
                              headingRowHeight: 25,
                              rows: List.generate(this.task.sprints.length, (int index) {
                                final reversed = this.task.sprints.reversed.toList();

                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(
                                        reversed[index].elapsed.toString(),
                                        style: Theme.of(context).textTheme.body1,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        reversed[index].formattedLastModified,
                                        style: Theme.of(context).textTheme.body1,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              columns: <DataColumn>[
                                DataColumn(
                                    label: Text(
                                  'Duration',
                                  style: Theme.of(context).textTheme.subhead,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Date',
                                  style: Theme.of(context).textTheme.subhead,
                                )),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
