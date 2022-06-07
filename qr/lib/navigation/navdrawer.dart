import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pageRoutes.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: Colors.deepPurpleAccent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              createDrawerHeader(),
              createDrawerBodyItem(
                  icon: Icons.qr_code_scanner_rounded,
                  text: 'Scan',
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, pageRoutes.home)),
              createDrawerBodyItem(
                  icon: Icons.history_rounded,
                  text: 'History',
                  onTap: () => Navigator.pushReplacementNamed(
                      context, pageRoutes.history)),
              const Divider(),
              createDrawerBodyItem(
                  icon: Icons.exit_to_app_rounded,
                  text: 'Exit',
                  onTap: () => SystemNavigator.pop()),
              ListTile(
                title: const Text('App version 1.0.0'),
                onTap: () {},
              ),
            ],
          )),
    );
  }

  Widget createDrawerBodyItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/qr.png'),
            fit: BoxFit.cover,
          ),
          ),
        child: Stack(children: const <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("QR & Barcode Scanner",
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}
