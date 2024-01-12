import 'dart:io';
import 'package:flutter/material.dart';

class NetworkInfo extends StatefulWidget {
  @override
  _NetworkInfoState createState() => _NetworkInfoState();
}

class _NetworkInfoState extends State<NetworkInfo> {
  late List<String> networkData;

  @override
  void initState() {
    super.initState();
    networkData = [];
    fetchNetworkInfo();
  }

  Future<void> fetchNetworkInfo() async {
    var ipAddress = await _getNetworkInfo('IPAddress');
    var macAddress = await _getNetworkInfo('MACAddress');
    var defaultIPGateway = await _getNetworkInfo('DefaultIPGateway');
    var dnsServers = await _getNetworkInfo('DNSServerSearchOrder');
    var description = await _getNetworkInfo('Description');
    var settingID = await _getNetworkInfo('SettingID');
    var caption = await _getNetworkInfo('Caption');
    var dHCPLeaseExpires = await _getNetworkInfo('DHCPLeaseExpires');
    var dHCPLeaseObtained = await _getNetworkInfo('DHCPLeaseObtained');
    var dHCPServer = await _getNetworkInfo('DHCPServer');
    var dNSServerSearchOrder = await _getNetworkInfo('DNSServerSearchOrder');
    var speed = await _getNetworkInfo('Speed');

    setState(() {
      networkData = [
        'IP Address: $ipAddress',
        'MAC Address: $macAddress',
        'Default Gateway: $defaultIPGateway',
        'DNS Servers: ${dnsServers.join(", ")}',
        'Description: $description',
        'SettingID: $settingID',
        'Caption: $caption',
        'DHCPLeaseExpires: $dHCPLeaseExpires',
        'DHCPLeaseObtained: $dHCPLeaseObtained',
        'DHCPServer: $dHCPServer',
        'DNSServerSearchOrder: $dNSServerSearchOrder',
        'Speed: $speed Mbps',
      ];
    });
  }

  Future<List<String>> _getNetworkInfo(String property) async {
    var networkInfo = await Process.run('wmic', ['nicconfig', 'get', property]);
    if (networkInfo.exitCode == 0) {
      return _parseNetworkInfoWindows(networkInfo.stdout.toString());
    } else {
      return ['Failed to retrieve Network $property'];
    }
  }

  List<String> _parseNetworkInfoWindows(String networkInfo) {
    var lines = networkInfo.split('\n');
    lines.removeWhere((line) => line.isEmpty);
    if (lines.length > 1) {
      lines.removeAt(0); // Remove the title line
      return lines.map((line) => line.trim()).toList();
    }
    return [];
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
              'Network Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (networkData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in networkData) ...[
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
            //   onPressed: fetchNetworkInfo,
            //   child: Text('Fetch Network Info'),
            // ),
          ],
        ),
      ),
    );
  }
}
