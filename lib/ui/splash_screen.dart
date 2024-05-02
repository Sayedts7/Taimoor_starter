import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:taimoor_starter/ui/custom_widgets/custom_text_field.dart';
import 'package:taimoor_starter/ui/home_screen/homescreen.dart';
import 'package:taimoor_starter/ui/onBoarding/onboard.dart';
import 'package:taimoor_starter/ui/splash_services.dart';

import '../core/utils/mySize.dart';
import '../core/utils/sizes_class.dart';
import '../core/utils/theme_helper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();
  @override
  void initState() {
    services.isLogin(context);
    _createInterstitialAd();
    super.initState();

    // Add a delay of 3 seconds before navigating to the next screen
    // Future.delayed(const Duration(seconds: 2), () {
    //   // Navigate to the next screen (replace 'HosreRidingScreen' with your screen)
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => const OnBoardingScreen(),
    //     ),
    //   );
    // });
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-9385559783586486/8334005105",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
            );
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
        );
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return  Scaffold(

      backgroundColor: Color(0xfff8f8f8),
      body: Center(child: Image(image: AssetImage('assets/images/logo.png'),height: MySize.size600,)),
    );
  }
}
