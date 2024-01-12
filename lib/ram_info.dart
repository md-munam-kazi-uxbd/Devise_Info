// import 'dart:io';
// import 'package:flutter/material.dart';
// //import 'package:system_info/system_info.dart';
// //wmic memory-chip list full
//
// class RAMInfo extends StatefulWidget {
//   const RAMInfo({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _RAMInfoState createState() => _RAMInfoState();
// }
//
// class _RAMInfoState extends State<RAMInfo> {
//   late List<String> ramData;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchRAMInfo();
//   }
//
//   Future<void> fetchRAMInfo() async {
//     var ramSize = await _getRAMInfo('capacity');
//     // var ramUsed = await _getRAMInfo('freePhysicalMemory');
//     // var ramFree = await _getRAMInfo('totalVisibleMemorySize');
//     // var ramAvailable = await _getRAMInfo('totalVirtualMemorySize');
//     var ramDeviceLocator = await _getRAMInfo('deviceLocator');
//     var ramFormFactor = await _getRAMInfo('formFactor');
//     var ramManufacturer = await _getRAMInfo('manufacturer');
//     var ramPartNumber = await _getRAMInfo('partNumber');
//     var ramSerialNumber = await _getRAMInfo('SerialNumber');
//     var ramSpeed = await _getRAMInfo('Speed');
//
//
//     setState(() {
//       ramData = [
//         'RAM Size: ${(int.parse(ramSize) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB',
//         // 'RAM Used: $ramUsed',
//         // 'RAM Free: $ramFree',
//         // 'RAM Available: $ramAvailable',
//         'RAM Device Locator: $ramDeviceLocator',
//         'RAM Form Factor: $ramFormFactor',
//         'RAM Manufacturer: $ramManufacturer',
//         'RAM Part Number: $ramPartNumber',
//         'RAM Serial Number: $ramSerialNumber',
//         'RAM Speed: $ramSpeed',
//
//       ];
//     });
//   }
//
//   Future<String> _getRAMInfo(String property) async {
//     var ramInfo = await Process.run('wmic', ['memorychip', 'get', property]);
//     return (ramInfo.exitCode == 0)
//         ? _parseRAMInfoWindows(ramInfo.stdout.toString())
//         : 'Failed to retrieve RAM $property';
//   }
//
//   String _parseRAMInfoWindows(String ramInfo) {
//     var lines = ramInfo.split('\n');
//    // print( "Mmmm = " + ramInfo);
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
//       margin: const EdgeInsets.all(10),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text(
//               'RAM Information:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (String info in ramData) ...[
//                   Text(
//                     info,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 5),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:system_info/system_info.dart';
//wmic memorychip list full

class RAMInfo extends StatefulWidget {
  @override
  _RAMInfoState createState() => _RAMInfoState();
}

class _RAMInfoState extends State<RAMInfo> {
  String ramData = "";
  String ramDataString = "";

  @override
  void initState() {
    super.initState();
    fetchRAMInfo();
  }

  Future<void> fetchRAMInfo() async {
    var capacity = await _getRAMInfo('Capacity');
    var deviceLocator = await _getRAMInfo('DeviceLocator');
    var manufacturer = await _getRAMInfo('Manufacturer');
    var partNumber = await _getRAMInfo('PartNumber');
    var ramFormFactor = await _getRAMInfo('formFactor');
    var serialNumber = await _getRAMInfo('SerialNumber');
    var speed = await _getRAMInfo('Speed');
    var tag = await _getRAMInfo('Tag');

    var ramDeviceCountString = manufacturer.split("_:_");
    var ramCount = ramDeviceCountString.length;

    var splitedCapacity = capacity.split("_:_");
    var splitedDeviceLocator = deviceLocator.split("_:_");
    var splitedManufacturer = manufacturer.split("_:_");
    var splitedPartNumber = partNumber.split("_:_");
    var splitedSerialNumber = serialNumber.split("_:_");
    var splitedSpeed = speed.split("_:_");
    var splitedTag = tag.split("_:_");

    //print(splitedManufacturer[0]);

    setState(() {
      if(ramCount == 1){
        ramData = '(1)\n' +
            //         'RAM Size: ${(int.parse(ramSize) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB',
            'RAM Capacity: ${(int.parse(splitedCapacity[0]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[0]}\n' +
            'RAM Form Factor: ${ramFormFactor[0]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[0]}\n' +
            'RAM Part Number: ${splitedPartNumber[0]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[0]}\n' +
            'RAM Speed: ${splitedSpeed[0]}\n' +
            'RAM Tag: ${splitedTag[0]}\n'  +
            'RAM Found ${ramCount} RAM/RAMs';
      }
      if(ramCount == 2){
        ramData = '(1)\n' +
            'RAM Capacity: ${(int.parse(splitedCapacity[0]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[0]}\n' +
            'RAM Form Factor: ${ramFormFactor[0]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[0]}\n' +
            'RAM Part Number: ${splitedPartNumber[0]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[0]}\n' +
            'RAM Speed: ${splitedSpeed[0]}\n' +
            'RAM Tag: ${splitedTag[0]}\n' +
            'RAM Found ${ramCount} RAM/RAMs\n\n(2)\n' +

            'RAM Capacity: ${(int.parse(splitedCapacity[1]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[1]}\n' +
            'RAM Form Factor: ${ramFormFactor[1]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[1]}\n' +
            'RAM Part Number: ${splitedPartNumber[1]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[1]}\n' +
            'RAM Speed: ${splitedSpeed[1]}\n' +
            'RAM Tag: ${splitedTag[1]}\n' +
            'RAM Found ${ramCount} RAM/RAMs';
      }
      if(ramCount == 3){
        ramData = '(1)\n' +
            'RAM Capacity: ${(int.parse(splitedCapacity[0]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[0]}\n' +
            'RAM Form Factor: ${ramFormFactor[0]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[0]}\n' +
            'RAM Part Number: ${splitedPartNumber[0]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[0]}\n' +
            'RAM Speed: ${splitedSpeed[0]}\n' +
            'RAM Tag: ${splitedTag[0]}\n' +
            'RAM Found ${ramCount} RAM/RAMs\n\n(2)\n' +

            'RAM Capacity: ${(int.parse(splitedCapacity[1]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[1]}\n' +
            'RAM Form Factor: ${ramFormFactor[1]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[1]}\n' +
            'RAM Part Number: ${splitedPartNumber[1]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[1]}\n' +
            'RAM Speed: ${splitedSpeed[1]}\n' +
            'RAM Tag: ${splitedTag[1]}\n' +
            'RAM Found ${ramCount} RAM/RAMs\n\n(3)\n' +

            'RAM Capacity: ${(int.parse(splitedCapacity[2]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[2]}\n' +
            'RAM Form Factor: ${ramFormFactor[2]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[2]}\n' +
            'RAM Part Number: ${splitedPartNumber[2]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[2]}\n' +
            'RAM Speed: ${splitedSpeed[2]}\n' +
            'RAM Tag: ${splitedTag[2]}\n' +
            'RAM Found ${ramCount} RAM/RAMs';
      }
      if(ramCount == 4){
        ramData = '(1)\n' +
            'RAM Capacity: ${(int.parse(splitedCapacity[0]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[0]}\n' +
            'RAM Form Factor: ${ramFormFactor[0]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[0]}\n' +
            'RAM Part Number: ${splitedPartNumber[0]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[0]}\n' +
            'RAM Speed: ${splitedSpeed[0]}\n' +
            'RAM Tag: ${splitedTag[0]}\n' +
            'RAM Found ${ramCount} RAM/RAMs\n\n(2)\n' +

            'RAM Capacity: ${(int.parse(splitedCapacity[1]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[1]}\n' +
            'RAM Form Factor: ${ramFormFactor[1]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[1]}\n' +
            'RAM Part Number: ${splitedPartNumber[1]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[1]}\n' +
            'RAM Speed: ${splitedSpeed[1]}\n' +
            'RAM Tag: ${splitedTag[1]}\n' +
            'RAM Found ${ramCount} RAM/RAMs\n\n(3)\n' +

            'RAM Capacity: ${(int.parse(splitedCapacity[2]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[2]}\n' +
            'RAM Form Factor: ${ramFormFactor[2]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[2]}\n' +
            'RAM Part Number: ${splitedPartNumber[2]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[2]}\n' +
            'RAM Speed: ${splitedSpeed[2]}\n' +
            'RAM Tag: ${splitedTag[2]}\n' +
            'RAM Found ${ramCount} RAM/RAMs\n\n(4)\n' +

            'RAM Capacity: ${(int.parse(splitedCapacity[3]) / (1024 * 1024* 1024)).toStringAsFixed(2)} GB\n' +
            'RAM Device Location: ${splitedDeviceLocator[3]}\n' +
            'RAM Form Factor: ${ramFormFactor[3]}\n' +
            'RAM Manufacturer: ${splitedManufacturer[3]}\n' +
            'RAM Part Number: ${splitedPartNumber[3]}\n' +
            'RAM Serial Number: ${splitedSerialNumber[3]}\n' +
            'RAM Speed: ${splitedSpeed[3]}\n' +
            'RAM Tag: ${splitedTag[3]}\n' +
            'RAM Found ${ramCount} RAM/RAMs';
      }
    });
  }

  Future<String> _getRAMInfo(String property) async {
    var ramInfo = await Process.run('wmic', ['memorychip', 'get', property]);
    return (ramInfo.exitCode == 0)
        ? _parseRAMInfoWindows(ramInfo.stdout.toString())
        : 'Failed to retrieve RAM $property';
  }

  String _parseRAMInfoWindows(String ramInfo) {
    var lines = ramInfo.split('\n');
    var l = '${lines.length}';

    if (lines.length == 4) {
      var value = lines[1].trim();
      return value;
    }
    if (lines.length == 5) {
      var value = lines[1].trim() + "_:_" + lines[2].trim();
      return value;
    }
    if (lines.length == 6) {
      var value =
          lines[1].trim() + "_:_" + lines[2].trim() + "_:_" + lines[3].trim();
      return value;
    }
    if (lines.length == 7) {
      var value = lines[1].trim() +
          "_:_" +
          lines[2].trim() +
          "_:_" +
          lines[3].trim() +
          "_:_" +
          lines[4].trim();
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
              'RAM Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (ramData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //for (String info in ramData) ...[
                  Text(
                    //info,
                    ramData,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  //],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
