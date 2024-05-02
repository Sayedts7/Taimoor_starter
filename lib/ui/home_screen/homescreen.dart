import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:taimoor_starter/core/utils/common_functions.dart';
import 'package:taimoor_starter/core/utils/image_paths.dart';
import 'package:taimoor_starter/core/utils/theme_helper.dart';
import 'package:taimoor_starter/ui/custom_widgets/custom_buttons.dart';
import 'package:taimoor_starter/ui/custom_widgets/custom_textfields.dart';
import 'package:taimoor_starter/ui/send_to_many/sedntomany.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/mySize.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  BannerAd? _bannerAd;
  BannerAd? _bannerAd2;

  var Ccode;
  @override
  void initState() {
    super.initState();
    _loadAd();
    _loadAd2();


    // Set the input formatter to remove extra spaces
    phoneController.addListener(() {
      final text = phoneController.text;
      final newText = text.replaceAll(' ', '');
      if (newText != text) {
        phoneController.value = phoneController.value.copyWith(
          text: newText,
          selection: TextSelection(
            baseOffset: newText.length,
            extentOffset: newText.length,
          ),
          composing: TextRange.empty,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            // color: Colors.red,
            image: DecorationImage(image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover)
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black54,
            foregroundColor: Colors.white,
            title: const Text('WhatsApp Direct'),
            actions: [
              IconButton(onPressed: () {
                Share.share('https://play.google.com/store/apps/details?id=com.STInnovation.wa_direct&pcampaignid=web_share');
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> SendToMany()));
              }, icon: const Icon(Icons.share)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          bottomNavigationBar:
    SizedBox(
    height: 60,
    width: double.infinity,
    child: _bannerAd2 != null ? AdWidget(ad: _bannerAd2!) : Container(),
    ),
          body: SingleChildScrollView(
            child: Center(
              child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 60,
                          width: double.infinity,
                        child: _bannerAd != null ? AdWidget(ad: _bannerAd!) : Container(),
                      ),
                      // AdWidget(ad: _bannerAd!),

                      SizedBox(height: MySize.size150,),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              color: ThemeColors.black1,
                              borderRadius: BorderRadius.circular(15)),
                          padding: Spacing.all(MySize.size15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IntlPhoneField(

                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  // Implement your validation logic here
                                  if (value!.number.isEmpty) {
                                    return 'Enter a phone number';
                                  } else if (value.completeNumber.length < 10) {
                                    return 'Enter a valid phone number';
                                  }

                                  // Add your specific validation rules, e.g., checking for specific patterns or lengths

                                  return null; // Return null if validation passes
                                },
                                initialCountryCode: 'PK',
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                                disableLengthCheck: true,
                                showCursor: true,
                                decoration: InputDecoration(
                                  fillColor: ThemeColors.grey2,
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(13, 15, 13, 17),
                                  prefixIcon: const Icon(
                                    Icons.phone,
                                  ),
                                  hintText:
                                  'Enter your phone', // AppLocale.phoneNumber.getString(context),
                                  hintStyle: const TextStyle(
                                      color: ThemeColors.grey4, fontSize: 14),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0.5, color: ThemeColors.grey5),
                                    borderRadius: BorderRadius.circular(5),

                                    // borderSide: const BorderSide(),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                      const BorderSide(color: ThemeColors.mainColor, width: 1)

                                    // borderSide: BorderSide(color: appColor1, width: 3)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.redAccent, width: 1)

                                    // borderSide: BorderSide(color: appColor1, width: 3)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.redAccent, width: 1)

                                    // borderSide: BorderSide(color: appColor1, width: 3)
                                  ),
                                ),
                                onChanged: (phone) {
                                  Ccode = phone.countryCode;
                                },
                              ),
                               SizedBox(
                                height: MySize.size15,
                              ),
                              CustomTextField13(
                                controller: msgController,
                                maxLines: 5,
                                fillColor: ThemeColors.grey2,
                                textColor: Colors.black,
                                hintText: 'Enter your text here',
                              ),
                               SizedBox(
                                height: MySize.size15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: MySize.size220,
                                      child: CustomButton8(
                                        text: 'Open Whatsapp',
                                        onPressed: () {
                                          if (phoneController.text.isEmpty) {
                                            CommonFunctions.flushBarErrorMessage(
                                                'Please enter a phone number', context);
                                          } else {
                                            openNormalWhatsApp(Ccode + phoneController.text,
                                                msgController.text);
                                          }
                                        },
                                        backgroundColor: Colors.green,
                                      )),
                                  InkWell(
                                    onTap: () {
                                      if (phoneController.text.isEmpty) {
                                        CommonFunctions.flushBarErrorMessage(
                                            'Please enter a phone number', context);
                                      } else {
                                        openBusinessWhatsApp(Ccode + phoneController.text, msgController.text);
                                      }
                                    },
                                    child: Container(
                                        width: MySize.size95,
                                        height: 55,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SvgPicture.asset(
                                            icWhatsappB,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  )),
            ),
          ),
        )
      ],
    );
  }

  void openNormalWhatsApp(String phoneNumber, text) async {
    final url = Uri.parse('https://wa.me/$phoneNumber?text=$text');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void openBusinessWhatsApp(String phoneNumber, text) async {
    final url = Uri.parse("whatsapp://send?phone=$phoneNumber&text=$text");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  void _loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-9385559783586486/2564160918',
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
  void _loadAd2() {
    final bannerAd2 = BannerAd(
      size: AdSize.banner,
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      adUnitId: 'ca-app-pub-9385559783586486/3030059183',

      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd2 = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd2.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose(); // Dispose the banner when the widget is disposed
    _bannerAd2?.dispose(); // Dispose the banner when the widget is disposed

    super.dispose();
  }


}
