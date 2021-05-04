import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login.dart';

class Home extends StatefulWidget {
  final String name, email, image;
  const Home({Key key, this.name, this.email, this.image}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

var facebookLogin = FacebookLogin();

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5D6FF'),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#E5D6FF'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () async {
                facebookLogin.logOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome,",
              style: GoogleFonts.catamaran(textStyle: TextStyle(fontSize: 17)),
            ),
            Text(
              "${widget.name}",
              style: GoogleFonts.catamaran(textStyle: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
