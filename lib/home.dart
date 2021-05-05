import 'package:f8refresh/pages/blog.dart';
import 'package:flutter/cupertino.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome,",
                style:
                    GoogleFonts.catamaran(textStyle: TextStyle(fontSize: 17)),
              ),
              Text(
                "${widget.name}",
                style:
                    GoogleFonts.catamaran(textStyle: TextStyle(fontSize: 25)),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: HexColor('#FF6F94')),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                        child: Text(
                          "All our dreams can come true, if we have the courage to pursue them. – Walt Disney.",
                          style: GoogleFonts.pangolin(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                children: [
                  Text("Mood Blogger",
                      style: GoogleFonts.catamaran(
                          textStyle: TextStyle(
                              fontSize: 20, color: HexColor('#3A2F50')))),
                  Icon(CupertinoIcons.arrow_right, color: HexColor('#3A2F50')),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Blog();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: HexColor('#FFC8DB')),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Image.asset('images/mood.png')),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Add a mood",
                              style: GoogleFonts.catamaran(
                                  textStyle:
                                      TextStyle(color: HexColor('#F66C9C'))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: HexColor('#FFCDAE')),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Image.asset('images/moodnew.png')),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text("View moods",
                              style: GoogleFonts.catamaran(
                                  textStyle:
                                      TextStyle(color: HexColor('#EF8D50')))),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
