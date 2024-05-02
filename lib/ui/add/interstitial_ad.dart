// import 'package:flutter/cupertino.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class InterstitialExampleState extends State<InterstitialExample> {
//   InterstitialAd? _interstitialAd;
//
//   // TODO: replace this test ad unit with your own ad unit.
//   final adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-3940256099942544/1033173712'
//       : 'ca-app-pub-3940256099942544/4411468910';
//
//   /// Loads an interstitial ad.
//   void loadAd() {
//     InterstitialAd.load(
//         adUnitId: adUnitId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             ad.fullScreenContentCallback = FullScreenContentCallback(
//               // Called when the ad showed the full screen content.
//                 onAdShowedFullScreenContent: (ad) {},
//                 // Called when an impression occurs on the ad.
//                 onAdImpression: (ad) {},
//                 // Called when the ad failed to show full screen content.
//                 onAdFailedToShowFullScreenContent: (ad, err) {
//                   // Dispose the ad here to free resources.
//                   ad.dispose();
//                 },
//                 // Called when the ad dismissed full screen content.
//                 onAdDismissedFullScreenContent: (ad) {
//                   // Dispose the ad here to free resources.
//                   ad.dispose();
//                 },
//                 // Called when a click is recorded for an ad.
//                 onAdClicked: (ad) {});
//
//             debugPrint('$ad loaded.');
//             // Keep a reference to the ad so you can show it later.
//             _interstitialAd = ad;
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (LoadAdError error) {
//             debugPrint('InterstitialAd failed to load: $error');
//           },
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
