import 'package:flutter/material.dart';

import '../widgets/new_task_form.dart';

void _defaultGoBack(BuildContext context) => Navigator.pop(context);

class Screen extends StatelessWidget {
  Widget body;
  String title;
  Function onPressFab;
  Function onPressBack;
  Widget appbarBackButton;
  Function newTaskListener;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Screen({Widget body, String title, dynamic appbarBackButton, Function onPressBack, Function onPressFab}) {
    this.body = body;
    this.title = title;
    this.appbarBackButton = appbarBackButton;
    this.onPressFab = onPressFab;
    this.onPressBack = onPressBack;
  }

  void openNewTaskForm(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(),
        shape: RoundedRectangleBorder(),
      );

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
