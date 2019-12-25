import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget Fab(BuildContext context, Function openNewTaskForm) => Container(
      height: 60,
      width: 60,
      child: FittedBox(
        fit: BoxFit.contain,
        child: FloatingActionButton(
          onPressed: () => openNewTaskForm(context),
          child: Icon(
            Icons.add,
            size: 38,
          ),
        ),
      ),
    );
