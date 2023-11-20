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
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: Ei.sym(v: 5, h: 10),
        physics: BouncingScrollPhysics(),
        child: Consumer(
          builder: (context, ref, _) {
            final eventState = ref.watch(eventProvider);

            return eventState.when(
              data: (data) {
                if (data.isEmpty) {
                  return LzNoData(
                    message: 'Opps! No data found',
                    onTap: () => ref.read(eventProvider.notifier).showEvent(event.id!), 
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    _buildSectionTitle('Meeting'),
                    _buildInfoContainer([
                      _buildListTile("Meeting With", event.meetingWith ?? ""),
                      _buildListTile("Meeting type", event.meetingType ?? ""),
                    ]),
                    _buildSectionTitle('Detail Acara'),
                    _buildInfoContainer([
                      _buildListTile("Title", event.title ?? ""),
                      _buildListTile("Note Event", event.note ?? ""),
                      _buildListTile("Start Date", event.startDate?.toString() ?? ""),
                      _buildListTile("End Date", event.endDate?.toString() ?? ""),
                      _buildListTile("Location", event.location ?? ""),
                      _buildListTile("Set Time Reminder", event.reminder?.toString() ?? ""),
                    ]),
                  ],
                );
              },
              error: (error, _) {
                return LzNoData(message: 'Opps! $error');
              },
              loading: () {
                return SizedBox(
                  height: 90,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String content) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        content,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: Ei.only(t: 10),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildInfoContainer(List<Widget> children) {
    return Container(
      padding: Ei.sym(v: 5),
      margin: Ei.sym(v: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Column(children: children),
    );
  }
}
