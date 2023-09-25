import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/config/font.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:table_calendar/table_calendar.dart';

import '../form/form_event/form_event.dart';

class EventView extends ConsumerWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Col(
        children: [
          // All Contact
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
                defaultTextStyle: TextStyle(
                  fontSize: 12,
                ),
                todayTextStyle: TextStyle(fontSize: 12),
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

          Row(
            children: [
              Padding(
                padding: Ei.all(10),
                child: Text(
                  'Your Event',
                  style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormEvent(),
                    ),
                  );
                },
                child: Container(
                  height: 30,
                  width: 70,
                  margin: EdgeInsets.only(bottom: 10, right: 10, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.primaryColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 3),
                        child: Icon(
                          Ti.plus,
                          size: 15,
                          color: ColorConstants.secondaryColor,
                        ),
                      ),
                      Text(
                        'Add Event',
                        style: TextStyle(
                          color: ColorConstants.secondaryColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          ListView.separated(
            padding: Ei.sym(h: 10),
            physics: NeverScrollableScrollPhysics(),
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
            itemCount: 4,
          ),
        ],
      ),
    );
  }
}
