import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/providers/event/event_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../form/form_event/form_event.dart';

class EventView extends ConsumerWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              //============= Calander Event ===========
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: ColorConstants.errorColor, fontSize: 15),
                  weekdayStyle: TextStyle(color: ColorConstants.textPrimaryColor, fontSize: 15),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: ColorConstants.successColor,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: Gfont.normal.copyWith(fontSize: 16, color: ColorConstants.softBlack),
                  todayTextStyle: gfont.copyWith(fontSize: 16, color: Colors.white),
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                ),
                onDaySelected: (selectedDay, focusedDay) {},
              ),
            ),

            Divider(height: 1, color: Colors.black.withOpacity(0.1)),
            // EVENT
            Expanded(
              child: SingleChildScrollView(
                child: Consumer(
                  builder: (context, ref, _) {
                    final AsyncData = ref.watch(eventProvider);

                    return AsyncData.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return LzNoData(
                              message: 'Opps! No data found', onTap: () => ref.read(eventProvider.notifier).getEvent());
                        }
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final event = data[index];
                            return Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              // List Event
                              child: ListTile(
                                dense: true,
                                tileColor: Colors.white,
                                style: ListTileStyle.list,
                                title: Text(
                                  event.title,
                                  style: TextStyle(
                                    color: ColorConstants.textPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  event.userFirstName,
                                  style: TextStyle(
                                    color: ColorConstants.textSecondaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Ti.trash,
                                          color: ColorConstants.errorColor,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Apakah anda yakin untuk hapus?',
                                                  style: Gfont.autoSizeText(
                                                    context,
                                                    FontSizeManager.getHeadlineFontSize(),
                                                    fontWeight: Fw.bold,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ColorConstants.primaryColor,
                                                    ),
                                                    child: Text('Hapus'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ColorConstants.primaryColor,
                                                    ),
                                                    child: Text('Batal'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Ti.edit,
                                          color: ColorConstants.successColor,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Edit Event'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      decoration: InputDecoration(labelText: 'Name'),
                                                      onChanged: (value) {
                                                        // editContact = value;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ColorConstants.primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Save'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ColorConstants.primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: data.length,
                        );
                      },
                      error: (error, _) {
                        return LzNoData(message: 'Opps! $error');
                      },
                      loading: () {
                        return LzLoader.bar(message: 'Loading...');
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
        Poslign(
          alignment: Alignment.bottomRight,
          child: InkTouch(
            padding: Ei.all(10),
            margin: Ei.all(10),
            radius: Br.circle,
            color: ColorConstants.primaryColor,
            child: Icon(
              Ti.plus,
              color: Colors.white,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FormEvent(),
              ));
            },
          ),
        ),
      ],
    );
  }
}
