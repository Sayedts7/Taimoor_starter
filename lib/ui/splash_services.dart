import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taimoor_starter/ui/home_screen/homescreen.dart';
import 'package:taimoor_starter/ui/onBoarding/onboard.dart';



class SplashServices{

  void isLogin(BuildContext context)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? onboard = prefs.getBool('onBoarded')?? false;
    if (onboard == true){

      Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen())));

    }
    else{

      Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OnBoardingScreen())));

    }


  }


}