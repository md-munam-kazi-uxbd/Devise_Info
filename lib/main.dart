// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }


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
//
// class SystemInfoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('System Information'),
//       // ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             CPUInfo(),
//             //const SizedBox(height: 0),
//             OSInfo(),
//             RAMInfo(),
//             MotherboardInfo(),
//             BiosInfo(),
//             GraphicsInfo(),
//             StorageInfo(),
//             BatteryInfo(),
//             NetworkInfo(),
//             AudioInfo(),
//           ],
//         ),
//       ),
//     );
//   }
// }




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
          CPUInfo(),
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



