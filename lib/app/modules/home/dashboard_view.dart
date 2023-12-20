import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/data/local/auth_storage.dart';
import 'package:simple_prospect/app/data/models/coming_event_model.dart';
import 'package:simple_prospect/app/data/models/up_daily_task_model.dart';
import 'package:simple_prospect/app/providers/dashboard/banner_provider.dart';

import '../../providers/dashboard/dashboard_coming_event_provider.dart';
import '../../providers/dashboard/dashboard_up_daily_task_provider.dart';

class DashBoardView extends ConsumerWidget {
  DashBoardView({Key? key}) : super(key: key);

  final List<Color> customColors = [
    ColorConstants.bgcolor1,
    ColorConstants.bgcolor2,
    ColorConstants.bgcolor3,
    ColorConstants.bgcolor1,
    ColorConstants.bgcolor2,
  ];

  final List<Color> customColorsevent = [
    ColorConstants.event1,
    ColorConstants.event2,
    ColorConstants.event3,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Refreshtor(
      onRefresh: () async {
        await ref.read(introProvider.notifier).getGoal();
        await ref.read(comingeventProvider.notifier).getUpComingEvent();
        await ref.read(upTaskProvider.notifier).getUpDailyTask();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // HEADER
            FutureBuilder(
              future: AuthStorage.user(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Skeleton(
                    size: [MediaQuery.of(context).size.width, 100],
                  );
                }

                if (snapshot.hasError) {
                  return LzNoData(
                    icon: Icons.error,
                    message: 'Error',
                  );
                }
                String fullName = '${snapshot.data!.firstName} ${snapshot.data!.lastName}';

                return Container(
                  padding: Ei.sym(h: 20, v: 20),
                  margin: Ei.all(10),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, Selamat Datang ${fullName.ucwords}',
                        style: Gfont.autoSizeText(context, FontSizeManager.getSublineFontSize(), fontWeight: Fw.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),

            Column(
              children: [
                //Slider Banner
                Consumer(
                  builder: (context, ref, _) {
                    final asyncData = ref.watch(introProvider);

                    return asyncData.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return LzNoData(
                            message: 'Opps! No data found',
                            onTap: () => ref.read(introProvider.notifier).getGoal(),
                          );
                        }

                        return Stack(
                          children: [
                            CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 0.9,
                                  height: context.height * 0.26,
                                ),
                                items: List.generate(data.length, (i) {
// Memisahkan string dengan underscore
                                  List<String> parts = data[i].goalName.split('_');

                                  // Mengambil elemen terakhir dari array
                                  String result = parts.isNotEmpty ? parts.last : '';

                                  String tittle = result;
                                  int total = i == 0
                                      ? data[i].totalContact!
                                      : i == 1
                                          ? data[i].totalMessageTemplate!
                                          : i == 2
                                              ? data[i].totalTask!
                                              : i == 3
                                                  ? data[i].totalEvent!
                                                  : 0;

                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: Ei.sym(h: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: customColors[i],
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          bottom: -50,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: LzImage('banner_ornament.svg',
                                                size: context.height, fit: BoxFit.contain),
                                          ),
                                        ),
                                        Positioned(
                                          top: context.viewPadding.top + 30,
                                          left: 50,
                                          right: 50,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            strutStyle: StrutStyle(fontSize: 20),
                                            text: TextSpan(
                                              onEnter: (event) {},
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: total.toString(),
                                                  style: Gfont.fs(65).copyWith(color: ColorConstants.secondaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: Ei.only(l: 10, b: 10),
                                            child: Text(
                                              'Total ${tittle.ucwords}',
                                              style: Gfont.fs(16).copyWith(color: ColorConstants.secondaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                          ],
                        );
                      },
                      error: (error, _) {
                        return LzNoData(message: 'Opps! $error');
                      },
                      loading: () {
                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Skeleton(
                                radius: 10,
                                margin: Ei.all(10),
                                size: [context.width * 0.9, context.height * 0.26],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),

                // ======================
                // EVENT TERUPDATE
                // ======================

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: Ei.only(l: 20, t: 15, b: 5),
                    child: Text(
                      'Aktifitas yang akan datang',
                      style: Gfont.autoSizeText(context, FontSizeManager.getTittleFontSize(), fontWeight: Fw.bold),
                    ),
                  ),
                ),

                Consumer(
                  builder: (context, ref, _) {
                    final asyncData = ref.watch(comingeventProvider);

                    return asyncData.when(
                      data: (List<UpcomingEventModel> data) {
                        if (data.isEmpty) {
                          return LzNoData(
                            message: 'Oops! No data found',
                            onTap: () => ref.read(comingeventProvider.notifier).getUpComingEvent(),
                          );
                        }

                        return SizedBox(
                          height: 90,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, bottom: 5, left: 20),
                            separatorBuilder: (context, index) => SizedBox(width: 10),
                            itemCount: data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              UpcomingEventModel event = data[index];

                              return Container(
                                decoration: BoxDecoration(
                                  color: ColorConstants.softBlack,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      top: -50,
                                      bottom: -50,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: LzImage(
                                          'banner_ornament.svg',
                                          size: context.width,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: Ei.only(l: 20),
                                      padding: Ei.all(5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${event.date.format('dd MMM')}',
                                                style: Gfont.fs(14).copyWith(color: ColorConstants.secondaryColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${event.name}',
                                                style: Gfont.fs(14).copyWith(color: ColorConstants.secondaryColor),
                                              ),
                                              // Text(
                                              //   'Meeting ${event.name}',
                                              //   style: Gfont.fs(16).copyWith(color: ColorConstants.secondaryColor),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      error: (error, _) {
                        return LzNoData(message: 'Oops! $error');
                      },
                      loading: () {
                        return SizedBox(
                          height: 90,
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Skeleton(radius: 10, margin: EdgeInsets.all(10), size: [250, 20]);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),

                // ======================
                // TASK TERUPDATE
                // ======================

                Padding(
                  padding: Ei.only(l: 20, b: 10, t: 15),
                  child: Row(
                    children: [
                      Text(
                        'Task Terupdate',
                        style: Gfont.autoSizeText(
                          context,
                          FontSizeManager.getTittleFontSize(),
                          fontWeight: Fw.bold,
                        ),
                      ),
                      Spacer(),
                      // Text(
                      //   'Lihat Semua',
                      //   style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize(),
                      //       color: ColorConstants.textSecondaryColor),
                      // ),
                    ],
                  ),
                ),

                Consumer(
                  builder: (context, ref, _) {
                    final asyncData = ref.watch(upTaskProvider);

                    return asyncData.when(
                      data: (List<UpDailyTaskModel> data) {
                        if (data.isEmpty) {
                          return LzNoData(
                            message: 'Opps! No data found',
                            onTap: () => ref.read(upTaskProvider.notifier).getUpDailyTask(),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data.map((task) {
                            return Container(
                              margin: Ei.only(l: 20, b: 10),
                              padding: Ei.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorConstants.secondaryColor,
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
                                  Text(
                                    '${task.fullName!.ucwords}',
                                    style: Gfont.autoSizeText(
                                      context,
                                      FontSizeManager.getBodyFontSize(),
                                      color: ColorConstants.textPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Ti.calendar, color: ColorConstants.textPrimaryColor, size: 20),
                                          SizedBox(width: 5),
                                          Text(
                                            '${task.reminder.format('dd MMM yyyy')}',
                                            style: Gfont.autoSizeText(
                                              context,
                                              FontSizeManager.getBodyFontSize(),
                                              color: ColorConstants.textPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      // Row(
                                      //   children: [
                                      //     Icon(Icons.access_time, color: ColorConstants.textPrimaryColor, size: 20),
                                      //     SizedBox(width: 5),
                                      //     Text(
                                      //       ' ${task.dueTime}',
                                      //       style: Gfont.autoSizeText(
                                      //         context,
                                      //         FontSizeManager.getBodyFontSize(),
                                      //         color: ColorConstants.textPrimaryColor,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                      error: (error, _) {
                        return LzNoData(message: 'Opps! $error');
                      },
                      loading: () {
                        return ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Skeleton(radius: 10, margin: Ei.all(10), size: [250, 20]);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
