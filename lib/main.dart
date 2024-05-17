import 'package:flutter/material.dart';
import 'package:journal/database/entry_db.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
            child: TextButton(
          onPressed: click,
          child: Text("Hello"),
        )),
      ),
    );
  }
}

void click() async {
  print("Click");

  var entryDB = EntryDB();

  await entryDB.clearTable();
  var entries = await entryDB.fetchAll();

  print(entries);
}
