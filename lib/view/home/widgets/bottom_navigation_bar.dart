import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindglowequinox/utils/colors.dart';
import 'package:mindglowequinox/view/home/home_screen.dart';
import 'package:mindglowequinox/view/community/community_screen.dart';
import 'package:mindglowequinox/view/resources/resources_screen.dart';
import 'package:mindglowequinox/view/wellness_guide/wellness_guide_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const CommunityScreen(),
    const WellnessGuide(),
    const ResourcesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Appcolor.tranquilTeal,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.house_fill),
              icon: Icon(CupertinoIcons.home),
              label: 'Home'),
          BottomNavigationBarItem(
            activeIcon: Icon(
              CupertinoIcons.group_solid,
              size: 35,
            ),
            icon: Icon(
              CupertinoIcons.group,
              size: 35,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.book_fill),
            icon: Icon(CupertinoIcons.book),
            label: 'Guide',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.cloud_fog_fill),
            icon: Icon(CupertinoIcons.cloud_fog),
            label: 'Resources',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
