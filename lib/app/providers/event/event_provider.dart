import 'package:flutter_riverpod/flutter_riverpod.dart';

// Buat provider untuk data event
final eventListProvider = StateNotifierProvider<EventList, List<String>>((ref) {
  return EventList();
});

class EventList extends StateNotifier<List<String>> {
  EventList() : super([]);

  void addEvent(String event) {
    state = [...state, event];
  }
}
