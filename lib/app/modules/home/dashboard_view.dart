import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/config/font.dart';
import 'package:lazyui/lazyui.dart' hide Gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';

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
    ColorConstants.event1.withOpacity(0.5),
    ColorConstants.event2.withOpacity(0.5),
    ColorConstants.event3.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // // HEADER
        Container(
          padding: Ei.only(h: 20, b: 5, t: 15),
          decoration: BoxDecoration(border: Br.only(['b'], color: Colors.black.withOpacity(0.1))),
          child: Row(
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Col(
                  children: [
                    Text(
                      'Halo, Selamat Datang Vivi',
                      style: Gfont.fs(18).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
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
              Row(
                children: [
                  Container(
                    padding: Ei.all(5),
                    child: Icon(
                      Ti.bellFilled,
                      color: ColorConstants.primaryColor,
                      size: 25,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUserView()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: LzImage(
                        'poto.jpg',
                        width: 50,
                        height: 50,
                        radius: 30,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),

        // SLIDER
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: Ei.sym(v: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: Ei.only(h: 20, b: 10, t: 10),
                    child: Text(
                      'Goals',
                      style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(viewportFraction: 0.9, height: 200),
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
                              Align(
                                alignment: Alignment.center,
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
                    padding: Ei.only(h: 20, b: 10, t: 10),
                    child: Text(
                      'Event Terupdate',
                      style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
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
                      Color backgroundColor = customColorsevent[index % customColors.length];

                      return Container(
                        padding: Ei.all(10),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: Maa.spaceBetween,
                          children: [
                            Container(
                              padding: Ei.all(10),
                              decoration: BoxDecoration(
                                color: ColorConstants.secondaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'tanggal $index',
                                    style: Gfont.fs(10).copyWith(color: ColorConstants.secondaryColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Col(
                              children: [
                                Text(
                                  'Waktu $index',
                                  style: Gfont.fs(10).copyWith(color: ColorConstants.secondaryColor),
                                ),
                                Text(
                                  'Meeting $index',
                                  style: Gfont.fs(16).copyWith(color: ColorConstants.secondaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // TASK TERUPDATE
                Col(
                  children: [
                    Padding(
                      padding: Ei.only(h: 20, b: 10, t: 10),
                      child: Text(
                        'Task Terupdate',
                        style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.separated(
                        padding: Ei.sym(h: 10),
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
                              dense: true,
                              tileColor: ColorConstants.secondaryColor,
                              style: ListTileStyle.list,
                              title: Text(
                                'Hasil Meeting $index',
                                style: Gfont.fs(16),
                              ),
                              subtitle: Row(
                                children: [
                                  Text('Contact $index'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.event2.withOpacity(0.10),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      'Reminder : 23/09/2023 04.00 PM',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: ColorConstants.textPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  Text('23', style: TextStyle(fontSize: 10)),
                                  Text('Jan', style: TextStyle(fontSize: 10)),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemCount: 4),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
