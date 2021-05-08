import 'dart:async';
import 'dart:convert';
import 'package:f8refresh/pages/voice.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

final titleController = TextEditingController();

// var botvalue = "Do you want to vent?";
var botvalue = '';

class WitChat extends StatefulWidget {
  WitChat({Key key}) : super(key: key);

  @override
  _WitChatState createState() => _WitChatState();
}

class _WitChatState extends State<WitChat> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> chatList = [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: HexColor('#FFFFFF'),
        ),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                  child: Text(
                    "Hello! How can I help yout today?",
                    style: TextStyle(fontFamily: 'Gotham'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5D6FF'),
      appBar: AppBar(
        backgroundColor: HexColor('#E5D6FF'),
        elevation: 0,
        title: Text(
          'wit.ai Bot',
          style: TextStyle(fontFamily: 'Gotham', color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          ...chatList,
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                backgroundColor: HexColor('#FFFFFF'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Voice();
                  }));
                },
                child: Icon(
                  Icons.mic,
                  color: HexColor('#9E6CF6'),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black26,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: new InputDecoration(
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Gotham',
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          labelStyle: TextStyle(
                              fontFamily: 'Gotham', color: Colors.white),
                          hintText: 'Send a message',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    fetchPost();
                    setState(() {
                      chatList.add(Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: HexColor('#4245FF'),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 20, 10, 20),
                                          child: Text(
                                            "You: ${titleController.text}",
                                            style: TextStyle(
                                                fontFamily: 'Gotham',
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: HexColor('#FFFFFF')),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 25, 10, 25),
                                      child: Text(
                                        "wit.ai Bot: $botvalue",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                    });
                  })
            ],
          ),
        ],
      ),
    );
  }
}

Future<String> fetchPost() async {
  final response = await http.get(
      Uri.parse(
          'https://api.wit.ai/message?v=20210507&q=${titleController.text}'),
      headers: {'Authorization': 'Bearer TXGBHYKKFQ7BU3BMKM7IAVYO5IGGN5DE'});

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    var witop = json.decode(response.body);
    if (witop['traits']['wit\$sentiment'][0]['value'] == "negative") {
      botvalue = "So sorry to hear that. Did you try writing your mood down?";
    } else if (witop['traits']['wit\$sentiment'][0]['value'] == "positive") {
      botvalue = "Yay! So excited";
    } else {
      botvalue =
          "Go back to mood and write it off. I promise it will be our lil secret.";
    }
  } else {
    throw Exception('Failed to load post');
  }
}
