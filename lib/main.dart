// Flutter code sample for

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './screens/task_list_screen.dart';
import './screens/task_screen.dart';
import './themes/android_theme.dart';

void main() => runApp(ProjectLogger());

/// This Widget is the main application widget.
class ProjectLogger extends StatelessWidget {
  static const String _title = 'Project Logger';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: projectTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => TaskListScreen(context),
        '/task': (context) => TaskScreen(context),
      },
    );
  }
}

//final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
