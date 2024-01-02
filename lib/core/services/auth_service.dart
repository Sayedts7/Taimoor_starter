//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:taimoor_starter/core/services/url_service.dart';
//
// import '../providers/loading_provider.dart';
//
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   // Sign in with email and password
//   Future<UserCredential?> signInWithEmail(BuildContext context,String email, String password) async {
//     try {
//       final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return userCredential;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Exception is here bro: $e, Type: ${e.runtimeType}');
//       }
//
//       if (e is FirebaseAuthException) {
//         String errorMessage = '';
//         switch (e.code) {
//           case 'invalid-email':
//             errorMessage = 'Invalid email address.';
//             break;
//           case 'user-not-found':
//             errorMessage = 'User not found. Please sign up.';
//             break;
//           case 'wrong-password':
//             errorMessage = 'Invalid password.';
//             break;
//         // Add more cases as per your requirements
//           default:
//             errorMessage = 'An error occurred. Please try again later.';
//         }
//
//         _showErrorDialog(context, errorMessage);
//       } else {
//         if (kDebugMode) {
//           print('Error signing in and out: $e');
//         }
//         // Handle other types of exceptions or unknown errors
//       }
//     }
//   }
//
//   // Sign up with email and password
//   Future<UserCredential?> signUpWithEmail(BuildContext context, String email, String password) async {
//     try {
//       final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//
//       return userCredential;
//     } catch (e) {
//       if (e is FirebaseAuthException) {
//         String errorMessage = '';
//         switch (e.code) {
//           case 'invalid-email':
//             errorMessage = 'Invalid email address.';
//             break;
//           case 'user-not-found':
//             errorMessage = 'User not found. Please sign up.';
//             break;
//           case 'wrong-password':
//             errorMessage = 'Invalid password.';
//             break;
//           case'email-already-in-use':
//             errorMessage = 'The email address is already in use by another account.';
//             break;
//         // Add more cases as per your requirements
//           default:
//             errorMessage = 'An error occurred. Please try again later.';
//         }
//         _showErrorDialog(context, errorMessage);
//
//       } else {
//         if (kDebugMode) {
//           print('Error signing in and out: $e');
//         }
//         // Handle other types of exceptions or unknown errors
//       }
//       print('Error signing up with email and password: $e');
//       return null;
//     }
//   }
//
//   // Sign in with Google
//   // Future<UserCredential?> signInWithGoogle() async {
//   //   try {
//   //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//   //     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//   //     String? userType = await getUserType(googleUser.email.toString());
//   //     bool userTypeU = await checkEmailExists(googleUser.email.toString());
//   //     final AuthCredential credential = GoogleAuthProvider.credential(
//   //       accessToken: googleAuth.accessToken,
//   //       idToken: googleAuth.idToken,
//   //     );
//   //
//   //     if(userTypeU == true){
//   //       if(userType == 'GoogleSignInU'){
//   //         final UserCredential userCredential = await _auth.signInWithCredential(credential);
//   //         return userCredential;
//   //       }else if(userType == 'emailSignUpU'){
//   //         Utils.toastMessage('Sign in with password');
//   //         signOut();
//   //       }
//   //     else{
//   //         FirebaseFirestore.instance.collection('User').doc(googleUser.id).set(
//   //             {
//   //               'email': googleUser.email,
//   //               'id': googleUser.id,
//   //               'userType': 'GoogleSignInU',
//   //             });
//   //
//   //         final UserCredential userCredential = await _auth.signInWithCredential(credential);
//   //         return userCredential;
//   //
//   //         Utils.toastMessage('Sign in with Password');
//   //     }
//   //     }else{
//   //       Utils.toastMessage('no account');
//   //       // FirebaseFirestore.instance.collection('User').doc(googleUser.id).set(
//   //       //     {
//   //       //       'email': googleUser.email,
//   //       //       'id': googleUser.id,
//   //       //       'userType': 'GoogleSignInU',
//   //       //     });
//   //       //
//   //       // final UserCredential userCredential = await _auth.signInWithCredential(credential);
//   //       // return userCredential;
//   //     }
//   //
//   //
//   //   } catch (e) {
//   //     print('Error signing in with Google: $e');
//   //     return null;
//   //   }
//   // }
//
//   // Sign in with Apple
//   /// apple login
//   // Future<void> _signInWithApple(BuildContext context) async {
//   //   String displayName = '';
//   //   try {
//   //     final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //     final bool hasSavedCredentials = prefs.containsKey('email') &&
//   //         prefs.containsKey('name');
//   //
//   //     if (hasSavedCredentials) {
//   //       print("calling saved credentials");
//   //       final appleCredential = await SignInWithApple.getAppleIDCredential(
//   //         scopes: [
//   //           AppleIDAuthorizationScopes.email,
//   //           AppleIDAuthorizationScopes.fullName,
//   //         ],
//   //       );
//   //
//   //       final oauthCredential = OAuthProvider("apple.com").credential(
//   //         idToken: appleCredential.identityToken,
//   //         accessToken: appleCredential.authorizationCode,
//   //       );
//   //       CollectionReference user = FirebaseFirestore.instance.collection(
//   //           'User');
//   //       final QuerySnapshot document = await user.where(
//   //           "email", isEqualTo: prefs.getString('email').toString()).get();
//   //
//   //       ///check if user exist with this email
//   //       if (document.docs.isNotEmpty) {
//   //         final Map<String, dynamic> type = document.docs.first.data() as Map<
//   //             String,
//   //             dynamic>;
//   //         print(type);
//   //         if (!type.containsValue("apple")) {
//   //           print(type);
//   //           Utils.toastMessage("Please Login With  ${type["signUpWith"]}");
//   //         } else {
//   //           print("User exist with apple email");
//   //           await FirebaseAuth.instance.signInWithCredential(oauthCredential)
//   //               .then((credential) async {
//   //             String? isPhone =await getPhone();
//   //             String? userStatus= await getUserStatus(prefs.getString('email').toString());
//   //             bool? userDeleteStatus= await getUserDeleteStatus(prefs.getString('email').toString());
//   //
//   //             if(userDeleteStatus == false){
//   //               if(userStatus == 'Activate'){
//   //                 if(isPhone == ''){
//   //                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInWithPhone()));
//   //                 }else{
//   //                   Utils.toastMessage('Signed In');
//   //                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
//   //                 }
//   //               }else{
//   //                 _showDialog(context, 'User is deactivated by admin, Kindly contact admin');
//   //                 signOut();
//   //               }
//   //             }else{
//   //               Utils.showDeletedDialog(context);
//   //               signOut();
//   //             }
//   //
//   //           });
//   //         }
//   //       } else {
//   //         ///first time registration
//   //         await FirebaseAuth.instance.signInWithCredential(oauthCredential)
//   //             .then((credential) async {
//   //           CollectionReference users = FirebaseFirestore.instance.collection(
//   //               'User');
//   //           users.doc(credential.user!.uid).set({
//   //             "email": prefs.getString('email').toString(),
//   //             "id": credential.user!.uid,
//   //             "name": prefs.getString('name').toString(),
//   //             'phone':'',
//   //             'verified': false,
//   //             "signUpWith": "apple",
//   //             "userType": "User",
//   //             "notification": true,
//   //             'isDeleted': false,
//   //             'deleteTime': '',
//   //           });
//   //           Navigator.pushReplacement(context,
//   //               MaterialPageRoute(builder: (context) =>
//   //                   SignUpWIthPhoneAndEmail(name: prefs.getString('name').toString(), email: prefs.getString('email').toString(),)));
//   //         });
//   //       }
//   //       //saved credentioal end
//   //     }
//   //     else {
//   //       print("Calling First Time to save Credentials");
//   //       final appleCredential = await SignInWithApple.getAppleIDCredential(
//   //         scopes: [
//   //           AppleIDAuthorizationScopes.email,
//   //           AppleIDAuthorizationScopes.fullName,
//   //         ],
//   //       );
//   //
//   //       displayName = "${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}";
//   //       prefs.setString('email', appleCredential.email.toString());
//   //       prefs.setString('name', displayName);
//   //
//   //       final oauthCredential = OAuthProvider("apple.com").credential(
//   //         idToken: appleCredential.identityToken,
//   //         accessToken: appleCredential.authorizationCode,
//   //       );
//   //       CollectionReference user = FirebaseFirestore.instance.collection('User');
//   //       final QuerySnapshot document = await user.where("email" ,isEqualTo:  appleCredential.email).get();
//   //       ///check if user exist with this email
//   //       if(document.docs.isNotEmpty)
//   //       {
//   //         final Map<String,dynamic> type =  document.docs.first.data() as Map<String , dynamic>;
//   //         print(type);
//   //         if(!type.containsValue("apple"))
//   //         {
//   //           print(type);
//   //           Utils.toastMessage("Please Login With  ${type["signUpWith"]}");
//   //         }else
//   //         {
//   //           print("User exist with apple email");
//   //           await FirebaseAuth.instance.signInWithCredential(oauthCredential).then((
//   //               credential) async {
//   //             String? isPhone =await getPhone();
//   //             String? userStatus= await getUserStatus(prefs.getString('email').toString());
//   //             bool? userDeleteStatus= await getUserDeleteStatus(prefs.getString('email').toString());
//   //
//   //             if(userDeleteStatus == false){
//   //               if(userStatus == 'Activate'){
//   //                 if(isPhone == ''){
//   //                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInWithPhone()));
//   //                 }else{
//   //                   Utils.toastMessage('Signed In');
//   //                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
//   //                 }
//   //               }else{
//   //                 _showDialog(context, 'User is deactivated by admin, Kindly contact admin');
//   //                 signOut();
//   //               }
//   //             }else{
//   //               Utils.showDeletedDialog(context);
//   //               signOut();
//   //             }
//   //
//   //           });
//   //         }
//   //       }else {
//   //         ///first time registation
//   //         await FirebaseAuth.instance.signInWithCredential(oauthCredential).then((
//   //             credential) async {
//   //           CollectionReference users = FirebaseFirestore.instance.collection(
//   //               'User');
//   //           users.doc(credential.user!.uid).set({
//   //             "email": credential.user!.email,
//   //             "id": credential.user!.uid,
//   //             "name": displayName,
//   //             'phone':'',
//   //             'verified': false,
//   //             "signUpWith": "apple",
//   //             "userType": "User",
//   //             "notification": true,
//   //             'isDeleted': false,
//   //             'deleteTime': '',
//   //           });
//   //           Navigator.pushReplacement(context,
//   //               MaterialPageRoute(builder: (context) =>
//   //                   SignUpWIthPhoneAndEmail(name: prefs.getString('name').toString(), email: prefs.getString('email').toString(),)));
//   //         });
//   //       }
//   //     }
//   //   } catch (error) {
//   //     print("Apple Sign-In Error: $error");
//   //   }
//   // }
//
//   // Future<void> handleAppleSignIn(BuildContext context)async {
//   //   _signInWithApple(context);
//   // }
//
//   // Send password reset email
//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       print('Error sending password reset email: $e');
//     }
//   }
//
//
//   // Sign out
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//       // await _googleSignIn.signOut();
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   // Get error message based on the exception
//   String _getErrorMessage(dynamic exception) {
//     if (exception is FirebaseAuthException) {
//       switch (exception.code) {
//         case 'user-not-found':
//           return 'User not found.';
//         case 'wrong-password':
//           return 'Wrong password.';
//         case 'weak-password':
//           return 'The password provided is too weak.';
//         case 'email-already-in-use':
//           return 'The account already exists for that email.';
//         default:
//           return 'An error occurred. Please try again.';
//       }
//     } else {
//       return 'An unexpected error occurred. Please try again.';
//     }
//   }
//   // Show error dialog
//
//   void _showErrorDialog(BuildContext context,String errorMessage) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(errorMessage),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   final firestore = FirebaseFirestore.instance.collection('User');
//
//   Future<void> setData(String email, name, type, phone) async {
//     final DocumentReference parentDocument = firestore.doc(FirebaseAuth.instance.currentUser!.uid);
//
//     await parentDocument.set({
//       'id': FirebaseAuth.instance.currentUser!.uid,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'verified': false,
//       'userType': 'User',
//       'signUpWith': type,
//       'notification': true,
//       'status':'Activate',
//       'isDeleted': false,
//       'deleteTime': '',
//     });
//
//     // Add a document to the subcollection
//   }
//   void _showDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('User Inactive', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 UrlService.launchURL('mailto:taimoor00777@gmail.com');
//                 final loadingProvider =
//                 Provider.of<LoadingProvider>(context, listen: false);
//                 loadingProvider.loginLoading(false);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Contact'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final loadingProvider =
//                 Provider.of<LoadingProvider>(context, listen: false);
//                 loadingProvider.loginLoading(false);
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   ///google
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;
//   // Future googleLogin(BuildContext context) async {
//   //   final googleUser = await googleSignIn.signIn();
//   //
//   //   _user = googleUser;
//   //
//   //   final googleAuth = await googleUser!.authentication;
//   //   final credential = GoogleAuthProvider.credential(
//   //     accessToken: googleAuth.accessToken,
//   //     idToken: googleAuth.idToken,
//   //   );
//   //   String? appType = await getUserType(user.email);
//   //   String? appTypeO = await getUserTypeO(user.email);
//   //   bool? userType = await checkGoogleExists(user.email);
//   //   bool? userEmail = await checkEmailExists(user.email);
//   //
//   //   if (appType == 'User') {
//   //     print('in user if');
//   //     if (userType != true) {
//   //       print('in userType if');
//   //
//   //       if (userEmail == true) {
//   //         print('in useremail if');
//   //
//   //         Utils.toastMessage(
//   //             'Email already linked with another account, log In to your email and password');
//   //         signOutGoogle();
//   //       } else {
//   //         print('in useremail else');
//   //
//   //         await FirebaseAuth.instance
//   //             .signInWithCredential(credential)
//   //             .then((value) async {
//   //
//   //           setData(user.email.toString(), user.displayName.toString(),
//   //               'google','')
//   //               .then((value) async {
//   //
//   //             Navigator.pushReplacement(context,
//   //                 MaterialPageRoute(builder: (context)=>
//   //                     SignUpWIthPhoneAndEmail(name: user.displayName.toString(), email: user.email.toString(),)));
//   //
//   //
//   //           });
//   //         });
//   //       }
//   //     } else {
//   //       await FirebaseAuth.instance
//   //           .signInWithCredential(credential)
//   //           .then((value) async {
//   //         String? userStatus= await getUserStatus(user.email.toString());
//   //         bool? userDeleteStatus= await getUserDeleteStatus(user.email.toString());
//   //
//   //         String? isPhone =await getPhone();
//   //         if(userDeleteStatus == false){
//   //           if(userStatus == 'Activate' ) {
//   //             if(isPhone == ''){
//   //
//   //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInWithPhone()));
//   //             }else{
//   //               Utils.toastMessage('Signed In');
//   //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
//   //             }
//   //           }else{
//   //             _showDialog(context, 'User is deactivated by admin, Kindly contact admin');
//   //             signOut();
//   //           }
//   //         }else{
//   //
//   //           Utils.showDeletedDialog(context);
//   //           signOut();
//   //
//   //
//   //         }
//   //
//   //       });
//   //     }
//   //   } else {
//   //     print('in user else');
//   //     print(appTypeO);
//   //
//   //     if (appTypeO == 'Owner') {
//   //       Utils.toastMessage('account linked with other app');
//   //       signOutGoogle();
//   //     } else {
//   //       print(appTypeO);
//   //       print('in user else else');
//   //
//   //       await FirebaseAuth.instance
//   //           .signInWithCredential(credential)
//   //           .then((value) async {
//   //
//   //         setData(
//   //             user.email.toString(), user.displayName.toString(), 'google','sdfdfsd')
//   //             .then((value) {
//   //           Navigator.pushReplacement(
//   //               context,
//   //               MaterialPageRoute(builder: (context)=>
//   //                   SignUpWIthPhoneAndEmail(name: user.displayName.toString(), email: user.email.toString(),)));
//   //
//   //         });
//   //       });
//   //     }
//   //   }
//   // }
//   void signOutGoogle() async {
//     await googleSignIn.signOut();
//     await signOut();
//     // Perform any additional cleanup or state reset if necessary
//   }
//   // Future<void> handleSignInWithApple() async {
//   //   try {
//   //     // Your Apple Sign In logic goes here
//   //
//   //     // Example: Sign out
//   //     await _handleSignOut();
//   //   } catch (e) {
//   //     print('Error signing in with Apple: $e');
//   //   }
//   // }
//
//   // Future<void> _handleSignOut() async {
//   //   try {
//   //     // Sign out
//   //     await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email]);
//   //     print('Signed out successfully');
//   //   } catch (e) {
//   //     print('Error signing out: $e');
//   //   }
//   // }
//
//
// }