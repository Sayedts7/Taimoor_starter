import 'package:flutter/material.dart';
import 'package:taimoor_starter/ui/custom_widgets/custom_text_field.dart';
import 'package:taimoor_starter/ui/login/login_view.dart';
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
  // SplashServices services = SplashServices();
  @override
  void initState() {
    // services.isLogin(context);

    super.initState();

    // Add a delay of 3 seconds before navigating to the next screen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the next screen (replace 'HosreRidingScreen' with your screen)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return  Scaffold(
      backgroundColor: ThemeColors.mainColor,
      body: Center(child: Image(image: AssetImage('assets/images/logo.png'),height: MySize.size300,)),
    );
  }
}
