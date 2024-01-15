import 'dart:io';
import 'package:flutter/material.dart';

class LinuxCPUInfo extends StatefulWidget {
  @override
  _LinuxCPUInfoState createState() => _LinuxCPUInfoState();
}

class _LinuxCPUInfoState extends State<LinuxCPUInfo> {
  late List<String> cpuData;

  @override
  void initState() {
    super.initState();
    cpuData = [];
    fetchCPUInfo(); // Fetch CPU info on widget initialization
  }

  Future<void> fetchCPUInfo() async {
    var cpuName = await _getCPUName();
    var architecture = await _getArchitecture();
    var cores = await _getCoreCount();
    var threads = await _getThreadCount();

    setState(() {
      cpuData = [
        'Name (Linux): $cpuName',
        'Architecture (Linux): $architecture',
        'Cores: $cores',
        'Threads: $threads',
      ];
    });
  }

  Future<String> _getCPUName() async {
    var cpuInfo = await Process.run('cat', ['/proc/cpuinfo']);
    return (cpuInfo.exitCode == 0)
        ? _parseCPUInfoLinux(cpuInfo.stdout.toString(), 'model name')
        : 'Failed to retrieve CPU Name';
  }

  Future<String> _getArchitecture() async {
    var cpuInfo = await Process.run('uname', ['-m']);
    return (cpuInfo.exitCode == 0)
        ? cpuInfo.stdout.toString().trim()
        : 'Failed to retrieve Architecture';
  }

  Future<String> _getCoreCount() async {
    var cpuInfo = await Process.run('nproc', ['--all']);
    return (cpuInfo.exitCode == 0)
        ? cpuInfo.stdout.toString().trim()
        : 'Failed to retrieve Core Count';
  }

  Future<String> _getThreadCount() async {
    var cpuInfo = await Process.run('lscpu', ['--parse=cpu', '--all']);
    return (cpuInfo.exitCode == 0)
        ? (cpuInfo.stdout.toString().trim().split('\n').length - 1).toString()
        : 'Failed to retrieve Thread Count';
  }

  String _parseCPUInfoLinux(String cpuInfo, String property) {
    var lines = cpuInfo.split('\n');
    for (var line in lines) {
      if (line.contains(property)) {
        return line.split(':').last.trim();
      }
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
            ElevatedButton(
              onPressed: fetchCPUInfo,
              child: Text('Fetch CPU Info'),
            ),
          ],
        ),
      ),
    );
  }
}
