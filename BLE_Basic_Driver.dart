import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';

import 'bleCmdCennter.dart';

class bleDeviceListWidget extends StatefulWidget{

  const bleDeviceListWidget({Key? key}) : super(key: key);

  _bleDeviceListWidgetState createState() => _bleDeviceListWidgetState();

}

class _bleDeviceListWidgetState extends State<bleDeviceListWidget>{

  final FlutterBlue flutterBlue = FlutterBlue.instance;

  List<ScanResult> bledevices = [];

  void scanDevices() async {
    flutterBlue
        .scan(allowDuplicates: false, scanMode: ScanMode.balanced)
        .listen(
            (scannedDevice) async {
          setState(() {
            bledevices.add(scannedDevice);
          });

          flutterBlue.stopScan();

        });
  }


  void connectDevice(BluetoothDevice device) async {

    await device.connect();

  }

  @override
  void initState(){
    scanDevices();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> deviceList = List.generate(bledevices.length, (index) =>
    deviceListWidget(bledevices[index]));

    return ListView(
      children: deviceList,
    );
  }

  Widget deviceListWidget(ScanResult dev){

    return Material(
      child: ListTile(
        isThreeLine: true,
        title: Text(dev.device.name),
        subtitle: Text("${dev.device.type.toString()} & ${dev.device.id.id}"),
        trailing: const Icon(Icons.bluetooth_connected_sharp), onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>bleCmdCenter(dev.device)));
      },)
    );

  }
}