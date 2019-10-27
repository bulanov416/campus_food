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
//        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.fastfood),
//          ),
//        ],
//        iconTheme: IconThemeData(
//          color: Colors.white,
//        ),
        backgroundColor: Color(0xff100869),
        centerTitle: true,
        elevation: 0,
        // Commented out is the button to the left of the title
        /*leading: IconButton(
          onPressed: () {},
          iconSize: 21,
          icon: Icon(Icons.map),
        ),*/
        title: Text(
          'Food Friend',
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: TextStyle(fontFamily: 'Baloo', color: Colors.white),
        ),
        // Commented out are the buttons to the right of the title
        /*actions: <Widget>[
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            iconSize: 21,
            icon: Icon(Icons.zoom_in),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            iconSize: 21,
            icon: Icon(Icons.alarm),
          ),
        ],*/
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
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  void _onItemTapped(int index) {

  }
}
