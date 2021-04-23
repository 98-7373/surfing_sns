import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Widget> _pages;
int _currentIndex = 0;

@override
void initState() {
  _pages = [
    // FeedPage(),
    // SurfSearchPage(),
    // TeamPage(),
    // WeatherPage(),
    // ProfilePage(),
  ];
  // super.initState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: ("home"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            label: ("search"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.teamspeak),
            label: ("teamspeak"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.dailymotion),
            label: ("dailymotion"),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.horse),
            label: ("horse"),
          ),
        ],
      ),
    );
  }
}
