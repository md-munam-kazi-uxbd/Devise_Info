import 'dart:io';
import 'package:flutter/material.dart';
import 'package:system_info/system_info.dart';

class MotherboardInfo extends StatefulWidget {
  @override
  _MotherboardInfoState createState() => _MotherboardInfoState();
}

class _MotherboardInfoState extends State<MotherboardInfo> {
  late List<String> motherboardData;

  @override
  void initState() {
    super.initState();
    motherboardData = [];
    fetchMotherboardInfo();
  }

  Future<void> fetchMotherboardInfo() async {
    var mbName = await _getMotherboardInfo('name');
    var mbManufacturer = await _getMotherboardInfo('manufacturer');
    var mbProduct = await _getMotherboardInfo('product');
    var mbVersion = await _getMotherboardInfo('version');
    var mbSerialNumber = await _getMotherboardInfo('serialnumber');

    setState(() {
      motherboardData = [
        'Name: $mbName',
        'Manufacturer: $mbManufacturer',
        'Product: $mbProduct',
        'Version: $mbVersion',
        'Serial Number: $mbSerialNumber',
      ];
    });
  }

  Future<String> _getMotherboardInfo(String property) async {
    var mbInfo = await Process.run('wmic', ['baseboard', 'get', property]);
    return (mbInfo.exitCode == 0)
        ? _parseMotherboardInfoWindows(mbInfo.stdout.toString())
        : 'Failed to retrieve Motherboard $property';
  }

  String _parseMotherboardInfoWindows(String mbInfo) {
    var lines = mbInfo.split('\n');
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
              'Motherboard Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (motherboardData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in motherboardData) ...[
                    Text(
                      info,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                  ],
                ],
              ),
            SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: fetchMotherboardInfo,
            //   child: Text('Fetch Motherboard Info'),
            // ),
          ],
        ),
      ),
    );
  }
}
