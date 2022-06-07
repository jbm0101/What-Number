import 'package:flutter/material.dart';
import 'package:qr/Screens/barcode_scanner_controller.dart';
import 'Screens/History.dart';
import 'Screens/ScanQR.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QR Scanner',
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        theme: ThemeData(
          // Use the old theme but apply the following three changes
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Open Sans',
                bodyColor: Colors.white,
                displayColor: Colors.white)),
        routes: {
          '/home': (context) => const BarcodeScannerWithController(),
          '/history': (context) => const History(),
          '/scanned': (context) => const ScanQR()
        });
  }
}

//   return MaterialApp(
//     theme: ThemeData(
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       hoverColor: Colors.transparent,
//     ),
//     title: 'QR Code Scanner',
//     home: const MyHomePage(title: 'QR Code Scanner'),
//   );
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int pageIndex = 0;
//   final pages = [const ScanQR(), const History()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       bottomNavigationBar: BottomNavigationBar(items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.qr_code_scanner),
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.history))
//       ]),
//       body: Container(),
//     );
//   }
// }

// Widget build(BuildContext context) {
  //   return Scaffold(
  //     bottomNavigationBar: Container(
  //       height: 60,
  //       decoration: BoxDecoration(
  //           color: Theme.of(context).primaryColor,
  //           borderRadius: const BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           )),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.qr_code_scanner_outlined,
  //                 color: Colors.white,
  //                 size: 35,
  //           )),
  //           IconButton(
  //           onPressed: () {},
  //           icon: const Icon(
  //             Icons.history,
  //             color: Colors.white,
  //             size: 35,
  //           ))
  //         ],
  //       ),
  //     ),
  //   );
  // }