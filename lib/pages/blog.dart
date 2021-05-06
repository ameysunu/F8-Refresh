import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

final titleController = TextEditingController();
final bodyController = TextEditingController();
final firestoreInstance = FirebaseFirestore.instance;
AsyncSnapshot<DocumentSnapshot> snapshot;
Stream<QuerySnapshot> newStream;

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
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {
        newStream = firestoreInstance.collection('mood').snapshots();
      });
    });
  }

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
          StreamBuilder(
              stream: newStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var totalgroupCount = 0;
                List<DocumentSnapshot> groupUsers;
                if (snapshot.hasData) {
                  groupUsers = snapshot.data.documents;
                  totalgroupCount = groupUsers.length;
                  return (Container(
                    child: ListView.builder(
                        itemCount: groupUsers.length,
                        itemBuilder: (context, int index) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: Container(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      HexColor('#FFA583'),
                                                      HexColor('#EAD74F')
                                                    ])),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Icon(
                                                    Icons.book,
                                                    color: HexColor('#7D7D7D'),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                      groupUsers[index]
                                                          .data()['time']
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontFamily: 'Gotham',
                                                          fontSize: 16,
                                                          color: Colors.white)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                      groupUsers[index]
                                                          .data()['title'],
                                                      style: TextStyle(
                                                          fontFamily: 'Gotham',
                                                          fontSize: 20,
                                                          color: HexColor(
                                                              '#A8617A'))),
                                                ),
                                              ],
                                            )),
                                        onTap: () {
                                          print("tapped");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                secondaryActions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: HexColor('#FF0D0D'),
                                      ),
                                      child: Container(
                                        child: IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.white),
                                          onPressed: () {
                                            print("Delete triggered");
                                            firestoreInstance
                                                .collection('mood')
                                                .doc(groupUsers[index]
                                                    .data()['id'])
                                                .delete()
                                                .then((_) {
                                              print("success!");
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
