import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

String lastWords = '';
String botResponse = '';

class Voice extends StatefulWidget {
  @override
  _VoiceState createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  List<Widget> responseList = [];

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('wit.ai Voice Bot',
            style: TextStyle(
              fontFamily: 'Gotham',
              color: Colors.black,
            )),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(children: [
        Container(
          color: HexColor('#E5D6FF'),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: !_hasSpeech || speech.isListening
                        ? null
                        : startListening,
                    child: Text('Start'),
                  ),
                  TextButton(
                    onPressed: speech.isListening ? stopListening : null,
                    child: Text('Stop'),
                  ),
                  TextButton(
                    onPressed: speech.isListening ? cancelListening : null,
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      fetchPost();
                      setState(() {
                        responseList.add(
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
                                      "$botResponse",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                    child: Text('Done'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButton(
                    onChanged: (selectedVal) => _switchLang(selectedVal),
                    value: _currentLocaleId,
                    items: _localeNames
                        .map(
                          (localeName) => DropdownMenuItem(
                            value: localeName.localeId,
                            child: Text(localeName.name),
                          ),
                        )
                        .toList(),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          child: Padding(
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
                        padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                        child: Text(
                          lastWords,
                          style: TextStyle(
                              fontFamily: 'Gotham', color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ...responseList,
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          color: HexColor('#E5D6FF'),
          child: Center(
            child: speech.isListening
                ? Text(
                    "I'm listening...",
                    style: TextStyle(fontFamily: 'Gotham'),
                  )
                : Text(
                    'Not listening',
                    style: TextStyle(fontFamily: 'Gotham'),
                  ),
          ),
        ),
      ]),
    );
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener $resultListened');
    setState(() {
      //lastWords = '${result.recognizedWords} - ${result.finalResult}';
      lastWords = '${result.recognizedWords}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}

Future<String> fetchPost() async {
  final response = await http.get(
      Uri.parse('https://api.wit.ai/message?v=20210507&q=$lastWords'),
      headers: {'Authorization': 'Bearer TXGBHYKKFQ7BU3BMKM7IAVYO5IGGN5DE'});

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    var witop = json.decode(response.body);
    if (witop['traits']['wit\$sentiment'][0]['value'] == "negative") {
      botResponse =
          "So sorry to hear that. Did you try writing your mood down?";
    } else if (witop['traits']['wit\$sentiment'][0]['value'] == "positive") {
      botResponse = "Yay! So excited";
    } else {
      botResponse =
          "Go back to mood and write it off. I promise it will be our lil secret.";
    }
  } else {
    throw Exception('Failed to load post');
  }
}
