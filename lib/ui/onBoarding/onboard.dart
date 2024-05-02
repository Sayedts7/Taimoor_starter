
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taimoor_starter/ui/home_screen/homescreen.dart';

import '../../../core/utils/image_paths.dart';
import '../../../core/utils/mySize.dart';
import '../../../core/utils/theme_helper.dart';
import '../custom_widgets/custom_buttons.dart';


// OnBoarding content Model
class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

// OnBoarding content list
final List<OnBoard> demoData = [
  OnBoard(
    image: iclogo,
    title: "Welcome",
    description:
    "Welcome to our WA direct! Say goodbye to the hassle of saving phone numbers to message someone on WhatsApp",
  ),
  OnBoard(
    image:iclogo,
    title: "How It Works",
    description:
    "Simply enter the phone number of the person you want to message, and our app will take care of the rest.",
  ),
  OnBoard(
    image: iclogo,
    title: "Benefits",
    description:
    "No more cluttered contacts list! Keep your contacts organized and message anyone without saving their number.",
  ),
  // OnBoard(
  //   image: "assets/images/on-boarding/onboarding4.png",
  //   title: "Title 04",
  //   description:
  //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  // ),
];

// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Variables
  late PageController _pageController;
  int _pageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize page controller
    _pageController = PageController(initialPage: 0);
    // Automatic scroll behaviour
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageIndex < 3) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }

      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // Dispose everything
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // Background gradient
        decoration: const BoxDecoration(
          color: ThemeColors.fillColor
        ),
        child: Column(
          children: [
            // Carousel area
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemCount: demoData.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardContent(
                  title: demoData[index].title,
                  description: demoData[index].description,
                  image: demoData[index].image,
                ),
              ),
            ),
            // Indicator area
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    demoData.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Privacy policy area
            const Text("By proceeding you agree to our Privacy Policy",style: TextStyle(color: ThemeColors.fillColor),),
            // White space
            const SizedBox(
              height: 16,
            ),
            CustomButton8(text: 'Get Started',
                backgroundColor: ThemeColors.mainColor,
                onPressed: ()async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('onBoarded', true).then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomeScreen()), (route) => false);

              });

            }),
            const SizedBox(height: 10,)
            // Button area
    //         InkWell(
    //           onTap: () {
    //           },
    //           child: Container(
    //             margin: const EdgeInsets.only(bottom: 48),
    //             height: MySize.scaleFactorHeight * 50,// Get.height * 0.075,
    //             width: MySize.safeWidth ,//Get.width,
    //             decoration: BoxDecoration(
    // color: ThemeColors.mainColor,
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             child: const Center(
    //               child: Text(
    //                 "Login",
    //                 style: TextStyle(
    //                   fontFamily: "HappyMonkey",
    //                   color: Colors.white,
    //                   fontSize: 18,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
          ],
        ),
      ),
    );
  }
}

// OnBoarding area widget
class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            // color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            // color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(image),
        ),
        const Spacer(),
      ],
    );
  }
}

// Dot indicator widget
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? ThemeColors.mainColor : Colors.white,
        border: isActive ? null : Border.all(color: ThemeColors.mainColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}