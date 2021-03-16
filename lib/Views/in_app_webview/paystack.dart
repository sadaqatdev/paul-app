// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class PayStack extends StatefulWidget {
//   @override
//   _PayStackState createState() => _PayStackState();
// }

// class _PayStackState extends State<PayStack> {
//   String url = '';
//   double progress = 0;
//   final scafoldKey = GlobalKey<ScaffoldState>();
//   InAppWebViewController webview;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scafoldKey,
//       appBar: AppBar(
//         title: Text('Stripe Payment'),
//       ),
//       body: Stack(
//         children: [
//           InAppWebView(
//             initialUrl: 'https://www.google.com',
//             initialOptions: InAppWebViewGroupOptions(
//                 android: AndroidInAppWebViewOptions(textZoom: 120)),
//             onWebViewCreated: (controller) {
//               webview = controller;
//             },
//             onLoadStart: (controller, url) {},
//             onProgressChanged: (controller, progress) {
//               setState(() {
//                 this.progress = progress / 100;
//               });
//             },
//           ),
//           progress < 1\

//               ? SizedBox(
//                   height: 3,
//                   child: LinearProgressIndicator(
//                     value: progress,
//                     backgroundColor: Colors.red,
//                   ),
//                 )
//               : SizedBox()
//         ],
//       ),
//     );
//   }
// }
