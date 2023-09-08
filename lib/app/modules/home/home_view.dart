import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/data/models/banner_intro_model.dart';

import '../../constants/color_constants.dart';
import '../../providers/onboarding/onboarding_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final notifier = ref.watch(carouselStateProvider.notifier);

    final List<BannerIntroModel> banners = [
      BannerIntroModel(id: 0, image: 'logo.png'),
      BannerIntroModel(id: 1, image: 'onboarding1.png'),
      BannerIntroModel(id: 2, image: 'onboarding2.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Selamat datang vivi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Good Morning',
              style: TextStyle(
                fontSize: 14,
                color: ColorConstants.textSecondaryColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: ColorConstants.primaryColor,
            ),
            onPressed: () {
              //menju ----
            },
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('poto.jpg'),
            ),
          ),
        ],
      ),
      body: Container(
        width: screenWidth,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                onPageChanged: (index, reason) {
                  notifier.setBanner(banners[index]);
                },
              ),
              items: banners.asMap().entries.map((entry) {
                final index = entry.key;
                // final banner = entry.value;

                final List<Color> backgroundColors = [
                  ColorConstants.bgcolor1,
                  ColorConstants.bgcolor2,
                  ColorConstants.bgcolor3,
                ];

                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,

                      margin: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: backgroundColors[index % backgroundColors.length],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // child: banner.description != null
                      //     ? ColorFiltered(
                      //         colorFilter: ColorFilter.mode(
                      //           Colors.blue,
                      //           BlendMode.color,
                      //         ),
                      //       )
                      //     : Container(),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Event Terupdate',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.left,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 100,
                viewportFraction: 0.4,
                onPageChanged: (index, reason) {
                  notifier.setBanner(banners[index]);
                },
              ),
              items: banners.asMap().entries.map((entry) {
                final index = entry.key;

                final List<Color> backgroundColors = [
                  Color.fromRGBO(
                      ColorConstants.event1.red, ColorConstants.event1.green, ColorConstants.event1.blue, 100),
                  Color.fromRGBO(
                      ColorConstants.event2.red, ColorConstants.event2.green, ColorConstants.event2.blue, 100),
                  Color.fromRGBO(
                      ColorConstants.event3.red, ColorConstants.event3.green, ColorConstants.event3.blue, 100),
                  Color.fromRGBO(
                      ColorConstants.event1.red, ColorConstants.event1.green, ColorConstants.event1.blue, 100),
                  Color.fromRGBO(
                      ColorConstants.event2.red, ColorConstants.event2.green, ColorConstants.event2.blue, 100),
                ];

                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: backgroundColors[index % backgroundColors.length],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Teks 1 ${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
