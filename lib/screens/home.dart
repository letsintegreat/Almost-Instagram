import 'package:flutter/material.dart';
import 'package:instagram/screens/home_tabs/home_home.dart';
import 'package:instagram/screens/home_tabs/home_newpost.dart';
import 'package:instagram/screens/home_tabs/home_profile.dart';
import 'package:instagram/screens/home_tabs/home_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> tabs = [
    HomeHomeTab(),
    HomeSearchTab(),
    HomeNewpostTab(),
    HomeHomeTab(),
    HomeProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 22.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Color(0xFF121212),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: "home",
            icon: Image.asset(
              (_currentIndex == 0)
                  ? "assets/nav_home_s.png"
                  : 'assets/nav_home.png',
              width: 22.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "search",
            icon: Image.asset(
              (_currentIndex == 1)
                  ? "assets/nav_search_s.png"
                  : 'assets/nav_search.png',
              width: 22.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "reel",
            icon: Image.asset(
              'assets/nav_reel.png',
              width: 22.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "notif",
            icon: Image.asset(
              (_currentIndex == 3)
                  ? "assets/nav_notif_s.png"
                  : 'assets/nav_notif.png',
              width: 22.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "profile",
            icon: Image.asset(
              'assets/nav_profile.png',
              width: 22.0,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
