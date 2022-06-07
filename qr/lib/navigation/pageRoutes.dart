import 'package:qr/Screens/History.dart';
import 'package:qr/Screens/ScanQR.dart';
import 'package:qr/Screens/barcode_scanner_controller.dart';

class pageRoutes {
  static const String home = BarcodeScannerWithController.routeName;
  static const String history = History.routeName;
  static const String scanned = ScanQR.routeName;
}
