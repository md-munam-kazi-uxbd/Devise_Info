// import 'dart:io';
// import 'package:flutter/material.dart';
//
// class BatteryInfo extends StatefulWidget {
//   @override
//   _BatteryInfoState createState() => _BatteryInfoState();
// }
//
// class _BatteryInfoState extends State<BatteryInfo> {
//   late List<String> batteryData;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBatteryInfo();
//   }
//
//   Future<void> fetchBatteryInfo() async {
//     var batteryName = await _getBatteryInfo('Name');
//     var batteryDeviceID = await _getBatteryInfo('DeviceID');
//     var batteryStatus = await _getBatteryInfo('Status');
//     var batteryDesignVoltage = await _getBatteryInfo('DesignVoltage');
//     var batteryCapacity = await _getBatteryInfo('EstimatedChargeRemaining');
//     var batteryEstimatedRunTime = await _getBatteryInfo('EstimatedRunTime');
//     var batteryBatteryStatus = await _getBatteryInfo('BatteryStatus');
//
//     setState(() {
//       batteryData = [
//         'Battery Name: $batteryName',
//         'Battery Device ID: $batteryDeviceID',
//         'Battery Status: $batteryStatus',
//         'Battery Design Voltage: $batteryDesignVoltage',
//         'Battery Capacity: $batteryCapacity%',
//         'Battery Estimated Run Time: $batteryEstimatedRunTime s',
//         'Battery BatteryStatus: $batteryBatteryStatus',
//         //'Battery Capacity: ${(int.parse(batteryCapacity) / 100)}%', // Convert to percentage
//       ];
//     });
//   }
//
//   Future<String> _getBatteryInfo(String property) async {
//     var batteryInfo = await Process.run('wmic', ['path', 'Win32_Battery', 'get', property]);
//     return (batteryInfo.exitCode == 0)
//         ? _parseBatteryInfoWindows(batteryInfo.stdout.toString())
//         : 'Failed to retrieve Battery $property';
//   }
//
//   String _parseBatteryInfoWindows(String batteryInfo) {
//     var lines = batteryInfo.split('\n');
//     if (lines.length > 1) {
//       var value = lines[1].trim();
//       return value;
//     }
//     return '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Battery Information:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             if (batteryData != null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   for (String info in batteryData) ...[
//                     Text(
//                       info,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     SizedBox(height: 5),
//                   ],
//                 ],
//               ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';

class BatteryInfo extends StatefulWidget {
  @override
  _BatteryInfoState createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {
  late List<String> batteryData;

  @override
  void initState() {
    super.initState();
    batteryData = [];
    fetchBatteryInfo();
  }

  Future<void> fetchBatteryInfo() async {
    var batteryName = await _getBatteryInfo('Name');
    var batteryDeviceID = await _getBatteryInfo('DeviceID');
    var batteryStatus = await _getBatteryInfo('Status');
    var batteryDesignVoltage = await _getBatteryInfo('DesignVoltage');
    var batteryCapacity = await _getBatteryInfo('EstimatedChargeRemaining');
    var batteryEstimatedRunTime = await _getBatteryInfo('EstimatedRunTime');
    var batteryBatteryStatus = await _getBatteryInfo('BatteryStatus');

    setState(() {
      batteryData = [
        'Battery Name: $batteryName',
        'Battery Device ID: $batteryDeviceID',
        'Battery Status: $batteryStatus',
        'Battery Design Voltage: $batteryDesignVoltage',
        'Battery Capacity: $batteryCapacity%',
        'Battery Estimated Run Time: $batteryEstimatedRunTime',
        //'Battery Estimated Run Time: ${_formatBatteryRunTime(batteryEstimatedRunTime)}',
        'Battery BatteryStatus: ${_getBatteryStatus(batteryBatteryStatus)}',
      ];
    });
  }

  String _getBatteryStatus(String status) {
    if (status == '1') {
      return 'DC';
    } else if (status == '2') {
      return 'AC';
    }
    return 'Unknown';
  }

  // String _formatBatteryRunTime(String secondsString) {
  //   print("Time = " + secondsString);
  //   int seconds = int.tryParse(secondsString) ?? 0;
  //   if (seconds <= 0) {
  //     return 'N/A';
  //   }
  //
  //   Duration duration = Duration(seconds: seconds);
  //
  //   int hours = duration.inHours;
  //   int minutes = duration.inMinutes.remainder(60);
  //   int secondsRemainder = duration.inSeconds.remainder(60);
  //
  //   String formattedTime =
  //       '$hours:${minutes.toString().padLeft(2, '0')}:${secondsRemainder.toString().padLeft(2, '0')}';
  //   return formattedTime;
  // }


  Future<String> _getBatteryInfo(String property) async {
    var batteryInfo = await Process.run('wmic', ['path', 'Win32_Battery', 'get', property]);
    return (batteryInfo.exitCode == 0)
        ? _parseBatteryInfoWindows(batteryInfo.stdout.toString())
        : 'Failed to retrieve Battery $property';
  }

  String _parseBatteryInfoWindows(String batteryInfo) {
    var lines = batteryInfo.split('\n');
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
              'Battery Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (batteryData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String info in batteryData) ...[
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

