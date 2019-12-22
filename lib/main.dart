// Flutter code sample for

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:provider/provider.dart';

import './screens/task_details_screen.dart';
import './screens/tasks_screen.dart';
import './themes/android_theme.dart';

final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey<AnimatedListState>();

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => TaskCollection(),
        child: ProjectLogger(),
      ),
    );

/// This Widget is the main application widget.
class ProjectLogger extends StatelessWidget {
  static const String _title = 'Project Logger';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: projectTheme(),
      initialRoute: '/',
      darkTheme: ThemeData.dark(),
      routes: {
        '/': (context) => TasksScreen(_animatedListKey),
        '/task': (context) => TaskDetailsScreen(context, _animatedListKey),
      },
    );
  }
}

//final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));
