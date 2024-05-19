import 'package:flutter/material.dart';
import 'package:journal/widgets/entry_card.dart';
import 'package:journal/database/entry_db.dart';
import 'package:journal/widgets/entry_form.dart';
import 'package:journal/model/entry.dart';

final entryDB = EntryDB();

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  // Constructor
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<EntryCard> entries = [];

  @override
  void initState() {
    super.initState();
    fetchCards().then((cards) {
      setState(() {
        entries = cards;
      });
    });
  }

  // Override Build method - this is the layout of the widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Journal"),
        backgroundColor: Colors.blue[600],
      ),
      body: Container(margin: const EdgeInsets.all(10), child: EntryForm()),
      // child: ListView(children: entries)),
    ));
  }
}

Future<List<EntryCard>> fetchCards() async {
  final List<Entry> entries = await entryDB.fetchAll();

  List<EntryCard> cards = [];

  for (Entry entry in entries) {
    cards.add(EntryCard(
        index: entry.index,
        id: entry.id,
        title: entry.title,
        body: entry.body,
        createdAt: entry.createdAt));
  }

  return cards;
}
