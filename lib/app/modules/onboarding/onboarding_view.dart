import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/login/login_view.dart';
import 'package:simple_prospect/app/widgets/widget.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> images = ['logo.png', 'onboarding1.png', 'onboarding2.png'];

    CarouselController carouselController = CarouselController();

    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  autoPlayInterval: 5.s,
                  enableInfiniteScroll: true,
                  height: context.height,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, _) {},
                  scrollPhysics: BounceScroll()),
              items: List.generate(images.length, (i) {
                return LzImage(
                  images[i],
                  width: context.width,
                  radius: 0,
                );
              })),
        ),
        LineProgressIndicator(
          repeat: true,
          duration: 10.s,
          progressColor: ColorConstants.primaryColor,
          onComplete: () {},
        ),
        Container(
          padding: Ei.all(25),
          child: Column(
            children: [
              Text('Get Organized', style: Gfont.fs20.bold),
              Text(
                Faker.words(15),
                style: Gfont.muted,
              ).margin(t: 10, b: 35),
              Row(
                mainAxisAlignment: Maa.spaceBetween,
                children: [
                  LzSlidebar(
                    active: 0,
                    activeColor: ColorConstants.primaryColor,
                    size: (i) => [i == 0 ? 13 : 7, 7],
                  ),
                  LzButton(
                      radius: 100,
                      text: 'Mulai',
                      icon: La.arrowRight,
                      onTap: (_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                        );
                      })
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}




// class OnboardingView extends ConsumerWidget {
//   const OnboardingView({Key? key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final notifier = ref.watch(carouselStateProvider.notifier);

//     final List<BannerIntroModel> banners = [
//       BannerIntroModel(id: 0, image: 'logo.png', description: 'Halo Selamat Datang Di Simple Prospect'),
//       BannerIntroModel(
//           id: 1,
//           image: 'onboarding1.png',
//           description: 'Aplikasi Prospect sederhana untuk IBO dengan guna mengelola kontak MLM, pemasaran jaringan'),
//       BannerIntroModel(id: 2, image: 'onboarding2.png', description: 'PROSPECT'),
//     ];
//     return Scaffold(
//       body: Container(
//         width: screenWidth,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.blue],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: [0.2, 4.0],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: Maa.center,
//           crossAxisAlignment: Caa.center,
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                   height: 400.0,
//                   viewportFraction: 1,
//                   onPageChanged: (index, reason) {
//                     notifier.setBanner(banners[index]);
//                   }),
//               items: banners.map((i) {
//                 return Column(
//                   mainAxisAlignment: Maa.center,
//                   crossAxisAlignment: Caa.center,
//                   children: [
//                     LzImage(
//                       i.image,
//                       width: 250,
//                       height: 250,
//                     ),
//                     Textr(
//                       i.description ?? '',
//                       textAlign: Ta.center,
//                       padding: Ei.sym(h: 10),
//                       style: Gfont.black.copyWith(
//                         fontSize: 18,
//                         color: ColorConstants.secondaryColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )
//                   ],
//                 );
//               }).toList(),
//             ),
//             Row(
//               crossAxisAlignment: Caa.center,
//               mainAxisAlignment: Maa.center,
//               children: List.generate(banners.length, (i) {
//                 return Container(
//                   width: 8,
//                   height: 8,
//                   margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: ref.watch(carouselStateProvider).id == i
//                         ? ColorConstants.secondaryColor
//                         : ColorConstants.primaryColor,
//                   ),
//                 );
//               }),
//             ),
//             ref.watch(carouselStateProvider).id == 2
//                 ? SizedBox(
//                     width: screenWidth * 0.8,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: LzButton(
//                         text: 'Mulai',
//                         onTap: (state) {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginView(),
//                             ),
//                           );
//                         },
//                         textColor: ColorConstants.primaryColor,
//                         radius: 30.0,
//                         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
