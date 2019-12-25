// Flutter code sample for

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:project_tracker/themes/android_theme.dart';
import 'package:provider/provider.dart';

import './screens/task_details_screen.dart';
import './screens/tasks_screen.dart';

final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey<AnimatedListState>();

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => TaskCollection(),
        child: ProjectLogger(),
      ),
    );

class ProjectLogger extends StatelessWidget {
  static const String _title = 'Project Logger';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ProjectTheme.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => TasksScreen(_animatedListKey),
        '/task': (context) => TaskDetailsScreen(context, _animatedListKey),
      },
    );
  }
}
