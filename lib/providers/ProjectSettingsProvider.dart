import 'package:flutter/material.dart' show InheritedModel, BuildContext;

class ProjectSettingsProvider extends InheritedModel {
  bool darkModeEnabled;

  ProjectSettingsProvider() {
    // Fetch project settings from storage
    darkModeEnabled = true;
  }

  set setDarkMode(bool value) => darkModeEnabled = value;

  static ProjectSettingsProvider of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<ProjectSettingsProvider>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(ProjectSettingsProvider oldWidget) {
    if (oldWidget.darkModeEnabled != darkModeEnabled) return true;

    return null;
  }

  @override
  bool updateShouldNotifyDependent(ProjectSettingsProvider oldWidget, Set aspects) {
    if (aspects.contains('darkModeEnabeld') && darkModeEnabled != oldWidget.darkModeEnabled) return true;

    return null;
  }
}
