import 'package:Sprintz/models/TaskCollection.dart';
import 'package:Sprintz/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/task_details_screen.dart';
import './screens/tasks_screen.dart';

final GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
TaskCollection taskCollection = TaskCollection(animatedListKey);

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) {
          return taskCollection;
        },
        child: ProjectLogger(),
      ),
    );

class ProjectLogger extends StatelessWidget {
  static const String _title = 'Sprintz';

  @override
  Widget build(BuildContext context) {
    this.configureLifecycleHook();

    return MaterialApp(
      title: _title,
      theme: ProjectTheme.dark(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => TasksScreen(animatedListKey),
        '/task': (context) => TaskDetailsScreen(context, animatedListKey),
      },
    );
  }

  /// Hooks into the App's Lifecycle State in order to save changes to Tasks that have not yet been stored
  void configureLifecycleHook() {
    SystemChannels.lifecycle.setMessageHandler((String lifecycleString) {
      AppLifecycleState lifecycle = AppLifecycleState.values.firstWhere((e) => e.toString() == lifecycleString);
      assert(lifecycle != null, "String '$lifecycleString' could not be cast to AppLifecycleState");

      switch (lifecycle) {
        case AppLifecycleState.resumed: // Triggers once the app is active again, iOS and Android
          print("RESUMING");
          taskCollection.getTasksFromDeviceStorage(animatedListKey);
          break;
        case AppLifecycleState.paused: // Triggers when app is moved to the background, iOS and Android
          print("PAUSED");
          taskCollection.saveTasksToDeviceStorage();
          break;
        case AppLifecycleState.inactive: // Triggers when app goes into an inactive state, iOS only
          print("INACTIVE");
          break;
        case AppLifecycleState.detached:
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
