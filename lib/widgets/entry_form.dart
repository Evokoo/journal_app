import 'package:flutter/material.dart';
import 'package:journal/database/entry_db.dart';

var entryDB = EntryDB();

class EntryForm extends StatefulWidget {
  const EntryForm({super.key});

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  String title = "";
  String body = "";

  final _titleField = TextEditingController(text: "Title");
  final _bodyField = TextEditingController(text: "Body");

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _p(_title(_titleField, "Title"), [5, 12, 5, 12]),
            _p(_body(_bodyField, "Body"), [5, 12, 5, 12]),
            _saveButton()
          ],
        ));
  }

  // Quick padding
  Padding _p(Widget widget, List<double> ltrb) {
    return Padding(
        padding: EdgeInsets.fromLTRB(ltrb[0], ltrb[1], ltrb[2], ltrb[3]),
        child: widget);
  }

  // Title Field
  Widget _title(TextEditingController controller, String label) {
    return TextField(
        controller: controller,
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()));
  }

  // Widget Field
  Widget _body(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
      maxLines: 10,
    );
  }

  // Button
  Widget _saveButton() {
    return ElevatedButton(
      onPressed: () => _saveEntry(_titleField.text, _bodyField.text),
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white)),
      child: Text("Save"),
    );
  }

  //CRUD
  Future<void> _saveEntry(String title, String body) async {
    await entryDB.create(title: title, body: body);

    print(await entryDB.fetchAll());
  }
}
