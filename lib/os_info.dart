import 'dart:io';
import 'package:flutter/material.dart';
import 'package:system_info/system_info.dart';

class OSInfo extends StatefulWidget {
  @override
  _OSInfoState createState() => _OSInfoState();
}

class _OSInfoState extends State<OSInfo> {
  late List<String> osData;

  @override
  void initState() {
    super.initState();
    osData = [];
    fetchOSInfo();
  }

  Future<void> fetchOSInfo() async {
    var osName = await _getOSInfo('name');
    var osCaption = await _getOSInfo('caption');
    var osVersion = await _getOSInfo('version');
    var osArch = await _getOSInfo('osarchitecture');
    var osBuildNumber = await _getOSInfo('buildNumber');
    var osEncryptionLevel = await _getOSInfo('encryptionLevel');
    var osInstallDate = await _getOSInfo('installDate');
    var osLastBootUpTime = await _getOSInfo('lastBootUpTime');
    var osLocalDateTime = await _getOSInfo('localDateTime');
    var osTotalVisibleMemorySize = await _getOSInfo('totalVisibleMemorySize');
    var osFreePhysicalMemory = await _getOSInfo('freePhysicalMemory');
    var osTotalVirtualMemorySize = await _getOSInfo('totalVirtualMemorySize');
    var osFreeVirtualMemory = await _getOSInfo('freeVirtualMemory');
    var osManufacturer = await _getOSInfo('manufacturer');
    var osMaxNumberOfProcesses = await _getOSInfo('maxNumberOfProcesses');
    var osMaxProcessMemorySize = await _getOSInfo('maxProcessMemorySize');
    var osNumberOfProcesses = await _getOSInfo('numberOfProcesses');
    var osNumberOfUsers = await _getOSInfo('numberOfUsers');
    var osSerialNumber = await _getOSInfo('serialNumber');

    setState(() {
      osData = [
        // 'Total Physical Memory: ${(int.parse(osTotalVisibleMemorySize) / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB',
        // 'Free Physical Memory: ${(int.parse(osFreePhysicalMemory) / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB',
        'OS Name: $osName',
        'OS Caption: $osCaption',
        'OS Version: $osVersion',
        'OS Architecture: $osArch',
        'OS Build Number: $osBuildNumber',
        'OS Encryption Level: $osEncryptionLevel',
        'OS Install Date: $osInstallDate',
        'OS Last BootUp Time: $osLastBootUpTime',
        'OS Local Date Time: $osLocalDateTime',
        'OS Total Physical Memory: ${(int.parse(osTotalVisibleMemorySize) / (1024 * 1024)).toStringAsFixed(2)} GB',
        'OS Free Physical Memory: ${(int.parse(osFreePhysicalMemory) / (1024 * 1024)).toStringAsFixed(2)} GB',
        'OS Total Virtual Memory Size: ${(int.parse(osTotalVirtualMemorySize) / (1024 * 1024)).toStringAsFixed(2)} GB',
        'OS Free Virtual Memory: ${(int.parse(osFreeVirtualMemory) / (1024 * 1024)).toStringAsFixed(2)} GB',
        'OS Manufacturer: $osManufacturer',
        'OS Max Number Of Processes: $osMaxNumberOfProcesses',
        'OS Max Process Memory Size: ${(int.parse(osMaxProcessMemorySize) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB',
        'OS Number Of Processes: $osNumberOfProcesses',
        'OS Number Of Users: $osNumberOfUsers',
        'OS Serial Number: $osSerialNumber',
      ];
    });
  }

  Future<String> _getOSInfo(String property) async {
    var osInfo = await Process.run('wmic', ['os', 'get', property]);
    return (osInfo.exitCode == 0)
        ? _parseOSInfoWindows(osInfo.stdout.toString())
        : 'Failed to retrieve OS $property';
  }

  String _parseOSInfoWindows(String osInfo) {
    var lines = osInfo.split('\n');
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
              'OS Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (osData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in osData) ...[
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
            //   onPressed: fetchOSInfo,
            //   child: Text('Fetch OS Info'),
            // ),
          ],
        ),
      ),
    );
  }
}
