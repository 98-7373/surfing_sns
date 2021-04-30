import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:surfing_sns/view/page/feed_page.dart';
import 'package:surfing_sns/view/page/profile_page.dart';
import 'package:surfing_sns/view/page/surf_search_page.dart';
import 'package:surfing_sns/view/page/team_page.dart';
import 'package:surfing_sns/view/page/weather_page.dart';

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
    FeedPage(),
    SurfSearchPage(),
    TeamPage(),
    WeatherPage(),
    ProfilePage(),
  ];
  super.initState();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
              label: ("Home"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            label: ("Search"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.plusSquare),
            label: ("Team"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.sun),
            label: ("Weather"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: ("Profile"),
          ),
        ],
      ),
    );
  }
}
