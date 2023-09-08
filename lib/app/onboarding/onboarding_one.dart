import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/constants/color_constants.dart';
import 'package:riverpod_example/app/data/models/banner_intro_model.dart';
import 'package:riverpod_example/app/providers/onboarding/onboarding_provider.dart';

import '../modules/login/login_view.dart';

class OnboardingOne extends ConsumerWidget {
  const OnboardingOne({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final notifier = ref.watch(carouselStateProvider.notifier);

    final List<BannerIntroModel> banners = [
      BannerIntroModel(id: 0, image: 'logo.png', description: ''),
      BannerIntroModel(
          id: 1,
          image: 'onboarding1.png',
          description: 'Aplikasi Prospect sederhana untuk IBO dengan guna mengelola kontak MLM, pemasaran jaringan'),
      BannerIntroModel(id: 2, image: 'onboarding2.png', description: 'PROSPECT'),
    ];
    return Scaffold(
      body: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 4.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: Maa.center,
          crossAxisAlignment: Caa.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 400.0,
                  viewportFraction: 1
                  ,
                  onPageChanged: (index, reason) {
                    notifier.setBanner(banners[index]);
                  }),
              items: banners.map((i) {
                print(i.description);
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        LzImage(
                          i.image,
                          width: 250,
                          height: 250,
                        ),
                        Text(
                          i.description ?? '',
                        )
                      ],
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (i) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ref.watch(carouselStateProvider).id == i
                        ? ColorConstants.secondaryColor
                        : ColorConstants.primaryColor,
                  ),
                );
              }),
            ),
            ref.watch(carouselStateProvider).id == 2
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.secondaryColor,
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
