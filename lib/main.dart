import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:taimoor_starter/ui/home_screen/homescreen.dart';
import 'package:taimoor_starter/ui/splash_screen.dart';

void main() {
// Set preferred orientations to portrait only



  runApp(const MyApp());WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'WA Direct',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(

     colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
     useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
  }
}

