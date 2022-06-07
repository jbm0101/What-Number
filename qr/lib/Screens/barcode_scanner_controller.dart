import 'package:flutter/material.dart';
import '../navigation/navdrawer.dart';
import '../navigation/pageRoutes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWithController extends StatefulWidget {
  static const String routeName = '/home';
  const BarcodeScannerWithController({Key? key}) : super(key: key);

  @override
  _BarcodeScannerWithControllerState createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState
    extends State<BarcodeScannerWithController>
    with SingleTickerProviderStateMixin {
  String? barcode;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    // formats: [BarcodeFormat.qrCode]
    // facing: CameraFacing.front,
  );
  bool isStarted = true;

  //  Widget build(BuildContext context) {
  //   return Scaffold(
  //     drawer: const NavigationDrawer(),
  //     body: Column(
  //       children: <Widget>[
  //         // area for qr code scanner
  //         Expanded(flex: 10, child: _buildQrView(context)),

  //         // area for camera controles
  //         Expanded(
  //           flex: 1,
  //           child: FittedBox(
  //             fit: BoxFit.contain,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     // for flash on & off
  //                     Container(
  //                       margin: const EdgeInsets.all(8),
  //                       child: IconButton(
  //                         icon: const Icon(Icons.flash_on),
  //                         onPressed: () async {
  //                           await controller?.toggleFlash();
  //                           setState(() {});
  //                         },
  //                       ),
  //                     ),

  //                     // to flip the camera
  //                     Container(
  //                       margin: const EdgeInsets.all(8),
  //                       child: IconButton(
  //                         icon: const Icon(Icons.flip_camera_android),
  //                         onPressed: () async {
  //                           await controller?.flipCamera();
  //                           setState(() {});
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner')),
      drawer: const NavigationDrawer(),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                allowDuplicates: false,
                controller: controller,
                fit: BoxFit.fill,
                onDetect: (barcode, args) {
                  String? lastScanned;
                  setState(() {
                    if (lastScanned != barcode.rawValue) {
                      this.barcode = barcode.rawValue;
                      lastScanned = "";
                    }
                    Navigator.pushNamed(context, "/scanned",
                        arguments: {'data': this.barcode});
                    // .then((_) => setState(() {
                    //       this.barcode = null;
                    //     }));
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 50,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.torchState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(
                                Icons.flash_off,
                                color: Colors.grey,
                              );
                            }
                            switch (state as TorchState) {
                              case TorchState.off:
                                return const Icon(
                                  Icons.flash_off,
                                  color: Colors.grey,
                                );
                              case TorchState.on:
                                return const Icon(
                                  Icons.flash_on,
                                  color: Colors.yellow,
                                );
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.toggleTorch(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: isStarted
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: () => setState(() {
                          isStarted ? controller.stop() : controller.start();
                          isStarted = !isStarted;
                        }),
                      ),
                      // Center(
                      //   child: SizedBox(
                      //     width: MediaQuery.of(context).size.width - 200,
                      //     height: 50,
                      //     child: FittedBox(
                      //       child: Text(
                      //         barcode ?? 'Scan something!',
                      //         overflow: TextOverflow.fade,
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .headline4!
                      //             .copyWith(color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder(
                          valueListenable: controller.cameraFacingState,
                          builder: (context, state, child) {
                            if (state == null) {
                              return const Icon(Icons.camera_front);
                            }
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: () => controller.switchCamera(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.image),
                        iconSize: 32.0,
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            if (await controller.analyzeImage(image.path)) {
                              if (!mounted) return;
                              Navigator.pushReplacementNamed(
                                  context, pageRoutes.home,
                                  arguments: {'data': barcode});

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Barcode found!'),
                                    backgroundColor: Colors.green),
                              );
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No barcode found!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({Key? key}) : super(key: key);
//   final padding = const EdgeInsets.symmetric(horizontal: 20);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: Container(
//       // decoration: const BoxDecoration(
//       //     gradient: LinearGradient(
//       //   begin: Alignment.topRight,
//       //   end: Alignment.bottomLeft,
//       //   colors: [
//       //     Colors.black26,
//       //   ],
//       // )),
//       color: const Color.fromARGB(127, 179, 23, 227),
//       child: ListView(
//         padding: padding,
//         children: <Widget>[
//           const SizedBox(height: 16),
//           buildMenuItem(
//               text: "Scan QR",
//               icon: Icons.qr_code_scanner_rounded,
//               onClicked: () => selectedItem(context, 0)),
//           const SizedBox(height: 16),
//           buildMenuItem(
//               text: "History",
//               icon: Icons.history_rounded,
//               onClicked: () => selectedItem(context, 1)),
//           const SizedBox(height: 16),
//           buildMenuItem(
//               text: "Exit",
//               icon: Icons.exit_to_app_rounded,
//               onClicked: () => selectedItem(context, 2))
//         ],
//       ),
//     ));
//   }

//   Widget buildMenuItem(
//       {required String text, required IconData icon, VoidCallback? onClicked}) {
//     const color = Colors.grey;
//     // const hoverColor = Colors.white70;

//     return Card(
//         child: ListTile(
//       // contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//       leading: Icon(icon, color: color),
//       title: Text(
//         text,
//       ),
//       hoverColor: Colors.grey,
//       onTap: onClicked,
//     ));
//   }

//   void selectedItem(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.popUntil(context, ModalRoute.withName('/'));
//         break;
//       case 1:
//         Navigator.pushNamed(context, '/history');
//         break;
//       case 2:
//         SystemNavigator.pop();
//         break;
//       default:
//     }
//   }
// }
