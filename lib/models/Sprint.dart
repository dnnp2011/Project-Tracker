import 'package:intl/intl.dart';

/// A single [Task] session, represented by when the [Task] was started([_startTime]), stopped([_stopTime]), and the total [elapsed] time
class Sprint extends Object {
  DateTime _startTime;
  DateTime _stopTime;
  Duration _elapsed;

  void updateStartTime(DateTime timestamp) => this._startTime = timestamp;
  void updateStopTime(DateTime timestamp) => this._stopTime = timestamp;

  Duration get elapsed => _elapsed ?? _stopTime.difference(_startTime);
  DateTime get stopTime => _stopTime;
  DateTime get startTime => _startTime;
  String get formattedLastModified {
    final String monthFormat = DateFormat("MMMM").format(stopTime);
    final String dayFormat = DateFormat("d").format(stopTime);
    final String yearFormat = DateFormat("y").format(stopTime);

    return "$monthFormat $dayFormat, $yearFormat";
  }

  Sprint(this._startTime, this._stopTime) : _elapsed = _stopTime.difference(_startTime);

  Map<String, dynamic> toJson() {
    return {
      "startTime": this._startTime.toString(),
      "stopTime": this._stopTime.toString(),
    };
  }

  static List<Sprint> fromJson(Map<String, dynamic> sprintData) {
    List<Sprint> sprintListRes = [];

    if (sprintData.length > 0) {
      for (var i = 0; i < sprintData.length; i++) {
        var thisSprint = sprintData[i.toString()];
        sprintListRes.add(Sprint(
          DateTime.parse(thisSprint["startTime"]),
          DateTime.parse(thisSprint["stopTime"]),
        ));
      }
    }

    return sprintListRes;
  }
}
