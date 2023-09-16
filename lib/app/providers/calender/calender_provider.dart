import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



final calendarDataProvider = Provider<List<Appointment>>((ref) {
 
  return [
    Appointment(
      startTime: DateTime.now().add(Duration(days: 2)),
      endTime: DateTime.now().add(Duration(days: 3)),
      subject: 'Meeting',
      color: Colors.blue,
    ),
    Appointment(
      startTime: DateTime.now().add(Duration(days: 5)),
      endTime: DateTime.now().add(Duration(days: 7)),
      subject: 'Conference',
      color: Colors.green,
    ),
  ];
});
