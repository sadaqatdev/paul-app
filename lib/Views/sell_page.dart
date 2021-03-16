import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  double progress = 0;
  final scafoldKey = GlobalKey<ScaffoldState>();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        title: Text('Sell'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://www.threadandthread.com/',
            onWebViewCreated: (controller) {
              _controller.complete(controller);
            },
            javascriptMode: JavascriptMode.unrestricted,
          ),
          progress < 1
              ? SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.red,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
