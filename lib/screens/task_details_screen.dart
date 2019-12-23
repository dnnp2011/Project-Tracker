import 'package:flutter/material.dart';
import 'package:project_tracker/themes/android_theme.dart';
import 'package:project_tracker/widgets/fab.dart';
import 'package:project_tracker/widgets/new_task_form.dart';

import '../models/Task.dart' show Task, TaskInsight;
import '../screens/task_insights_view.dart';
import 'active_task_view.dart' show ActiveTask;

class TaskDetailsScreen extends StatefulWidget {
  Task task;
  Widget timerWidget;
  Widget insightsWidget;
  GlobalKey<AnimatedListState> animatedListKey;
  ActivePage _activePage = ActivePage.timer;

  TaskDetailsScreen(BuildContext context, GlobalKey<AnimatedListState> animatedListKey) {
    var args = ModalRoute.of(context).settings.arguments as Map;
    assert(args['task'] != null, 'TaskDetailsScreen constructor - Route Arguments.task is null!');
    this.task = args['task'] as Task;
    this.animatedListKey = animatedListKey;
    timerWidget = ActiveTask(task);
    insightsWidget = TaskHistoryScreen(task);
  }

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController(initialPage: 0);

  void openNewTaskForm(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext _) => NewTaskForm(
          animatedListKey: widget.animatedListKey,
        ),
        shape: RoundedRectangleBorder(),
      );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_pageController != null && _pageController.hasClients != null) print('Page: ${_pageController?.page}');

    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBackground,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Task Details"),
      ),
      floatingActionButton: Builder(
        builder: (context) => Fab(context, this.openNewTaskForm),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: LimitedBox(
                    maxHeight: 50,
                    maxWidth: MediaQuery.of(context).size.width / 2,
                    child: FlatButton(
                      onPressed: () => setState(() {
                        widget._activePage = ActivePage.timer;
                      }),
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Timer',
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: 75,
                            height: 3,
                            child: Divider(
                              thickness: _pageController?.page == 0 ? 3 : 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: LimitedBox(
                    maxHeight: 50,
                    maxWidth: MediaQuery.of(context).size.width / 2,
                    child: FlatButton(
                      onPressed: () => setState(() {
                        widget._activePage = ActivePage.insights;
                      }),
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Insights',
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: 75,
                            height: 3,
                            child: Divider(
                              thickness: _pageController?.page == 1 ? 3 : 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 32,
            child: LimitedBox(
                maxHeight: 500,
                maxWidth: 400,
                child: PageView.builder(
                  key: UniqueKey(),
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int page) {
                    return page == 0 ? widget.timerWidget : widget.insightsWidget;
                  },
                )),
          ),
        ],
      ),
    );
  }
}

enum ActivePage {
  timer,
  insights,
}
