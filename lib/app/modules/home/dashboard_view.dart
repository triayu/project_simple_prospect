import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/data/local/auth_storage.dart';
import 'package:simple_prospect/app/data/models/coming_event_model.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/providers/dashboard/banner_intro_provider.dart';
import 'package:simple_prospect/app/providers/dashboard/dashboard_coming_event_provider.dart';

class DashBoardView extends ConsumerWidget {
  DashBoardView({super.key});

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
    // Variable Data User didapatkan dari penyimpanan local storage
    User userData = AuthStorage.user();

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(introProvider.notifier).getIntro();
        await ref.read(comingeventProvider.notifier).getComing();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: Maa.start,
          crossAxisAlignment: Caa.start,
          children: [
            // // HEADER
            Container(
              padding: Ei.sym(h: 20, v: 20),
              child: Column(
                mainAxisAlignment: Maa.start,
                crossAxisAlignment: Caa.start,
                children: [
                  Text(
                    'Halo, Selamat Datang ${userData.fullName!.ucwords}',
                    style: Gfont.autoSizeText(context, FontSizeManager.getHeadlineFontSize(), fontWeight: Fw.bold),
                    maxLines: 2,
                    overflow: Tof.ellipsis,
                  ),
                ],
              ),
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
                              message: 'Opps! No data found', onTap: () => ref.read(introProvider.notifier).getIntro());
                        }

                        return CarouselSlider(
                          options: CarouselOptions(viewportFraction: 0.9, height: context.height * 0.26),
                          items: data.map(
                            (i) {
                              String tittle = i.name;
                              String total = i.total.toString();

                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: customColors[data.indexOf(i)],
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                        bottom: -50,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child:
                                              LzImage('banner_ornament.svg', size: context.height, fit: BoxFit.contain),
                                        )),
                                    Poslign(
                                      margin: Ei.only(t: context.viewPadding.top + 30),
                                      alignment: Alignment.topCenter,
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        strutStyle: StrutStyle(fontSize: 50.0),
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: total,
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
                                          style: Gfont.fs(18).copyWith(color: ColorConstants.secondaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
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

                // ======================

                // EVENT TERUPDATE
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: Ei.only(h: 20, b: 10, t: 30),
                    child: Text(
                      'Aktifitas yang akan datang',
                      style: Gfont.autoSizeText(context, FontSizeManager.getSublineFontSize(), fontWeight: Fw.bold),
                    ),
                  ),
                ),

                Consumer(
                  builder: (context, ref, _) {
                    final asyncData = ref.watch(comingeventProvider);

                    return asyncData.when(
                      data: (List<ComingEventModel> data) {
                        if (data.isEmpty) {
                          return LzNoData(
                            message: 'Opps! No data found',
                            onTap: () => ref.read(comingeventProvider.notifier).getComing(),
                          );
                        }

                        return SizedBox(
                          height: 90,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            separatorBuilder: (context, index) => SizedBox(width: 10),
                            itemCount: data.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final event = data[index];
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
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '16/8/2023',
                                                style: Gfont.fs(16).copyWith(color: ColorConstants.secondaryColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Waktu ${event.count}',
                                                style: Gfont.fs(14).copyWith(color: ColorConstants.secondaryColor),
                                              ),
                                              Text(
                                                'Meeting ${event.name}',
                                                style: Gfont.fs(18).copyWith(color: ColorConstants.secondaryColor),
                                              ),
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
                        return LzNoData(message: 'Opps! $error');
                      },
                      loading: () {
                        return LzLoader.bar(message: 'Loading...');
                      },
                    );
                  },
                ),

                // ======================
                // TASK TERUPDATE
                // ======================
                Column(
                  mainAxisAlignment: Maa.start,
                  crossAxisAlignment: Caa.start,
                  children: [
                    Padding(
                      padding: Ei.only(h: 20, b: 10, t: 30),
                      child: Row(
                        children: [
                          Text(
                            'Task Terupdate',
                            style: Gfont.autoSizeText(
                              context,
                              FontSizeManager.getSublineFontSize(),
                              fontWeight: Fw.bold,
                            ),
                          ),
                          Spacer(),
                          Text('Lihat Semua',
                              style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize(),
                                  color: ColorConstants.textSecondaryColor)),
                        ],
                      ),
                    ),
                    ListView.separated(
                        padding: Ei.only(h: 10, b: 30),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
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
                              child: Row(
                                mainAxisAlignment: Maa.spaceBetween,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Text('Task asdasdasdasdasdasdasdasdasdasdsadasdsadsdads $index',
                                              style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize(),
                                                  color: ColorConstants.textPrimaryColor)),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Ti.calendar, color: ColorConstants.textPrimaryColor, size: 20),
                                                  SizedBox(width: 5),
                                                  Text('16/8/2023',
                                                      style: Gfont.autoSizeText(
                                                          context, FontSizeManager.getBodyFontSize(),
                                                          color: ColorConstants.textPrimaryColor)),
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              Row(
                                                children: [
                                                  Icon(Ti.clock, color: ColorConstants.textPrimaryColor, size: 20),
                                                  SizedBox(width: 5),
                                                  Text('13:03:99',
                                                      style: Gfont.autoSizeText(
                                                          context, FontSizeManager.getBodyFontSize(),
                                                          color: ColorConstants.textPrimaryColor)),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  SizedBox(width: 10),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        padding: Ei.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: Br.circle,
                                          color: ColorConstants.softBlack,
                                        ),
                                        child: Icon(
                                          size: 20,
                                          Ti.dotsVertical,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemCount: 4),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
