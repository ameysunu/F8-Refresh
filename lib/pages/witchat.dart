import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final titleController = TextEditingController();

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

  List<Widget> chatList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('wit.ai Bot'),
      ),
      body:
          // child: FutureBuilder<Post>(
          //   future: post,
          //   builder: (context, abc) {
          //     if (abc.hasData) {
          //       return Text(abc.data.title);
          //     } else if (abc.hasError) {
          //       return Text("${abc.error}");
          //     }
          //     return CircularProgressIndicator();
          //   },
          // ),
          Column(
        children: [
          ...chatList,
          Spacer(),
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
                        child: Text(titleController.text),
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
  } else {
    throw Exception('Failed to load post');
  }
}
