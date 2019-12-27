import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:project_tracker/themes/theme.dart';
import 'package:project_tracker/widgets/fab.dart';
import 'package:project_tracker/widgets/new_task_form.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/task_card.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool darkModeEnabled = true;

class TasksScreen extends StatelessWidget {
  GlobalKey<AnimatedListState> _animatedListKey;
  TapGestureRecognizer tapGestureRecognizer;

  TasksScreen(animatedListKey) {
    this._animatedListKey = animatedListKey;
    TapGestureRecognizer()..onTap = () => this._launchURL('https://sleeplessdev.io');
  }

  void openNewTaskForm(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(animatedListKey: _animatedListKey),
        shape: RoundedRectangleBorder(),
      );

  void _launchURL(String url) async {
    print("Launching URL");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCollection>(builder: (context, taskCollection, child) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Task Details"),
        ),
        endDrawer: Drawer(
          key: UniqueKey(),
          semanticLabel: "Settings Menu",
          elevation: 24,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: ThemeColors.dp24,
            child: Padding(
              padding: Constants.defaultPaddingEdgeInset,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      SwitchListTile(
                        onChanged: (bool value) {
                          print("Clicked Slider");
                          darkModeEnabled = !darkModeEnabled;
                        },
                        value: darkModeEnabled,
                        title: Text("Dark Mode"),
                        activeColor: ThemeColors.secondaryDp24,
                        inactiveThumbColor: Colors.white,
                        secondary: Icon(
                          Icons.lightbulb_outline,
                          color: ThemeColors.secondaryDp24,
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '',
                      semanticsLabel: "Built by sleeplessdev.io",
                      children: [
                        TextSpan(
                          text: "Built by\n",
                          style: Theme.of(context).textTheme.overline,
                        ),
                        TextSpan(
                          text: "sleeplessdev.io",
                          style: Theme.of(context).textTheme.subhead,
                          recognizer: tapGestureRecognizer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => Fab(context, this.openNewTaskForm),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your Tasks',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Container(
                      width: 100,
                      child: Divider(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
                width: double.infinity,
              ),
              Expanded(
                child: AnimatedList(
                  key: _animatedListKey,
                  initialItemCount: taskCollection.totalTasks,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      position: animation.drive(Animations.slideInFromLeft),
                      child: TaskCard(task: taskCollection.tasks[index], index: index, animatedListKey: _animatedListKey),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
