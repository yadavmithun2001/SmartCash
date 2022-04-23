import 'package:flutter/material.dart';

import '../constants.dart';
import 'home.dart';

class HomeTabController extends StatefulWidget {
  @override
  _HomeTabControllerState createState() => _HomeTabControllerState();
}

class _HomeTabControllerState extends State<HomeTabController> {
  int selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HomePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/vuesax-bold-chart-square-1@2x.png"),
                color: selectedIndex == 0 ? sColor : Colors.grey,
              ),
              label: "Dashboard"
                        ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/vuesax-bold-empty-wallet@2x.png"),
                color: selectedIndex == 1 ? sColor : Colors.grey,
              ),
                label: 'Wallet'
                        ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/Group 17553@2x.png"),
                color: selectedIndex == 2 ? sColor : Colors.grey,
              ),
                label: "Wallet"

            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("images/vuesax-bold-card-pos@2x.png"),
                color: selectedIndex == 3 ? sColor : Colors.grey,
              ),
                label: "Card"
                       ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: sColor,
          onTap: _onItemTapped,
          elevation: 5),
      body: SafeArea(child: _widgetOptions.elementAt(selectedIndex)),
    );
  }
}
