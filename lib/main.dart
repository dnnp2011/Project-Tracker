// Flutter code sample for

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:project_tracker/themes/theme.dart';
import 'package:provider/provider.dart';

import './screens/task_details_screen.dart';
import './screens/tasks_screen.dart';

final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey<AnimatedListState>();
TaskCollection taskCollection = TaskCollection(_animatedListKey);

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) {
          return taskCollection;
        },
        child: ProjectLogger(),
      ),
    );

class ProjectLogger extends StatelessWidget {
  static const String _title = 'Project Logger';

  @override
  Widget build(BuildContext context) {
    this.configureLifecycleHook();

    return MaterialApp(
      title: _title,
      theme: ProjectTheme.dark(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => TasksScreen(_animatedListKey),
        '/task': (context) => TaskDetailsScreen(context, _animatedListKey),
      },
    );
  }

  /// Hooks into the App's Lifecycle State in order to save changes to Tasks that have not yet been stored
  void configureLifecycleHook() {
    SystemChannels.lifecycle.setMessageHandler((String lifecycleString) {
      debugPrint('SystemChannels State -> $lifecycleString');
      AppLifecycleState lifecycle = AppLifecycleState.values.firstWhere((e) => e.toString() == lifecycleString);
      assert(lifecycle != null, "String '$lifecycleString' could not be cast to AppLifecycleState");

      switch (lifecycle) {
        case AppLifecycleState.resumed:
          print("RESUMING");
          taskCollection.getTasksFromDeviceStorage(_animatedListKey);
          break;
        case AppLifecycleState.inactive:
          print("INACTIVE");
          taskCollection.saveTasksToDeviceStorage();
          break;
        case AppLifecycleState.paused:
          print("PAUSED");
          taskCollection.saveTasksToDeviceStorage();
          break;
        case AppLifecycleState.detached:
          taskCollection.saveTasksToDeviceStorage();
          print("DETACHED");
          break;
        default:
          throw "Invalid AppLifecycleState -> $lifecycleString";
          break;
      }

      return;
    });
  }
}
