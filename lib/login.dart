import 'dart:async';
import 'dart:convert';
import 'package:f8refresh/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;
  var profileData;

  var facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5D6FF'),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: HexColor('#E5D6FF'),
        title: Text("Welcome",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(color: Colors.black))),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('images/login.png'),
              ),
              Text("PACIFY",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 25,
                          color: HexColor('#4A4453'),
                          fontWeight: FontWeight.bold))),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonTheme(
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: HexColor('#3C5898'))),
                        onPressed: () {
                          initiateFacebookLogin();
                          Timer(
                              Duration(seconds: 8),
                              () => {
                                    if (profileData != null)
                                      {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Home(
                                                image: profileData['picture']
                                                    ['data']['url'],
                                                name: profileData['name'],
                                              );
                                            },
                                          ),
                                        )
                                      }
                                    else
                                      {print("Profile is empty")}
                                  });
                        },
                        color: HexColor('#3C5898'),
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                  height: 30,
                                  child: Image.network(
                                      'https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png')),
                            ),
                            Center(
                              child: Text("Sign up with Facebook",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(fontSize: 17))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initiateFacebookLogin() async {
    var facebookLoginResult = await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}'));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        onLoginStatusChanged(true, profileData: profile);
        break;
    }
    return profileData;
  }

  _logout() async {
    await facebookLogin.logOut();
    onLoginStatusChanged(false);
    print("Logged out");
  }
}
