// ignore_for_file: use_build_context_synchronously


import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  bool _obsecureText = true;

  bool get obsecureText => _obsecureText;

  setObsecureText(bool value) {
    _obsecureText = value;
    notifyListeners();
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  // signInWithGoogle(BuildContext context) async {
  //   changeShowLoaderValue(true);
  //   try {
  //     final googleUser = await GoogleSignIn().signIn();
  //     if (googleUser != null) {
  //       GoogleSignInAuthentication? googleAuth =
  //           await googleUser.authentication;
  //
  //       AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       await FirebaseAuth.instance
  //           .signInWithCredential(credential)
  //           .then((value) {
  //         FirebaseAuth auth = FirebaseAuth.instance;
  //         FirebaseFirestore.instance
  //             .collection("users")
  //             .doc(auth.currentUser!.uid)
  //             .set(
  //           {
  //             "fullname": auth.currentUser!.displayName,
  //             "email": auth.currentUser!.email,
  //             "contact": "",
  //             "password": ""
  //           },
  //         ).then((value) {
  //           changeShowLoaderValue(false);
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (context) => const BottomNavBarView()),
  //             (route) => false,
  //           );
  //           CommonFunctions.flushBarSuccessMessage(
  //               "Login Successfully", context);
  //         });
  //       });
  //     } else {
  //       changeShowLoaderValue(false);
  //       CommonFunctions.flushBarErrorMessage("Something Went Wrong", context);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     changeShowLoaderValue(false);
  //     CommonFunctions.flushBarErrorMessage(e.code, context);
  //   }
  // }
  //
  // signInWithApple(BuildContext context) async {
  //   try {
  //     changeShowLoaderValue(true);
  //     final appleProvider = AppleAuthProvider();
  //     await FirebaseAuth.instance
  //         .signInWithProvider(appleProvider)
  //         .then((value) {
  //       FirebaseAuth auth = FirebaseAuth.instance;
  //       FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(auth.currentUser!.uid)
  //           .set(
  //         {
  //           "fullname": auth.currentUser!.displayName,
  //           "email": auth.currentUser!.email,
  //           "contact": "",
  //           "password": ""
  //         },
  //       ).then((value) {
  //         changeShowLoaderValue(false);
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => const BottomNavBarView()),
  //           (route) => false,
  //         );
  //         CommonFunctions.flushBarSuccessMessage("Login Successfully", context);
  //       });
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     changeShowLoaderValue(false);
  //     CommonFunctions.flushBarErrorMessage(e.code, context);
  //   }
  // }
  //
  // forgotPassword(String email, BuildContext context) async {
  //   try {
  //     changeShowLoaderValue(true);
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: email)
  //         .then((value) {
  //       changeShowLoaderValue(false);
  //       Navigator.pop(context);
  //       CommonFunctions.flushBarSuccessMessage(
  //           "Reset Email Sent Successfully", context);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     changeShowLoaderValue(false);
  //     CommonFunctions.flushBarErrorMessage(e.code, context);
  //   }
  // }
  //
  // signInWithEmailPassword(
  //     String email, String password, BuildContext context) async {
  //   try {
  //     changeShowLoaderValue(true);
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //       email: email.trim(),
  //       password: password,
  //     )
  //         .then((value) {
  //       changeShowLoaderValue(false);
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => const BottomNavBarView()),
  //         (route) => false,
  //       );
  //       CommonFunctions.flushBarSuccessMessage("Login Successfully", context);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     changeShowLoaderValue(false);
  //     CommonFunctions.flushBarErrorMessage(e.code, context);
  //   }
  // }
}
