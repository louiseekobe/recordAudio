import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class Code1 extends StatefulWidget {
  const Code1({Key? key}) : super(key: key);

  @override
  State<Code1> createState() => _Code1State();
}

class _Code1State extends State<Code1> {
  //methodChannel est la methode pour communiquer avec du code natif
  //le lien ne se fait que si le nom est le même
  /*  static const batteryChannel = MethodChannel("battery");
  static const batteryStreamChannel = MethodChannel("batteryStream");
  static const batteryEventChannel = EventChannel("batteryEventChannel"); */
  String batteryLevel = "please waiting";
  String chargingLevel = "listen ...";
  /* late StreamSubscription _streamSubscription; */
  String pathToSaveAudio = '';
  AudioPlayer audioPlayer = AudioPlayer();
  late Record recorder;

  @override
  void initState() {
    super.initState();
    audioPlayer.onAudioPositionChanged.listen((event) {});
    recorder = Record();
    init();
  }

  Future _createPath() async {
    while (await Permission.microphone.isDenied &&
        await Permission.storage.isDenied) {
      await Permission.microphone.request();
      await Permission.storage.request();
    }
    final directory = await getApplicationDocumentsDirectory();
    pathToSaveAudio = directory.path + "/nativeCode/temp.wav";
  }

  Future init() async {
    await _createPath();
    Directory directory = Directory(path.dirname(pathToSaveAudio));
    if (!directory.existsSync()) {
      directory.createSync();
    }
  }

  @override
  void dispose() {
    /*  _streamSubscription.cancel(); */
    recorder.dispose();
    super.dispose();
  }

  /*  void onStreamBattery() {
    _streamSubscription =
        batteryEventChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        chargingLevel = event.toString();
      });
    });
  }
 */
  /* void onListenBattery() {
    batteryStreamChannel.setMethodCallHandler((call) async {
      if (call.method == "reportBatteryLevel") {
        final int bat = call.arguments;
        setState(() {
          batteryLevel = bat.toString();
        });
      }
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("native code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              batteryLevel,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text("get battery level")),
            const SizedBox(
              height: 15,
            ),
            Text(
              chargingLevel,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      recorder.start(
                          path: pathToSaveAudio, encoder: AudioEncoder.wav);
                    },
                    child: const Text(
                      "play",
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      recorder.stop();
                    },
                    child: const Text(
                      "stop",
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      audioPlayer.play(pathToSaveAudio, isLocal: true);
                    },
                    child: const Text(
                      "play",
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      audioPlayer.stop();
                    },
                    child: const Text(
                      "stop",
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  /* Future getBatteryLevel() async {
    final arguments = {'name': "Sarah louise"};
    final int newBatteryLevel =
        await batteryChannel.invokeMethod("getBattery", arguments);
    setState(() {
      batteryLevel = newBatteryLevel.toString();
    });
  } */
}
