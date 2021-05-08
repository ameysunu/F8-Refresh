// import 'package:flutter/material.dart';

// class Voice extends StatefulWidget {
//   @override
//   _VoiceState createState() => _VoiceState();
// }

// class _VoiceState extends State<Voice> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Text(
//           'wit.ai Voice Bot',
//           style: TextStyle(fontFamily: 'Gotham', color: Colors.black),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.025,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text(
//               "Go on.!".toUpperCase(),
//               style: TextStyle(
//                   fontFamily: 'Gotham', color: Colors.black, fontSize: 20),
//             ),
//           ),
//           Spacer(),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 40,
//                 child: IconButton(
//                   icon: Icon(Icons.multitrack_audio, size: 30),
//                   // icon: recognizing
//                   //     ? Icon(
//                   //         Icons.stop,
//                   //         size: 30,
//                   //         color: HexColor('#A8617A'),
//                   //       )
//                   //     : Icon(
//                   //         Icons.multitrack_audio,
//                   //         size: 30,
//                   //         color: HexColor('#A8617A'),
//                   //       ),
//                   // onPressed:
//                   //     recognizing ? stopRecording : streamingRecognize,
//                   onPressed: null,
//                   color: Colors.purple,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// void main() => runApp(Voice());

// class Voice extends StatefulWidget {
//   @override
//   _VoiceState createState() => _VoiceState();
// }

// enum TtsState { playing, stopped, paused, continued }

// class _VoiceState extends State<Voice> {
//   FlutterTts flutterTts;
//   String language;
//   double volume = 0.5;
//   double pitch = 1.0;
//   double rate = 0.5;
//   bool isCurrentLanguageInstalled = false;

//   String _newVoiceText;

//   TtsState ttsState = TtsState.stopped;

//   get isPlaying => ttsState == TtsState.playing;
//   get isStopped => ttsState == TtsState.stopped;
//   get isPaused => ttsState == TtsState.paused;
//   get isContinued => ttsState == TtsState.continued;

//   bool get isIOS => !kIsWeb && Platform.isIOS;
//   bool get isAndroid => !kIsWeb && Platform.isAndroid;
//   bool get isWeb => kIsWeb;

//   @override
//   initState() {
//     super.initState();
//     initTts();
//   }

//   initTts() {
//     flutterTts = FlutterTts();

//     if (isAndroid) {
//       _getEngines();
//     }

//     flutterTts.setStartHandler(() {
//       setState(() {
//         print("Playing");
//         ttsState = TtsState.playing;
//       });
//     });

//     flutterTts.setCompletionHandler(() {
//       setState(() {
//         print("Complete");
//         ttsState = TtsState.stopped;
//       });
//     });

//     flutterTts.setCancelHandler(() {
//       setState(() {
//         print("Cancel");
//         ttsState = TtsState.stopped;
//       });
//     });

//     if (isWeb || isIOS) {
//       flutterTts.setPauseHandler(() {
//         setState(() {
//           print("Paused");
//           ttsState = TtsState.paused;
//         });
//       });

//       flutterTts.setContinueHandler(() {
//         setState(() {
//           print("Continued");
//           ttsState = TtsState.continued;
//         });
//       });
//     }

//     flutterTts.setErrorHandler((msg) {
//       setState(() {
//         print("error: $msg");
//         ttsState = TtsState.stopped;
//       });
//     });
//   }

//   Future<dynamic> _getLanguages() => flutterTts.getLanguages;

//   Future _getEngines() async {
//     var engines = await flutterTts.getEngines;
//     if (engines != null) {
//       for (dynamic engine in engines) {
//         print(engine);
//       }
//     }
//   }

//   Future _speak() async {
//     await flutterTts.setVolume(volume);
//     await flutterTts.setSpeechRate(rate);
//     await flutterTts.setPitch(pitch);

//     if (_newVoiceText != null) {
//       if (_newVoiceText.isNotEmpty) {
//         await flutterTts.awaitSpeakCompletion(true);
//         await flutterTts.speak(_newVoiceText);
//       }
//     }
//   }

//   Future _stop() async {
//     var result = await flutterTts.stop();
//     if (result == 1) setState(() => ttsState = TtsState.stopped);
//   }

//   Future _pause() async {
//     var result = await flutterTts.pause();
//     if (result == 1) setState(() => ttsState = TtsState.paused);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     flutterTts.stop();
//   }

//   List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
//       dynamic languages) {
//     var items = <DropdownMenuItem<String>>[];
//     for (dynamic type in languages) {
//       items.add(
//           DropdownMenuItem(value: type as String, child: Text(type as String)));
//     }
//     return items;
//   }

//   void changedLanguageDropDownItem(String selectedType) {
//     setState(() {
//       language = selectedType;
//       flutterTts.setLanguage(language);
//       if (isAndroid) {
//         flutterTts
//             .isLanguageInstalled(language)
//             .then((value) => isCurrentLanguageInstalled = (value as bool));
//       }
//     });
//   }

//   void _onChange(String text) {
//     setState(() {
//       _newVoiceText = text;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text('Flutter TTS'),
//             ),
//             body: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(children: [
//                   _inputSection(),
//                   _btnSection(),
//                   _futureBuilder(),
//                   _buildSliders()
//                 ]))));
//   }

//   Widget _futureBuilder() => FutureBuilder<dynamic>(
//       future: _getLanguages(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.hasData) {
//           return _languageDropDownSection(snapshot.data);
//         } else if (snapshot.hasError) {
//           return Text('Error loading languages...');
//         } else
//           return Text('Loading Languages...');
//       });

//   Widget _inputSection() => Container(
//       alignment: Alignment.topCenter,
//       padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
//       child: TextField(
//         onChanged: (String value) {
//           _onChange(value);
//         },
//       ));

//   Widget _btnSection() {
//     if (isAndroid) {
//       return Container(
//           padding: EdgeInsets.only(top: 50.0),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//             _buildButtonColumn(Colors.green, Colors.greenAccent,
//                 Icons.play_arrow, 'PLAY', _speak),
//             _buildButtonColumn(
//                 Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
//           ]));
//     } else {
//       return Container(
//           padding: EdgeInsets.only(top: 50.0),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//             _buildButtonColumn(Colors.green, Colors.greenAccent,
//                 Icons.play_arrow, 'PLAY', _speak),
//             _buildButtonColumn(
//                 Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
//             _buildButtonColumn(
//                 Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
//           ]));
//     }
//   }

//   Widget _languageDropDownSection(dynamic languages) => Container(
//       padding: EdgeInsets.only(top: 50.0),
//       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         DropdownButton(
//           value: language,
//           items: getLanguageDropDownMenuItems(languages),
//           onChanged: changedLanguageDropDownItem,
//         ),
//         Visibility(
//           visible: isAndroid,
//           child: Text("Is installed: $isCurrentLanguageInstalled"),
//         ),
//       ]));

//   Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
//       String label, Function func) {
//     return Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//               icon: Icon(icon),
//               color: color,
//               splashColor: splashColor,
//               onPressed: () => func()),
//           Container(
//               margin: const EdgeInsets.only(top: 8.0),
//               child: Text(label,
//                   style: TextStyle(
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w400,
//                       color: color)))
//         ]);
//   }

//   Widget _buildSliders() {
//     return Column(
//       children: [_volume(), _pitch(), _rate()],
//     );
//   }

//   Widget _volume() {
//     return Slider(
//         value: volume,
//         onChanged: (newVolume) {
//           setState(() => volume = newVolume);
//         },
//         min: 0.0,
//         max: 1.0,
//         divisions: 10,
//         label: "Volume: $volume");
//   }

//   Widget _pitch() {
//     return Slider(
//       value: pitch,
//       onChanged: (newPitch) {
//         setState(() => pitch = newPitch);
//       },
//       min: 0.5,
//       max: 2.0,
//       divisions: 15,
//       label: "Pitch: $pitch",
//       activeColor: Colors.red,
//     );
//   }

//   Widget _rate() {
//     return Slider(
//       value: rate,
//       onChanged: (newRate) {
//         setState(() => rate = newRate);
//       },
//       min: 0.0,
//       max: 1.0,
//       divisions: 10,
//       label: "Rate: $rate",
//       activeColor: Colors.green,
//     );
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Voice extends StatefulWidget {
  @override
  _VoiceState createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
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
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
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
