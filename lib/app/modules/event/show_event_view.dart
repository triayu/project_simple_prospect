import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/event_model.dart';
import 'package:simple_prospect/app/providers/event/event_provider.dart';

class ShowEventView extends ConsumerWidget {
  final EventModel event;

  const ShowEventView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(eventProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Event'),
        centerTitle: true,
      ),
      body: asyncData.when(
        data: (data) {
          if (data.isEmpty) {
            return LzNoData(
              message: 'Opps! No data found',
              onTap: () => ref.read(eventProvider.notifier).getDetailEvent,
            );
          }

          return buildEventDetails(event);
        },
        error: (error, _) {
          return LzNoData(message: 'Opps! $error');
        },
        loading: () {
          return SizedBox(
            height: 90,
            child: ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildEventDetails(EventModel event) {
    return ListView.separated(
      padding: Ei.sym(h: 20, v: 20),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        int id = event.id ?? 0;
        String title = event.title ?? '';
        String userFirstName = event.userFirstName ?? '';
        String userLastName = event.userLastName ?? '';
        String meetingWith = event.meetingWith ?? '';
        String meetingType = event.meetingType ?? '';
        String location = event.location ?? '';
        String note = event.note ?? '';
        // DateTime reminder = event.reminder ?? DateTime.now();

        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: Ei.only(h: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Event ID', id.toString()),
                  buildInfoRow('Title', title),
                  buildInfoRow('First Name', userFirstName),
                  buildInfoRow('Meeting With', meetingWith),
                  buildInfoRow('Meeting Type', meetingType),
                  buildInfoRow('Location', location),
                  // buildInfoRow('Reminder', reminder.toString()),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
      itemCount: 1,
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          value,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
