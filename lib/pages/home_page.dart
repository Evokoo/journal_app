import 'package:flutter/material.dart';
import 'package:journal/model/entry.dart';
import 'package:journal/database/entry_db.dart';
// import 'package:journal/pages/entry_form_page.dart';
import 'package:journal/pages/form_page.dart';
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
        title: const Text("Journal Entries"),
        actions: [
          IconButton(onPressed: _toEntryForm, icon: const Icon(Icons.add))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: entryCards,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toEntryForm,
        child: const Icon(
          Icons.add,
        ),
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
          updatedAt: entry.updatedAt,
          colorID: entry.colorID,
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
      {required String title,
      required String body,
      required int colorID}) async {
    await entryDB.create(title: title, body: body, colorID: colorID);

    // if (mounted) {
    _fetchEntries();
    // Navigator.pop(context);
    // }
  }

  Future<void> _upateHandler(
      {required String id,
      required String title,
      required String body,
      required int colorID,
      required String updatedAt}) async {
    await entryDB.update(
        id: id,
        title: title,
        body: body,
        colorID: colorID,
        updatedAt: updatedAt);

    // if (mounted) {
    _fetchEntries();
    // Navigator.pop(context);
    // }
  }

  Future<void> _deleteHandler(String id) async {
    await entryDB.delete(id);

    _fetchEntries();
  }

  void _toEntryForm() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InputFormPage(
          createMode: true,
          entryCreate: _createEntry,
        ),
      ),
    );
  }
}
