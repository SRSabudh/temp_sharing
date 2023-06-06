import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

final String ServiceUUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
final String RXUUID = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E";
final String TXUUID = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E";

class bleCmdCenter extends StatefulWidget{
  BluetoothDevice bledevice;

  bleCmdCenter(this.bledevice, {Key? key}) : super(key: key);

  @override
  _bleCmdCenterState createState()=> _bleCmdCenterState();

}

class _bleCmdCenterState extends State<bleCmdCenter>{

  BluetoothCharacteristic ? RX_Text;
  String deviceValue = "";
  String messageSignal = "";

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    widget.bledevice.connect().then((value) => discoverServices());
    super.initState();
  }

  void discoverServices() async{
    print("fetching Services...");
    widget.bledevice.discoverServices()
        .then((value) => value.forEach((element){
          print("Service UUID = ${element.uuid.toString()}");
          if(element.uuid.toString().contains(ServiceUUID.toLowerCase())){
            print("Listing Characteristics...");
            element.characteristics.forEach((characteristic){
              print("${characteristic.uuid} \n ${characteristic.descriptors}");
              if(characteristic.properties.notify){

               characteristic.value.listen((value) {
                 setState(() {
                   deviceValue = utf8.decode(value);
                 });
               });
               characteristic.setNotifyValue(true);
              }
              if(characteristic.properties.write | characteristic.properties.writeWithoutResponse){
                RX_Text = characteristic;
              }
            });
          }
    }));
  }

  void sendData(String msg) async {
    await RX_Text?.write(utf8.encode(msg));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text("BLERMINAL",
            style: TextStyle(fontSize:20, color: Colors.white ),),
      ),
      body: Container(padding: const EdgeInsets.all(20), color: Colors.black54,
          child: Column(
              children: [
                Center(
                    child:Padding(padding: const EdgeInsets.fromLTRB(20,20,20,20),
                      child: Text("Read Value = $deviceValue",
                          style: const TextStyle(fontSize: 20, decoration: TextDecoration.none,
                              color: Colors.white)),)),

                TextField(style: const TextStyle(fontSize: 25, color: Colors.white), decoration: const InputDecoration(labelText: "Send Message",
                    labelStyle: TextStyle(color: Colors.lightGreen, fontSize: 20),
                    hintText: "Message",
                hintStyle: TextStyle(color: Colors.amber)),
                  onChanged: (text)=>{messageSignal = text},),
                ElevatedButton(onPressed: ()=>{sendData(messageSignal)}, child: const Text("Send Data",
                  style: TextStyle(fontSize: 20),))
              ]
          )),
    );
  }
}