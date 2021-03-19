import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  double progress = 0;

  final scafoldKey = GlobalKey<ScaffoldState>();

  WebViewController _controller;

  bool isLoading = true;
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.bottom, SystemUiOverlay.top]);
        return true;
      },

      // https://www.threadandthread.com/myclothes/addclothes/
      child: Scaffold(
        key: scafoldKey,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  WebView(
                    initialUrl:
                        'https://www.threadandthread.com/myclothes/addclothes/',
                    onWebViewCreated: (controller) {
                      _controller = controller;
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onPageFinished: (url) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                  isLoading
                      ? Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()))
                      : SizedBox()
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () async {
                    if (await _controller.canGoBack()) {
                      await _controller.goBack();
                    } else {
                      SystemChrome.setEnabledSystemUIOverlays(
                          [SystemUiOverlay.bottom, SystemUiOverlay.top]);
                      Navigator.of(context).pop();
                      return;
                    }
                  },
                ),
                ElevatedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    if (await _controller.canGoForward()) {
                      await _controller.goForward();
                    } else {
                      scafoldKey.currentState.showSnackBar(const SnackBar(
                          content: Text("No forward history item")));

                      return;
                    }
                  },
                ),
                ElevatedButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    _controller.reload();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
