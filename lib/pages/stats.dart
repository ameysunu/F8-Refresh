import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Stats extends StatefulWidget {
  final String name, image;
  const Stats({Key key, this.name, this.image}) : super(key: key);
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#E5D6FF'),
        elevation: 0,
        title: Text(
          'Your mood stats',
          style: TextStyle(fontFamily: 'Gotham', color: Colors.black),
        ),
      ),
      backgroundColor: HexColor('#E5D6FF'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: HexColor('#E5D6FF'),
                  backgroundImage: NetworkImage(widget.image),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "${widget.name}",
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 17),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
