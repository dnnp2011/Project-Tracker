import 'package:flutter/material.dart';
import 'package:project_logger/models/Task.dart';
import 'package:project_logger/widgets/new_task_form.dart';

void _defaultGoBack(BuildContext context) => Navigator.pop(context);

class Screen extends StatelessWidget {
  Widget body;
  String title;
  Function onPressFab;
  Function onPressBack;
  Widget appbarBackButton;
  Function newTaskListener;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//  Screen({this.body, this.title, this.appbarBackButton, this.onPressBack = _defaultGoBack, this.onPressFab});
  Screen({Widget body, String title, dynamic appbarBackButton, Function onPressBack, Function onPressFab, Function newTaskHandler}) {
    this.body = body;
    this.title = title;
    this.appbarBackButton = appbarBackButton;
    this.onPressFab = onPressFab;
    this.onPressBack = onPressBack;
    this.newTaskListener = newTaskHandler;
  }

  void openNewTaskForm(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(),
        shape: RoundedRectangleBorder(),
      ).then((result) {
        if (result == null) return print('No task created');

        print('New Task ${result?.title} ${result?.description}');
        if (newTaskListener != null) newTaskListener(new Task(title: result.title, description: result.description));
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: onPressFab != null ? () => onPressFab(context) : () => openNewTaskForm(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 36,
          ),
          backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          focusColor: Theme.of(context).floatingActionButtonTheme.focusColor,
          elevation: Theme.of(context).floatingActionButtonTheme.elevation,
        ),
      ),
      body: body,
    );
  }
}
