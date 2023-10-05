import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';

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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: Maa.start,
        crossAxisAlignment: Caa.start,
        children: [
          // // HEADER
          Container(
            padding: Ei.sym(h: 20, v: 25),
            child: Column(
              mainAxisAlignment: Maa.start,
              crossAxisAlignment: Caa.start,
              children: [
                Text(
                  'Halo, Selamat Datang Vivi',
                  style: gfont.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: ColorConstants.textPrimaryColor,
                  ),
                  maxLines: 2,
                  overflow: Tof.ellipsis,
                ),
                Text(
                  'Good Morning',
                  style: Gfont.fs(16).copyWith(color: ColorConstants.textSecondaryColor),
                  maxLines: 1,
                  overflow: Tof.ellipsis,
                ),
              ],
            ),
          ),

          // SLIDER
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(viewportFraction: 0.9, height: context.height * 0.25),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: customColors[i - 1],
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
                                      text: '0',
                                      style: Gfont.fs(65).copyWith(color: ColorConstants.secondaryColor),
                                    ),
                                    TextSpan(
                                      text: ' / ',
                                      style: Gfont.fs(50).copyWith(color: ColorConstants.secondaryColor),
                                    ),
                                    TextSpan(
                                      text: '0',
                                      style: Gfont.fs(35).copyWith(color: ColorConstants.secondaryColor),
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
                                  'Prospect Booked $i',
                                  style: Gfont.fs(18).copyWith(color: ColorConstants.secondaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              // EVENT TERUPDATE
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: Ei.only(h: 20, b: 10, t: 30),
                  child: Text(
                    'Aktifitas yang akan datang',
                    style: Gfont.fs(20).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(
                height: 90,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: Ei.only(h: 10, b: 5),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
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
                              )),
                          Container(
                            padding: Ei.all(10),
                            child: Row(
                              mainAxisAlignment: Maa.spaceBetween,
                              crossAxisAlignment: Caa.center,
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
                                  mainAxisAlignment: Maa.center,
                                  crossAxisAlignment: Caa.start,
                                  children: [
                                    Text(
                                      'Waktu $index',
                                      style: Gfont.fs(14).copyWith(color: ColorConstants.secondaryColor),
                                    ),
                                    Text(
                                      'Meeting $index',
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
                    child: Text(
                      'Task Terupdate',
                      style: Gfont.fs(20).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.separated(
                      padding: Ei.only(h: 10, b: 30),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                          child: ListTile(
                            contentPadding: Ei.all(10),
                            dense: true,
                            minVerticalPadding: 10,
                            tileColor: ColorConstants.secondaryColor,
                            style: ListTileStyle.list,
                            title: Textr(
                              'Hasil Meeting $index',
                              style: Gfont.fs(16),
                              margin: Ei.only(b: 5),
                            ),
                            subtitle: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.event2.withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Reminder : 23/09/2023 04.00 PM',
                                    style: Gfont.fs(12).copyWith(color: ColorConstants.event2),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                Text('Dates', style: Gfont.fs14),
                              ],
                            ),
                          ),
                        );
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
    );
  }
}
