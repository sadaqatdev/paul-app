import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paul_app/Views/sell_page.dart';
import 'package:paul_app/Views/vendorAccount.dart';
import 'package:paul_app/services/api_services.dart';
import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/fab_bottom_app_bar.dart';

import 'allMessages.dart';
import 'homePage.dart';
import 'orders.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _selectedTab = 0;

  final _pageOptions = [
    HomePage(),
    Messages(),
    OrderPage(),
    VendorAccount(),

    // user_home(),
    // user_search(),
    // user_Calender(),
    // user_notification(),
    // user_profile(),
  ];
  ApiServices services = ApiServices();
  void getCategory() async {
    await services.getCategories();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin fltNotification;

  @override
  void initState() {
    notitficationPermission();
    initMessaging();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    super.initState();
  }

  void getToken() async {
    print(await messaging.getToken());
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    return Scaffold(
      body: _pageOptions[_selectedTab],
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Sell',
        iconSize: 20,
        color: Colors.grey,
        selectedColor: basicColorShopper,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (int index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: [
          FABBottomAppBarItem(
            iconData: Icons.home_outlined,
            text: 'Browse',
          ),
          FABBottomAppBarItem(iconData: Icons.messenger, text: 'Messages'),
          FABBottomAppBarItem(iconData: Icons.shopping_cart, text: 'Orders'),
          FABBottomAppBarItem(iconData: Icons.person_outline, text: 'Account'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          _buildFab(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: basicColorcustomer,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SellPage()));
      },
      tooltip: 'Increment',
      child: Icon(Icons.camera_alt),
      elevation: 2.0,
    );
  }

  void initMessaging() {
    var androiInit = AndroidInitializationSettings('ic_launcher');

    var iosInit = IOSInitializationSettings();

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification();
      print('--------------------------------');
    });
  }

  void showNotification() async {
    var androidDetails =
        AndroidNotificationDetails('1', 'channelName', 'channel Description');

    var iosDetails = IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await fltNotification.show(0, 'title', 'body', generalNotificationDetails,
        payload: 'Notification');
  }

  void notitficationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
