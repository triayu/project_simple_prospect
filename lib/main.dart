import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/core/theme.dart';
import 'package:riverpod_example/app/data/local/intro_storage.dart';
import 'package:riverpod_example/app/data/local/shared_preferences.dart';
import 'package:riverpod_example/app/modules/home/home_view.dart';
import 'package:riverpod_example/app/onboarding/onboarding_one.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LazyUi.config(radius: 7.0, theme: AppTheme.light);

  // Initialize SharedPreferencesHelper
  await SharedPreferencesHelper.instance.init();

  // Retrieve the boolean value from SharedPreferences
  bool isIntroBannerShown = await SharedPreferencesHelper.instance.getBool('introBannerShown') ?? false;

  runApp(ProviderScope(
      child: MyApp(
    isShow: isIntroBannerShown,
  )));
}

class MyApp extends StatelessWidget {
  final bool isShow;
  const MyApp({Key? key, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Example',
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
      home: isShow ? HomeView() : OnboardingOne(),
    );
  }
}
