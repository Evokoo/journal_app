import 'package:flutter/material.dart';
import 'package:journal/model/entry.dart';
import 'package:journal/database/entry_db.dart';
import 'package:journal/pages/entry_form_page.dart';
import 'package:journal/widgets/entry_card.dart';

var entryDB = EntryDB();

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
    _fetchEntries();
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
                    builder: (context) => EntryFormPage(
                      createMode: true,
                      createHandler: _createEntry,
                    ),
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
        padding: const EdgeInsets.all(5),
        children: entryCards,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        elevation: 10,
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EntryFormPage(
                createMode: true,
                createHandler: _createEntry,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _fetchEntries() async {
    List<EntryCard> entryCardList = [];

    try {
      var entries = await entryDB.fetchAll();

      for (Entry entry in entries) {
        entryCardList.add(EntryCard(
          index: entry.index,
          id: entry.id,
          title: entry.title,
          body: entry.body,
          createdAt: entry.createdAt,
          deleteHandler: _deleteHandler,
          updateHandler: _upateHandler,
        ));
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() => entryCards = entryCardList);
    }
  }

  Future<void> _createEntry(
      {required String title, required String body}) async {
    await entryDB.create(title: title, body: body);

    if (mounted) {
      _fetchEntries();
      Navigator.pop(context);
    }
  }

  Future<void> _upateHandler(
      {required String id, required String title, required String body}) async {
    await entryDB.update(id: id, title: title, body: body);

    if (mounted) {
      _fetchEntries();
      Navigator.pop(context);
    }
  }

  Future<void> _deleteHandler(String id) async {
    await entryDB.delete(id);

    _fetchEntries();
  }
}
