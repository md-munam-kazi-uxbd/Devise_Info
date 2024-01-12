import 'dart:io';
import 'package:flutter/material.dart';
//wmic path win32_videocontroller get /Format:list

class GraphicsInfo extends StatefulWidget {
  @override
  _GraphicsInfoState createState() => _GraphicsInfoState();
}

class _GraphicsInfoState extends State<GraphicsInfo> {
  late List<String> graphicsData;

  @override
  void initState() {
    super.initState();
    graphicsData = [];
    fetchGraphicsInfo();
  }

  Future<void> fetchGraphicsInfo() async {
    var gpuName = await _getGraphicsInfo('name');
    var gpuAdapterCompatibility = await _getGraphicsInfo('AdapterCompatibility');
    var gpuCaption = await _getGraphicsInfo('caption');
    var gpuAdapterRAM = await _getGraphicsInfo('adapterRAM');
    var gpuDriverVersion = await _getGraphicsInfo('driverVersion');
    var gpuCurrentBitsPerPixel = await _getGraphicsInfo('CurrentBitsPerPixel');
    var gpuCurrentHorizontalResolution = await _getGraphicsInfo('CurrentHorizontalResolution');
    var gpuCurrentNumberOfColors = await _getGraphicsInfo('CurrentNumberOfColors');
    var gpuPNPDeviceID = await _getGraphicsInfo('PNPDeviceID');
    var gpuVideoModeDescription = await _getGraphicsInfo('VideoModeDescription');
    var gpuVideoProcessor = await _getGraphicsInfo('VideoProcessor');

    setState(() {
      graphicsData = [
        'GPU Name: $gpuName',
        'GPU Adapter Compatibility: $gpuAdapterCompatibility',
        'GPU Caption: $gpuCaption',
        'GPU Adapter RAM: ${(int.parse(gpuAdapterRAM) / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB',
        'GPU Driver Version: $gpuDriverVersion',
        'GPU Current Bits Per Pixel: $gpuCurrentBitsPerPixel',
        'GPU Current Horizontal Resolution: $gpuCurrentHorizontalResolution',
        'GPU Current Number Of Colors: $gpuCurrentNumberOfColors',
        'GPU PNP Device ID: $gpuPNPDeviceID',
        'GPU Video Mode Description: $gpuVideoModeDescription',
        'GPU Video Processor: $gpuVideoProcessor',
      ];
    });
  }

  Future<String> _getGraphicsInfo(String property) async {
    var gpuInfo = await Process.run('wmic', ['path', 'win32_videocontroller', 'get', property]);
    return (gpuInfo.exitCode == 0)
        ? _parseGraphicsInfoWindows(gpuInfo.stdout.toString())
        : 'Failed to retrieve GPU $property';
  }
//wmic path win32_videocontroller get
  String _parseGraphicsInfoWindows(String gpuInfo) {
    var lines = gpuInfo.split('\n');
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
              'Graphics Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (graphicsData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in graphicsData) ...[
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
            //   onPressed: fetchGraphicsInfo,
            //   child: Text('Fetch Graphics Info'),
            // ),
          ],
        ),
      ),
    );
  }
}
