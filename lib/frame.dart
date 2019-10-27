import 'package:campus_food/trending_view.dart';
import 'package:flutter/material.dart';
import 'map_view.dart';
import 'social_view.dart';
import 'settings_view.dart';

class Frame extends StatefulWidget {
  final String pageTitle;

  Frame({Key key, this.pageTitle}) : super(key: key);

  @override
  FrameState createState() => FrameState();
}

class FrameState extends State<Frame> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      MapView(),
      TrendingView(),
      SocialView(),
      SettingsView(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffbdd8ff),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Campus Eats',
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 25),),
        ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Trending'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Social'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          )
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
