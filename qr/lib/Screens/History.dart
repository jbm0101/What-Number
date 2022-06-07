// ignore_for_file: file_names
import 'package:qr/tools/Todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../assets/MyCardWidget.dart';
import '../assets/HistoryCardWidget.dart';
import '../tools/globals.dart' as globals;
import 'package:flutter/material.dart';

import '../navigation/navdrawer.dart';

class History extends StatefulWidget {
  static const String routeName = '/history';
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // getting stored information from storedpreferences(local DB)
  // into global variable todos.
  SharedPreferences? prefs;
  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.containsKey('history')) {
      String? hist = prefs?.getString('history');
      List<Todo> todoCurrent = Todo.decode(hist!);
      globals.todos = todoCurrent;
    }
  }

  @override

  // it makes sure that data from local storage gets loaded into global variable
  // todos before actually loading the screen.
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // listview of cards saved in local storage.
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: globals.todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    // var description2 = globals.todos[index].description;
                    // String? dateTime = globals.todos[index].currentTime;
                    // if (dateTime != null) {
                    //   dateTime = dateTime.substring(0, 8) + "T" + dateTime.substring(8);
                    //   DateTime dateTimetemp = DateTime.parse(dateTime);
                    // }
                    return HistoryCardWidget(text: globals.todos[index].description!,);
                      
                  }),
            ),
          ],
        ));
  }
}

// class _MyCardWidgetState extends State<MyCardWidget> {
//   @override

