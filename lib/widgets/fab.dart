import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget Fab(BuildContext context, Function openNewTaskForm) => Container(
      height: 70,
      width: 70,
      child: FittedBox(
        fit: BoxFit.contain,
        child: FloatingActionButton(
          onPressed: () => openNewTaskForm(context),
          child: Icon(
            Icons.add,
            size: 48,
          ),
          backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          focusColor: Theme.of(context).floatingActionButtonTheme.focusColor,
          elevation: Theme.of(context).floatingActionButtonTheme.elevation,
        ),
      ),
    );
