import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'fav_radios_page.dart';
import 'radio_page.dart';
import 'smart_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _childern = [
    new RadioPage(isFavouriteOnly: false),
    FavRadiosPage(),
    SmartScreen(),
    //Genre(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: _childern[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: HexColor("#182545"),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: HexColor("#ffffff"),
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          items: [
            _bottomNavItem(Icons.play_arrow, "Listen"),
            _bottomNavItem(Icons.favorite, "Favorite"),
            _bottomNavItem(Icons.search, "Search"),
            //_bottomNavItem(Icons.masks, "Genre")
          ],
          onTap: onTabTapped,
        ),
      ),
    );
  }

  _bottomNavItem(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: new Icon(
        icon,
        color: HexColor("#6d7381"),
      ),
      activeIcon: new Icon(
        icon,
        color: HexColor("#ffffff"),
      ),
      label: title,
    );
  }

  void onTabTapped(int index) {
    if (!mounted) return;
    setState(() {
      _currentIndex = index;
    });
  }
}
