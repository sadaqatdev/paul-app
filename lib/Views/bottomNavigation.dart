import 'package:flutter/material.dart';
import 'package:paul_app/Views/sell_page.dart';
import 'package:paul_app/Views/vendorAccount.dart';
import 'package:paul_app/services/api_services.dart';
import 'package:paul_app/widgets/colors.dart';
import 'package:paul_app/widgets/fab_bottom_app_bar.dart';

import 'AddProduct.dart';
import 'allMessages.dart';
import 'homePage.dart';
import 'orders.dart';

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

  @override
  Widget build(BuildContext context) {
    getCategory();
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
}
