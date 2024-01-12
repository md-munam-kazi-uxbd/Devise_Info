import 'dart:io';
import 'package:flutter/material.dart';

class BiosInfo extends StatefulWidget {
  @override
  _BiosInfoState createState() => _BiosInfoState();
}

class _BiosInfoState extends State<BiosInfo> {
  late List<String> biosData;

  @override
  void initState() {
    super.initState();
    biosData = [];
    fetchBiosInfo();
  }

  Future<void> fetchBiosInfo() async {
    var biosName = await _getBiosInfo('Name');
    var biosVersion = await _getBiosInfo('Version');
    var biosManufacturer = await _getBiosInfo('Manufacturer');
    var biosSMBIOSBIOSVersion = await _getBiosInfo('SMBIOSBIOSVersion');
    var biosSerialNumber = await _getBiosInfo('SerialNumber');
    var biosReleaseDate = await _getBiosInfo('ReleaseDate');
    var biosCurrentLanguage = await _getBiosInfo('CurrentLanguage');
    var biosListOfLanguages = await _getBiosInfo('ListOfLanguages');

    setState(() {
      biosData = [
        'BIOS Name: $biosName',
        'BIOS Version: $biosVersion',
        'BIOS Manufacturer: $biosManufacturer',
        'SMBIOS Version: $biosSMBIOSBIOSVersion',
        'Serial Number: $biosSerialNumber',
        'Release Date: $biosReleaseDate',
        'Current Language: $biosCurrentLanguage',
        'List Of Languages: $biosListOfLanguages',
      ];
    });
  }

  Future<String> _getBiosInfo(String property) async {
    var biosInfo = await Process.run('wmic', ['bios', 'get', property]);
    return (biosInfo.exitCode == 0)
        ? _parseBiosInfoWindows(biosInfo.stdout.toString())
        : 'Failed to retrieve BIOS $property';
  }

  String _parseBiosInfoWindows(String biosInfo) {
    var lines = biosInfo.split('\n');
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
              'BIOS Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (biosData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in biosData) ...[
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
