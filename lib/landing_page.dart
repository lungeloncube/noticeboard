import 'package:digital_notice_board/comments.dart';
import 'package:digital_notice_board/home.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const String LOG_NAME='screen.home';
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      dev.log('dfsdsf', name: LOG_NAME);
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _tabs.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        selectedItemColor:Colors.blue[900],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 5,
        type: BottomNavigationBarType.fixed,// this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home', style:TextStyle(fontFamily: 'Trebuchet')),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('Notifications',style:TextStyle(fontFamily: 'Trebuchet')),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search',style:TextStyle(fontFamily: 'Trebuchet'))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Customers',style:TextStyle(fontFamily: 'Trebuchet'))
          )
        ],
      ),
    );
  }
}
