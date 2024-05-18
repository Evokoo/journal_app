import 'package:flutter/material.dart';
import 'package:journal/widgets/entry_card.dart';
import 'package:journal/database/entry_db.dart';

final entryDB = EntryDB();

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  // Constructor
  const MainApp({super.key});

  // Override Build method - this is the layout of the widget
  @override
  Widget build(BuildContext context) {
    final List<EntryCard> entries = [];

    for (int i = 0; i < 20; i++) {
      entries.add(EntryCard(
          title: "This is title $i",
          body:
              "Curabitur tristique purus lobortis, eleifend erat vitae, mollis ipsum. Mauris efficitur, magna at pharetra volutpat, ipsum nisl eleifend ex, at porttitor felis odio eu mi. Nam sed magna rhoncus, dictum ipsum nec, posuere purus. Vivamus sodales finibus consectetur. Nam imperdiet faucibus est vitae auctor"));
    }

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Journal"),
              centerTitle: true,
              backgroundColor: Colors.blue[600],
            ),
            body: Container(
                margin: const EdgeInsets.all(10),
                child: ListView(children: entries))));
  }
}
