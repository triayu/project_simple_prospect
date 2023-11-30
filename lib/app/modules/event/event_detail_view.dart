import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/data/models/event_model.dart';

class EventDetailView extends ConsumerWidget {
  final EventModel event;

  const EventDetailView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildCard(String title, String content) {
      return Card(
        elevation: 5,
        color: ColorConstants.card,
        child: Padding(
          padding: Ei.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.textPrimaryColor,
                ),
              ),
              Text(
                ' $content',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Detail'),
      ),
      body: Padding(
        padding: Ei.all(10),
        child: ListView(
          children: [
            Text(
              'Event',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildCard('Meeting With', '${event.meetingWith}'),
            buildCard('Meeting Type', '${event.meetingType}'),
            SizedBox(height: 30),
            Text(
              'Details Acara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildCard('Title', '${event.title}'),
            buildCard('Note Event', '${event.note}'),
            buildCard('Location', '${event.location}'),
            buildCard('Reminder', '${event.reminder}'),
          ],
        ),
      ),
    );
  }
}
