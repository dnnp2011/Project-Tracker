import 'package:flutter/material.dart';
import 'package:project_logger/models/Task.dart' show Task;
import 'package:project_logger/models/TaskHandler.dart';
import 'package:project_logger/widgets/screen.dart';
import 'package:project_logger/widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  List<Task> tasks = <Task>[];

  TaskListScreen(_);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> implements TaskHandler {
  void removeTask(Task task) {
    widget.tasks.remove(task);
    var newTasks = new List.from(widget.tasks);

    assert(newTasks is List<Task>, 'newTasks is not the right type: ${newTasks.runtimeType.toString()}');
    setState(() {
      widget.tasks = newTasks;
    });
  }

  void addTask(Task task) {
    print('invoking addTask()');
//    assert(task != null, 'addTask() -> task is null');
    assert(widget.tasks != null, 'widget.tasks is null');
//    assert(widget.tasks.add is Function, 'widget.tasks.add is not a function');

    assert(widget.tasks.add is Function, 'add is not a function');
    widget.tasks.add(task);
    assert(widget.tasks.contains(task), 'widget.tasks doesn\'t contain the new task');
    print('list adding complete');

    setState(() {
      widget.tasks = widget.tasks;
    });
  }

  @override
  void handleNewTask(Task task) {
    print('handling new task');
    assert(task != null, 'handleNewTask() -> task is null');
    assert(widget.tasks != null, 'widget.tasks is null');
    addTask(task);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('Calling didChangeDependencies()');
    assert(context != null, 'Context is null');
    assert(ModalRoute.of(context) != null, 'ModalRoute.of(context) is null');
    var args = ModalRoute.of(context).settings.arguments as Map;

    if (widget.tasks.isEmpty) {
      print('tasks is empty, adding default task');
      setState(() {
        widget.tasks = [new Task(title: 'Test Task', description: 'Test Task')];
      });
    }

    if (args != null) print('args: $args');
    if (args != null && args['task'] != null) print('task: ${args['task']}');

    if (args != null && args['task'] != null) {
      var newTask = args['task'];
      print('ctor newTask: $newTask');
      print('widget: $widget');
      addTask(newTask as Task);
    } else {
      print('No Tasks being returned from ModalRoute');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding - tasks: ${widget.tasks}');
    return Screen(
      newTaskHandler: handleNewTask,
      title: 'Project Logger',
      body: Container(
        width: double.infinity,
        color: Colors.white,
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
                    child: Divider(
                      height: 3,
                      color: Theme.of(context).textTheme.subtitle.color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
              width: double.infinity,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.tasks?.length ?? 0,
                itemBuilder: (BuildContext ctxt, int index) {
                  return TaskCard(task: widget.tasks[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
