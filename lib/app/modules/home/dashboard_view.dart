import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/config/font.dart';
import 'package:lazyui/lazyui.dart' hide Gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';

class DashBoardView extends ConsumerWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // // HEADER
        Container(
          padding: Ei.only(h: 20, b: 10, t: 15),
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
                      Ti.bellRingingFilled,
                      color: ColorConstants.primaryColor,
                      size: 25,
                    ),
                  ),
                  Container(
                    padding: Ei.all(5),
                    child: LzImage(
                      'poto.jpg',
                      width: 50,
                      height: 50,
                      radius: 30,
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
            padding: Ei.sym(v: 20),
            child: Col(
              children: [
                Padding(
                  padding: Ei.only(h: 20, b: 10, t: 10),
                  child: Text(
                    'Goals',
                    style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
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
                              // Random Color
                              borderRadius: BorderRadius.circular(10),
                              color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                            ),
                            child: Stack(
                              children: [
                                Poslign(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: Ta.center,
                                    strutStyle: StrutStyle(fontSize: 50.0),
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '0',
                                          style: Gfont.fs(65).copyWith(color: Colors.white),
                                        ),
                                        TextSpan(
                                          text: ' / ',
                                          style: Gfont.fs(50).copyWith(color: Colors.white),
                                        ),
                                        TextSpan(
                                          text: '0',
                                          style: Gfont.fs(35).copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Poslign(
                                    alignment: Alignment.bottomLeft,
                                    child: Textr(
                                      'Prospect Booked $i',
                                      margin: Ei.all(10),
                                      style: Gfont.fs(20).copyWith(color: Colors.white),
                                    ))
                              ],
                            ));
                      },
                    );
                  }).toList(),
                ),

                // Event Terupdate
                Padding(
                  padding: Ei.only(h: 20, b: 10, t: 20),
                  child: Text(
                    'Event Terupdate',
                    style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: Ei.all(10),
                    separatorBuilder: (context, index) => SizedBox(width: 15),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: Ei.all(10),
                          decoration: BoxDecoration(
                              color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: Maa.spaceBetween,
                            children: [
                              Container(
                                padding: Ei.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'tanggal $index',
                                      style: Gfont.fs(10).copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Col(
                                children: [
                                  Text(
                                    'Waktu $index',
                                    style: Gfont.fs(10).copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    'Meeting $index',
                                    style: Gfont.fs(16).copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                  ),
                ),

                Col(
                  children: [
                    Padding(
                      padding: Ei.only(h: 20, b: 10, t: 20),
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
                                'Hasil Meeting $index',
                                style: Gfont.fs(16),
                              ),
                              subtitle: Text('Contact $index'),
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
