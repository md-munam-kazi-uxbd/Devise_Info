import 'dart:io';
import 'package:flutter/material.dart';

class StorageInfo extends StatefulWidget {
  @override
  _StorageInfoState createState() => _StorageInfoState();
}

class _StorageInfoState extends State<StorageInfo> {
  late List<String> storageData;

  @override
  void initState() {
    super.initState();
    storageData = [];
    fetchStorageInfo();
  }
//wmic diskdrive list full
  Future<void> fetchStorageInfo() async {
    var storageBytesPerSector = await _getStorageInfo('BytesPerSector');
    var storageModel = await _getStorageInfo('Model');
    var storagePartitions = await _getStorageInfo('Partitions');
    var storagePNPDeviceID = await _getStorageInfo('PNPDeviceID');
    var storageSize = await _getStorageInfo('Size');
    var storageSystemName = await _getStorageInfo('SystemName');
    var storageTotalCylinders = await _getStorageInfo('TotalCylinders');
    var storageTotalHeads = await _getStorageInfo('TotalHeads');
    var storageTotalSectors = await _getStorageInfo('TotalSectors');
    var storageTotalTracks = await _getStorageInfo('TotalTracks');
    var storageTracksPerCylinder = await _getStorageInfo('TracksPerCylinder');


    setState(() {
      storageData = [
        'Storage Bytes Per Sector: $storageBytesPerSector',
        'Storage Size: ${(int.parse(storageSize) / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB',
        'Storage Model: $storageModel',
        'Storage Partitions: $storagePartitions',
        'Storage PNP Device ID: $storagePNPDeviceID',
        'Storage System Name: $storageSystemName',
        'Storage Total Cylinders: $storageTotalCylinders',
        'Storage Total Heads: $storageTotalHeads',
        'Storage Total Sectors: $storageTotalSectors',
        'Storage Total Tracks: $storageTotalTracks',
        'Storage Tracks Per Cylinder: $storageTracksPerCylinder',
        // 'Storage Caption: $storageCaption',
        // 'Storage Description: $storageDescription',
        // 'Storage File System: $storageFileSystem',
        // 'Storage Size: ${(int.parse(storageSize) / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB',
        // 'Storage Free Space: ${(int.parse(storageFreeSpace) / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB',
      ];
    });
  }

  Future<String> _getStorageInfo(String property) async {
    var storageInfo = await Process.run('wmic', ['diskdrive', 'get', property]);
    return (storageInfo.exitCode == 0)
        ? _parseStorageInfoWindows(storageInfo.stdout.toString())
        : 'Failed to retrieve Storage $property';
  }

  String _parseStorageInfoWindows(String storageInfo) {
    var lines = storageInfo.split('\n');
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
              'Storage Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (storageData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in storageData) ...[
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
            //   onPressed: fetchStorageInfo,
            //   child: Text('Fetch Storage Info'),
            // ),
          ],
        ),
      ),
    );
  }
}
