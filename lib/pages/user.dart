import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'witchat.dart' as witchat;
import '../login.dart';

class User extends StatefulWidget {
  final String name, email, image;
  const User({Key key, this.name, this.image, this.email}) : super(key: key);
  @override
  _UserState createState() => _UserState();
}

var facebookLogin = FacebookLogin();

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
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 200,
            child: Container(
              color: HexColor('#FFFFFF'),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          witchat.sad = 0;
                          witchat.happy = 0;
                          witchat.angry = 0;
                          _popup(context);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Icon(
                                CupertinoIcons.settings,
                                color: HexColor('#845EC2'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Reset all statistics",
                                style: TextStyle(fontFamily: 'Gotham'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          const url = 'https://developers.facebook.com/terms/';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Icon(
                                CupertinoIcons.info_circle,
                                color: HexColor('#845EC2'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Facebook SDK Terms and Conditions",
                                style: TextStyle(fontFamily: 'Gotham'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          const url = 'https://github.com/ameysunu/F8-Refresh';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Icon(
                                CupertinoIcons.hammer_fill,
                                color: HexColor('#845EC2'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Report an issue",
                                style: TextStyle(fontFamily: 'Gotham'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          const url = 'https:amey.live';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Icon(
                                CupertinoIcons.rocket_fill,
                                color: HexColor('#845EC2'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "About Us",
                                style: TextStyle(fontFamily: 'Gotham'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          facebookLogin.logOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Icon(
                                CupertinoIcons.power,
                                color: HexColor('#845EC2'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Logout",
                                style: TextStyle(fontFamily: 'Gotham'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.07,
            left: 15,
            right: 15,
            child: Card(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.height * .90,
                height: MediaQuery.of(context).size.height * 0.22,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(widget.image),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 15, bottom: 15),
                                child: Text(
                                  "${widget.name}",
                                  style: TextStyle(
                                      fontFamily: 'Gotham', fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _popup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            "Reset Done!",
            style: TextStyle(
                color: HexColor('#FFFFFF'), fontFamily: 'Gotham', fontSize: 30),
          ),
          contentPadding: EdgeInsets.all(0.0),
        );
      });
}
