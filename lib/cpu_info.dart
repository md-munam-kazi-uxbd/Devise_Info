import 'dart:io';
import 'package:flutter/material.dart';
import 'package:system_info/system_info.dart';

class CPUInfo extends StatefulWidget {
  @override
  _CPUInfoState createState() => _CPUInfoState();
}

class _CPUInfoState extends State<CPUInfo> {
  late List<String> cpuData;

  @override
  void initState() {
    super.initState();
    cpuData = [];
    fetchCPUInfo(); // Fetch CPU info on widget initialization
  }

  Future<void> fetchCPUInfo() async {
    var cpuName = await _getCPUName();
    var kernelArch = SysInfo.kernelArchitecture;
    var addressWidth = await _getCPUInfo('addressWidth');
    var caption = await _getCPUInfo('caption');
    var availability = await _getCPUInfo('availability');
    var currentClockSpeed = await _getCPUInfo('currentClockSpeed');
    var currentVoltage = await _getCPUInfo('currentVoltage');
    var dataWidth = await _getCPUInfo('dataWidth');
    var description = await _getCPUInfo('description');
    var deviceID = await _getCPUInfo('deviceID');
    var extClock = await _getCPUInfo('extClock');
    var manufacturer = await _getCPUInfo('manufacturer');
    var maxClockSpeed = await _getCPUInfo('maxClockSpeed');
    var processorId = await _getCPUInfo('processorId');
    var processorType = await _getCPUInfo('processorType');
    var systemCreationClassName = await _getCPUInfo('systemCreationClassName');
    var systemName = await _getCPUInfo('systemName');
    var socketDesignation = await _getCPUInfo('socketDesignation');

    setState(() {
      cpuData = [
        'Name (Windows): $cpuName',
        'Architecture (Windows): $kernelArch',
        'Address Width (Windows): $addressWidth',
        'Availability (Windows): $availability',
        'Caption (Windows): $caption',
        'Current ClockSpeed (Windows): $currentClockSpeed',
        'Max Clock Speed (Windows): $maxClockSpeed',
        'Current Voltage (Windows): $currentVoltage',
        'Data Width (Windows): $dataWidth',
        'Description (Windows): $description',
        'Device ID (Windows): $deviceID',
        'ExtClock (Windows): $extClock',
        'Manufacturer (Windows): $manufacturer',
        'Processor ID (Windows): $processorId',
        'Processor Type (Windows): $processorType',
        'System Creation Class Name (Windows): $systemCreationClassName',
        'System Name (Windows): $systemName',
        'Socket Designation (Windows): $socketDesignation',
      ];
    });
  }

  Future<String> _getCPUName() async {
    var cpuInfo = await Process.run('wmic', ['cpu', 'get', 'name']);
    return (cpuInfo.exitCode == 0)
        ? _parseCPUFrequencyWindows(cpuInfo.stdout.toString())
        : 'Failed to retrieve CPU Name';
  }

  Future<String> _getCPUInfo(String property) async {
    var cpuInfo = await Process.run('wmic', ['cpu', 'get', property]);
    return (cpuInfo.exitCode == 0)
        ? _parseCPUFrequencyWindows(cpuInfo.stdout.toString())
        : 'Failed to retrieve CPU $property';
  }

  String _parseCPUFrequencyWindows(String cpuInfo) {
    var lines = cpuInfo.split('\n');
    if (lines.length > 1) {
      var frequency = lines[1].trim();
      return frequency;
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
              'CPU Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (String info in cpuData) ...[
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
            //   onPressed: fetchCPUInfo,
            //   child: Text('Fetch CPU Info'),
            // ),
          ],
        ),
      ),
    );
  }
}

