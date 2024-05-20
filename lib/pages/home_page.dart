import 'package:flutter/material.dart';
// import 'package:journal/database/entry_db.dart';
import 'package:journal/pages/entry_form_page.dart';
import 'package:journal/widgets/entry_card.dart';

// var entryDB = EntryDB();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<EntryCard> entryCards = [];

  @override
  void initState() {
    super.initState();
  }

  // Override Build method - this is the layout of the widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Journal Entries",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[800],
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EntryFormPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: ListView(
          children: entryCards,
        ));
  }
}