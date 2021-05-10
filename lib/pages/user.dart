import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class User extends StatefulWidget {
  final String name, email, image;
  const User({Key key, this.name, this.image, this.email}) : super(key: key);
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5D6FF'),
      appBar: AppBar(
        backgroundColor: HexColor('#E5D6FF'),
        elevation: 0,
        title: Text(
          "User Information",
          style: TextStyle(fontFamily: 'Gotham', color: Colors.black),
        ),
      ),
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
          ),
        ],
      ),
    );
  }
}
