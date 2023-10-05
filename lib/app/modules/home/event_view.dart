import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
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
            // All Contact
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
            // Event
            Expanded(
              child: ListView.separated(
                padding: Ei.sym(h: 10, v: 20),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
                    child: ListTile(
                      dense: true,
                      tileColor: Colors.white,
                      style: ListTileStyle.list,
                      title: Text(
                        'Desc Event $index',
                        style: TextStyle(
                          color: ColorConstants.textPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                                    String editContact = 'Name $index';
                                    return AlertDialog(
                                      title: Text('Apakah anda yakin untuk hapus?'),
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
                                    String editContact = 'Name $index';
                                    return AlertDialog(
                                      title: Text('Edit Contact'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            decoration: InputDecoration(labelText: 'Name'),
                                            onChanged: (value) {
                                              editContact = value;
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
                itemCount: 10,
              ),
            ),
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
