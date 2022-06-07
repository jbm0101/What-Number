// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:qr/assets/MyCardWidget.dart';

import '../navigation/navdrawer.dart';

class ScanQR extends StatelessWidget {
  static const String routeName = '/scanned';

  const ScanQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final arg = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return Scaffold(
        appBar: AppBar(title: const Text("Scan QR")),
        drawer: const NavigationDrawer(),
        body: Center(
          child: Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                children: [
                  
                  MyCardWidget(text: arg['data']),
                  
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black87, onPrimary: Colors.white),
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName("/home"));
                      },
                      child: const Text(
                        "Scan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ))
                ],
              ))),
        ));
  }
}
