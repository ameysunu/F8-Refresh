import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

final titleController = TextEditingController();
final bodyController = TextEditingController();
final firestoreInstance = FirebaseFirestore.instance;

DateTime now = DateTime.now();
String newDate = DateFormat('EEE d MMM, kk:mm').format(now);

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('#FFC8DB'),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#FFC8DB'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                CupertinoIcons.multiply_circle_fill,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(newDate.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 18,
                    color: HexColor('#E60053'))),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Enter mood".toUpperCase(),
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 20,
                    color: HexColor('#E60053'))),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: HexColor('#E60053'),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white, fontFamily: 'Gotham'),
                  decoration: new InputDecoration(
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintStyle: TextStyle(
                      fontFamily: 'Gotham',
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    labelStyle:
                        TextStyle(fontFamily: 'Gotham', color: Colors.white),
                    hintText: 'Title',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: HexColor('#E60053'),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: TextFormField(
                    controller: bodyController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(color: Colors.white, fontFamily: 'Gotham'),
                    decoration: new InputDecoration(
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontFamily: 'Gotham',
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      labelStyle:
                          TextStyle(fontFamily: 'Gotham', color: Colors.white),
                      hintText: 'Add your blog\'s body',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newRecord();
          clear();
        },
        backgroundColor: HexColor('#E60053'),
        child: Icon(CupertinoIcons.checkmark_alt),
      ),
    );
  }
}

void newRecord() async {
  firestoreInstance
      .collection('mood')
      .doc('${now.day}${now.month}${now.year}')
      .set({
    "title": titleController.text,
    "body": bodyController.text,
    "id": '${now.day}${now.month}${now.year}',
    "time": "$newDate",
  }).then((_) {
    print("success!");
  });
}

void clear() {
  titleController.clear();
  bodyController.clear();
}

class ViewBlog extends StatefulWidget {
  @override
  _ViewBlogState createState() => _ViewBlogState();
}

class _ViewBlogState extends State<ViewBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFCDAE'),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#FFCDAE'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                CupertinoIcons.multiply_circle_fill,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(newDate.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 18,
                    color: HexColor('#FF7018'))),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Your moods".toUpperCase(),
                style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 20,
                    color: HexColor('#FF7018'))),
          ),
        ],
      ),
    );
  }
}
