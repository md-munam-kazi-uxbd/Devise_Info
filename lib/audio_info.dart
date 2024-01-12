import 'dart:io';
import 'package:flutter/material.dart';

class AudioInfo extends StatefulWidget {
  @override
  _AudioInfoState createState() => _AudioInfoState();
}

class _AudioInfoState extends State<AudioInfo> {
  late List<String> audioData;

  @override
  void initState() {
    super.initState();
    audioData = [];
    fetchAudioInfo();
  }

  Future<void> fetchAudioInfo() async {
    var audioName = await _getAudioInfo('Name');
    var audioStatus = await _getAudioInfo('Status');
    var audioDeviceID = await _getAudioInfo('DeviceID');
    var audioManufacturer = await _getAudioInfo('Manufacturer');

    setState(() {
      audioData = [
        'Audio Name: $audioName',
        'Audio Status: $audioStatus',
        'Audio Device ID: $audioDeviceID',
        'Audio Manufacturer: $audioManufacturer',
      ];
    });
  }

  Future<String> _getAudioInfo(String property) async {
    var audioInfo = await Process.run('wmic', ['path', 'Win32_SoundDevice', 'get', property]);
    return (audioInfo.exitCode == 0)
        ? _parseAudioInfoWindows(audioInfo.stdout.toString())
        : 'Failed to retrieve Audio $property';
  }

  String _parseAudioInfoWindows(String audioInfo) {
    var lines = audioInfo.split('\n');
    if (lines.length > 1) {
      var value = lines[1].trim();
      return value;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Audio Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (audioData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in audioData) ...[
                    Text(
                      info,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                  ],
                ],
              ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
