import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:surfing_sns/presentation/feed_list/feed_screen.dart';
import 'package:surfing_sns/presentation/map_list/map_screen.dart';
import 'package:surfing_sns/presentation/page/profile_page.dart';
import 'package:surfing_sns/presentation/page/weather_page.dart';
import 'package:surfing_sns/presentation/surf_list/surf_screen.dart';
import 'package:surfing_sns/presentation/widget/profile.dart';
import 'package:surfing_sns/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 List<Widget> _pages;
 int _currentIndex = 0;

@override
void initState() {
  _pages = [
    FeedScreen(),
    // SurfScreen(),
    MapScreen(),
    // WeatherPage(),
    // ProfileScreen(),
  ];
  super.initState();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: ("掲示板"),
          ),
           // BottomNavigationBarItem(
           //    icon: FaIcon(FontAwesomeIcons.search),
           //   label: ("スポット"),
           // ),
           BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.map),
            label: ("マップ"),
          ),
          // BottomNavigationBarItem(
          //   icon: FaIcon(FontAwesomeIcons.sun),
          //   label: ("天気"),
          // ),
          // BottomNavigationBarItem(
          //   icon: FaIcon(FontAwesomeIcons.user),
          //   label: ("プロフィール"),
          // ),
        ],
      ),
    );
  }
}
