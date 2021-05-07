import 'package:f8refresh/pages/stats.dart';
import 'package:f8refresh/pages/witchat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'home.dart';

class HomeWidget extends StatefulWidget {
  final String name, email, image;
  const HomeWidget({Key key, this.name, this.email, this.image})
      : super(key: key);
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: HexColor('#E5D6FF'),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(CupertinoIcons.house_fill,
                    color: HexColor('#4A4453')),
                title: new Text(
                  'Home',
                  style: TextStyle(
                      color: HexColor('#5C6178'), fontFamily: 'Gotham'),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(CupertinoIcons.chart_bar_square_fill,
                    color: HexColor('#4A4453')),
                title: new Text(
                  'Stats',
                  style: TextStyle(
                      color: HexColor('#5C6178'), fontFamily: 'Gotham'),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(CupertinoIcons.book_fill,
                    color: HexColor('#4A4453')),
                title: new Text(
                  'Blog',
                  style: TextStyle(
                      color: HexColor('#5C6178'), fontFamily: 'Gotham'),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(CupertinoIcons.person_fill,
                    color: HexColor('#4A4453')),
                title: new Text(
                  'User',
                  style: TextStyle(
                      color: HexColor('#4A4453'), fontFamily: 'Gotham'),
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
        // body: _widgetOptions.elementAt(_selectedIndex),
        body: [Home(name: "${widget.name}"), Stats(), WitChat()]
            .elementAt(_selectedIndex));
  }
}
