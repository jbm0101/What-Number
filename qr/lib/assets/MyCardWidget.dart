// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:validators/validators.dart';
import 'package:google_fonts/google_fonts.dart';

import '../tools/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tools/Todo.dart';

class MyCardWidget extends StatelessWidget {
  final String text;
  void _persistPreference(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!text.toLowerCase().contains('not yet scanned')) {
      if (prefs.containsKey('history')) {
        String? hist = prefs.getString('history');
        List<Todo> todoCurrent = Todo.decode(hist!);
        globals.todos = todoCurrent;
        globals.todos.add(Todo(text));
        // globals.todos.add(Todo(text, DateTime.now().toString()));
        prefs.setString('history', Todo.encode(globals.todos));
      } else {
        globals.todos.add(Todo(text));
        // globals.todos.add(Todo(text, DateTime.now().toString()));

        prefs.setString('history', Todo.encode(globals.todos));
      }
    }
  }

  const MyCardWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Column(children: [
                    Text(text,
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.6))),
                    Divider(
                      color: Colors.black.withOpacity(0.6),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Copied to Clipboard')),
                            );
                          },
                          icon: const Icon(Icons.copy, size: 18),
                          label: const Text("Copy"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            _persistPreference(text);
                          },
                          icon: const Icon(Icons.save, size: 18),
                          label: const Text('Save'),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              if (isURL(text, requireTld: false)) {
                                launchUrlString(text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Invalid URL')),
                                );
                              }
                            },
                            icon: const Icon(Icons.open_in_browser),
                            label: const Text("Open"))
                      ],
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ]),
                )
              ],
            ))

        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        //   color: Colors.red,
        //   elevation: 10,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       ListTile(
        //         title: Text(
        //           text,
        //           style: const TextStyle(fontSize: 30.0),
        //         ),
        //       ),
        //       ElevatedButton(
        //         child: const Icon(Icons.copy),
        //         onPressed: () {
        //           Clipboard.setData(ClipboardData(text: text));
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             const SnackBar(content: Text('Copied to Clipboard')),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
