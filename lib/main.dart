import 'package:flutter/material.dart';
import 'cpu_info.dart';
import 'mothetrboard_info.dart';
import 'os_info.dart';
import 'ram_info.dart';
import 'graphics_info.dart';
import 'network_info.dart';
import 'storage_info.dart';
import 'battery_info.dart';
import 'bios_info.dart';
import 'audio_info.dart';
import 'dart:io';
import 'linux_cpu_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'System Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SystemInfoScreen(),
    );
  }
}

class SystemInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget systemInfo;

    // Check the platform and set the appropriate widgets
    if (Platform.isWindows) {
      systemInfo = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CPUInfo(),
          OSInfo(),
          RAMInfo(),
          MotherboardInfo(),
          BiosInfo(),
          GraphicsInfo(),
          StorageInfo(),
          BatteryInfo(),
          NetworkInfo(),
          AudioInfo(),
        ],
      );
    } else if (Platform.isLinux) {
      systemInfo = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LinuxCPUInfo(),
          OSInfo(),
          RAMInfo(),
          MotherboardInfo(),
          BiosInfo(),
          AudioInfo(),
        ],
      );
    } else if (Platform.isAndroid) {
      systemInfo = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          OSInfo(),
          RAMInfo(),
          MotherboardInfo(),
          BiosInfo(),
          GraphicsInfo(),
          StorageInfo(),
          BatteryInfo(),
          NetworkInfo(),
          AudioInfo(),
        ],
      );
    } else if (Platform.isIOS) {
      systemInfo = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CPUInfo(),
          OSInfo(),
          RAMInfo(),
          MotherboardInfo(),
          BiosInfo(),
          GraphicsInfo(),
          StorageInfo(),
          BatteryInfo(),
          NetworkInfo(),
          AudioInfo(),
        ],
      );
    } else if (Platform.isMacOS) {
      systemInfo = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CPUInfo(),
          OSInfo(),
          RAMInfo(),
          MotherboardInfo(),
          BiosInfo(),
          GraphicsInfo(),
          StorageInfo(),
          BatteryInfo(),
          NetworkInfo(),
          AudioInfo(),
        ],
      );
    } else {
      // If the platform is not recognized, you can handle it here
      systemInfo = Center(child: Text('Unsupported platform'));
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: systemInfo,
      ),
    );
  }
}
