import 'package:flutter/material.dart';
import 'package:flutter_application_3/controllers/bluetooth_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BluetoothController>(
          init: BluetoothController(),
          builder: (constroller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        "Bluetooth App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => constroller.scanDevices(),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(350, 55),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          )),
                      child: const Text(
                        "Scan",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<ScanResult>>(
                      stream: constroller.scanResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(data.device.name),
                                    subtitle: Text(data.device.id.id),
                                    trailing: Text(data.rssi.toString()),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: Text("No devices found"),
                          );
                        }
                      })
                ],
              ),
            );
          }),
    );
  }
}
