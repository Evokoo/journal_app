import 'package:flutter/material.dart';

class EntryFormPage extends StatefulWidget {
  final Function createHandler;

  const EntryFormPage({
    super.key,
    required this.createHandler,
  });

  @override
  State<EntryFormPage> createState() => _EntryFormPageState();
}

class _EntryFormPageState extends State<EntryFormPage> {
  final _titleTC = TextEditingController();
  final _bodyTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add New Entry",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[800],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _p(_title("Title"), [5, 12, 5, 12]),
                _p(_body("Body"), [5, 12, 5, 12]),
                _saveButton()
              ],
            )));
  }

  // Quick padding
  Padding _p(Widget widget, List<double> ltrb) {
    return Padding(
        padding: EdgeInsets.fromLTRB(ltrb[0], ltrb[1], ltrb[2], ltrb[3]),
        child: widget);
  }

  // Title Field
  Widget _title(String label) {
    return TextField(
        controller: _titleTC,
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()));
  }

  // Widget Field
  Widget _body(String label) {
    return TextField(
      controller: _bodyTC,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      maxLines: 10,
    );
  }

  // Button
  Widget _saveButton() {
    return ElevatedButton(
      onPressed: () {
        widget.createHandler(title: _titleTC.text, body: _bodyTC.text);

        setState(() {
          _titleTC.clear();
          _bodyTC.clear();
        });
      },
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white)),
      child: const Text("Save"),
    );
  }

  void _cleanUp() {}
}
