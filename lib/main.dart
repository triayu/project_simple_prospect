import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/constants/color_constants.dart';
import 'package:riverpod_example/app/core/theme.dart';
import 'package:riverpod_example/app/data/local/shared_preferences.dart';
import 'package:riverpod_example/app/modules/home/home_view.dart';
import 'package:riverpod_example/app/modules/login/login_view.dart';
import 'package:riverpod_example/app/onboarding/onboarding_view.dart';

import 'app/data/local/intro_storage.dart';

void main() async {
  // Initialize WidgetsFlutterBinding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize LazyUi
  LazyUi.config(
      textStyle: TextStyle(fontSize: 18.0, color: ColorConstants.textPrimaryColor), radius: 7.0, theme: AppTheme.light);

  // Initialize SharedPreferencesHelper
  await SharedPreferencesHelper.instance.init();

  // Check if intro banner is shown
  bool isIntroBannerShown = await IntroBanner.checkShowBanner();

  runApp(ProviderScope(
      child: MyApp(
    isShow: isIntroBannerShown,
  )));

  // Prevent the application for sreen rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  final bool isShow;
  const MyApp({Key? key, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Prospect',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? widget) {
        double fontDeviceSize = MediaQuery.of(context).textScaleFactor;

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: fontDeviceSize > 1.1 ? 1.1 : 1.0,
          ),
          child: LzToastOverlay(child: widget),
        );
      },
      home: LoginView(),
    );
  }
}
