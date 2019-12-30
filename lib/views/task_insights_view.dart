import 'package:Sprintz/models/Sprint.dart';
import 'package:Sprintz/themes/theme.dart';
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
              padding: Constants.defaultPaddingEdgeInset,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Overview:',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Constants.columnSpacer,
                  Card(
                    child: Container(
                      height: Constants.taskChartContainerSize,
                      margin: Constants.cardPaddingEdgeInset,
                      child: charts.BarChart(
                        List.generate(
                          this.task.sprints.length <= Constants.taskChartMaxGraphedSprints ? this.task.sprints.length : Constants.taskChartMaxGraphedSprints,
                          (int index) {
                            return charts.Series<Sprint, String>(
                              data: [this.task.sprints.reversed.toList()[index]],
                              colorFn: (_, __) => ThemeColors.chartSecondary,
                              domainFn: (Sprint sprint, _) => index.toString(),
                              measureFn: (Sprint sprint, _) => sprint.elapsed.inMilliseconds,
                              id: 'Sprint Duration',
                              displayName: "Sprint Duration",
                            );
                          },
                        ),
                      ),
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
