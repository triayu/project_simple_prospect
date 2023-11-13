import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_prospect/app/data/local/auth_storage.dart';
import 'package:simple_prospect/app/modules/home/home_view.dart';
import 'package:simple_prospect/app/modules/login/login_view.dart';
import 'package:simple_prospect/app/modules/onboarding/onboarding_view.dart';
import 'app/constants/color_constants.dart';
import 'app/core/theme.dart';
import 'app/data/local/intro_storage.dart';
import 'app/data/local/shared_preferences.dart';

void main() async {
  // Initialize WidgetsFlutterBinding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initialize LazyUi
  LazyUi.config(
      font: TextStyle(fontSize: 18.0, color: ColorConstants.textPrimaryColor), radius: 7.0, theme: AppTheme.light);

  // Initialize SharedPreferences
  prefs = await SharedPreferences.getInstance();

  // Check if user is logged in
  bool isLoggedIn = await AuthStorage.isLogged();

  // Check if intro banner is shown
  bool isIntroBannerShown = await IntroBannerStorage.checkShowBanner();

  // initialize FlutterNativeSplash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Run Apps
  runApp(
    ProviderScope(
      child: MyApp(
        isLoggedIn: isLoggedIn,
        isShow: isIntroBannerShown,
      ),
    ),
  );

  // Whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();

  // Prevent the application for sreen rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  final bool isShow, isLoggedIn;
  const MyApp({Key? key, required this.isShow, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    logg(isLoggedIn, name: 'Log In Main.dart');

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
      home: isShow
          ? OnboardingView()
          : isLoggedIn
              ? HomeView()
              : LoginView(),
    );
  }
}
