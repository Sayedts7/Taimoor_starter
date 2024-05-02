// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class SendToMany extends StatelessWidget {
//   const SendToMany({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WhatsApp Sender'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             List<String> contacts = ['+923345157342','+923075902422']; // Add your contacts here
//             String message = 'Hello, this is a test message!'; // Your message
//             openNormalWhatsApp(contacts, message);
//           },
//           child: Text('Send Message'),
//         ),
//       ),
//     );
//   }
//
//
//   void openNormalWhatsApp(List phoneNumber, text) async {
//     for(int i = 0; i< phoneNumber.length; i++){
//       final url = Uri.parse('https://wa.me/${phoneNumber[i]}?text=$text');
//       if (!await launchUrl(url)) {
//         throw Exception('Could not launch $url');
//       }
//     }
//
//
//   }
//
// }
