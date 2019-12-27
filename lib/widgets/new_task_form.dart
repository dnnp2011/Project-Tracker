import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_tracker/models/TaskCollection.dart';
import 'package:project_tracker/themes/theme.dart';
import 'package:provider/provider.dart';

import '../models/Task.dart';
import '../widgets/styled_form_field.dart';

class NewTaskForm extends StatefulWidget {
  GlobalKey<AnimatedListState> animatedListKey;
  bool _showTitleError = false;
  bool _showDescriptionError = false;

  NewTaskForm({this.animatedListKey});

  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();

  String validateInput(dynamic value) {
    setState(() {
      widget._showDescriptionError = false;
      widget._showTitleError = false;
    });

    if (value.isEmpty)
      return 'Field cannot be blank';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCollection>(
      builder: (context, taskCollection, child) => Container(
        color: ThemeColors.dp12,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: Constants.defaultPaddingEdgeInset,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Create New Task',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        Container(
                          width: 160,
                          child: Divider(
                            color: ThemeColors.secondaryDp16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Title:',
                            style: Theme.of(context).textTheme.body2,
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        styledFormField(
                          context: context,
                          controller: titleController,
                          validator: validateInput,
                          nextFocusNode: descriptionFocusNode,
                          textInputType: TextInputType.text,
                          showError: widget._showTitleError,
                          fixedHeight: 68,
                          errorMsg: 'Title required',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Description:',
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ),
                        styledFormField(
                            context: context,
                            controller: descriptionController,
                            validator: validateInput,
                            textInputType: TextInputType.text,
                            showError: widget._showDescriptionError,
                            fixedHeight: 68,
                            focusNode: descriptionFocusNode,
                            errorMsg: 'Description required'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.bottomRight,
                      child: OutlineButton(
                        onPressed: () {
                          setState(() {
                            widget._showTitleError = titleController.text.isEmpty;
                            widget._showDescriptionError = descriptionController.text.isEmpty;
                          });

                          if (widget._showTitleError || widget._showDescriptionError) return;

                          final Task newTask = new Task(title: titleController.text, description: descriptionController.text);
                          assert(widget.animatedListKey is GlobalKey<AnimatedListState>);
                          widget.animatedListKey.currentState.insertItem(taskCollection.totalTasks);
                          taskCollection.addTask(newTask);
                          print("Inserting ${newTask.toString()}");
                          Navigator.pop(context);
                        },
                        color: ThemeColors.secondaryDp16,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        borderSide: BorderSide(color: ThemeColors.secondaryDp16, width: 2),
                        child: Text(
                          'Create',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
