import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/data/models/event_model.dart';
import 'package:simple_prospect/app/modules/event/event_detail_view.dart';
import 'package:simple_prospect/app/providers/event/event_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'form_event.dart';

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
              padding: Ei.all(10),

              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 35,
                    blurRadius: 25,
                    offset: Offset(0, 3), // changes position of shadow
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
                  weekendStyle: TextStyle(color: ColorConstants.errorColor, fontSize: 14),
                  weekdayStyle: TextStyle(color: ColorConstants.textPrimaryColor, fontSize: 14),
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
                  defaultTextStyle: Gfont.normal.copyWith(fontSize: 15, color: ColorConstants.softBlack),
                  todayTextStyle: gfont.copyWith(fontSize: 15, color: Colors.white),
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                ),
                onDaySelected: (selectedDay, focusedDay) {},
              ),
            ),

            Divider(height: 1, color: Colors.black.withOpacity(0.1)),

            // EVENT =========
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final asyncData = ref.watch(eventProvider);

                  return asyncData.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return LzNoData(
                            message: 'Opps! No data found', onTap: () => ref.read(eventProvider.notifier).getEvent());
                      }

                      return Refreshtor(
                        onRefresh: () => ref.read(eventProvider.notifier).getEvent(),
                        child: ListView.separated(
                          padding: Ei.only(t: 10, h: 10, b: 50),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final key = GlobalKey();

                            EventModel datas = data[index];
                            int id = datas.id ?? 0;
                            String tittle = datas.title ?? '';
                            // String meetingType = datas.meetingType ?? '';
                            String reminder = datas.reminder ?? '';

                            return InkTouch(
                              elevation: 1,
                              key: key,
                              color: Colors.white,
                              onTap: () {
                                final options = ['Lihat Detail', 'Edit', 'Hapus']
                                    .options(icons: [Ti.infoCircle, Ti.edit, Ti.trash]);
                                DropX.show(key.currentContext, options: options, onSelect: (val) {
                                  if (val.index == 0) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EventDetailView(event: datas),
                                      ),
                                    );
                                  }

                                  if (val.index == 1) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FormEvent(
                                          data: datas,
                                        ),
                                      ),
                                    );
                                  }

                                  if (val.index == 2) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return LzConfirm(
                                            title: "Apakah Anda Yakin Untuk Menghapus Data Ini?",
                                            titleSize: 15,
                                            onConfirm: () {
                                              ref.read(eventProvider.notifier).delEvent(id);
                                            },
                                          );
                                        });
                                  }
                                });
                              },
                              padding: Ei.all(5),
                              child: ListTile(
                                dense: true,
                                minLeadingWidth: 0,
                                leading: Icon(
                                  Ti.calendarEvent,
                                  color: ColorConstants.primaryColor,
                                  size: 30,
                                ),
                                title: Text(
                                  tittle.ucwords,
                                  style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                                  maxLines: 3,
                                ),
                                subtitle: Text(reminder,
                                    style: Gfont.autoSizeText(context, FontSizeManager.getCaptionFontSize())),
                                trailing: Icon(Icons.more_vert, color: ColorConstants.primaryColor),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: data.length,
                        ),
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
