import 'package:flutter/material.dart';

import '../services/TimerService.dart';

class TimerServiceProvider extends InheritedWidget {
  const TimerServiceProvider({Key key, this.timerService, Widget child}) : super(key: key, child: child);

  final TimerService timerService;

  @override
  bool updateShouldNotify(TimerServiceProvider old) => timerService != old.timerService;
}
