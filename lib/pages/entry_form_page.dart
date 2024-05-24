import 'package:flutter/material.dart';
import 'package:journal/assets/card_colors.dart';

class EntryFormPage extends StatefulWidget {
  final Function? createHandler;
  final Function? updateHandler;
  final bool createMode;
  final String? title;
  final String? body;
  final String? id;
  final int? colorID;

  const EntryFormPage({
    super.key,
    required this.createMode,
    this.createHandler,
    this.updateHandler,
    this.title,
    this.body,
    this.id,
    this.colorID,
  });

  @override
  State<EntryFormPage> createState() => _EntryFormPageState();
}

class _EntryFormPageState extends State<EntryFormPage> {
  final _titleTC = TextEditingController();
  final _bodyTC = TextEditingController();

  late int _colorId;
  late MaterialColor _color;

  @override
  void initState() {
    super.initState();

    _titleTC.text = widget.title ?? "";
    _bodyTC.text = widget.body ?? "";
    _colorId = widget.colorID ?? 0;
    _color = getColor(_colorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add New Entry",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: _color[300],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Container(
            color: _color[300],
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _colorPicker(),
                _p(_title("Title"), [5, 12, 5, 12]),
                _p(_body("Body"), [5, 12, 5, 12]),
                _saveButton()
              ],
            )));
  }

  //Color picker
  Widget _colorPicker() {
    void assingColor(int index) {
      setState(() {
        _colorId = index;
        _color = getColor(_colorId);
      });
    }

    List<Widget> swatches = getAllColors().asMap().entries.map((el) {
      final color = getColor(el.key);

      return InkWell(
          onTap: () => assingColor(el.key),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: color.shade300,
                shape: BoxShape.circle,
                border: Border.all(color: color.shade600, width: 2)),
          ));
    }).toList();

    return Row(children: [
      const Spacer(flex: 2),
      Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: swatches,
        ),
      )
    ]);
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
        if (widget.createMode) {
          widget.createHandler!(
              title: _titleTC.text, body: _bodyTC.text, colorID: _colorId);
        } else {
          widget.updateHandler!(
              title: _titleTC.text,
              body: _bodyTC.text,
              id: widget.id,
              colorID: _colorId);
        }

        setState(() {
          _titleTC.clear();
          _bodyTC.clear();
        });
      },
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white)),
      child: widget.createMode ? const Text("Save") : const Text("Update"),
    );
  }
}
