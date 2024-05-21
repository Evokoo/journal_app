import 'package:flutter/material.dart';
import 'package:journal/database/entry_db.dart';

var entryDB = EntryDB();

class EntryCard extends StatefulWidget {
  final String id;
  final int index;
  final String title;
  final String body;
  final String createdAt;
  final String? updatedAt;
  final Function? deleteHandler;

  const EntryCard(
      {super.key,
      required this.index,
      required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      this.updatedAt,
      this.deleteHandler});

  @override
  State<EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(5),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              _titleBar(widget.title),
              _bodyContent(widget.body),
              _date()
            ])));
  }

  Widget _date() {
    DateTime dt = DateTime.parse(widget.createdAt);
    String mm = dt.month.toString().padLeft(2, "0");
    String dd = dt.day.toString();
    String yyyy = dt.year.toString();
    String min = dt.minute.toString().padLeft(2, "0");
    String hour = dt.hour.toString();

    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Text(
              "$dd - $mm - $yyyy @ $hour:$min",
              style: const TextStyle(fontSize: 12),
            )
          ],
        ));
  }

  Widget _icons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      IconButton(
        icon: const Icon(Icons.edit),
        color: Colors.grey[400],
        onPressed: () => print("Edit"),
      ),
      IconButton(
        icon: const Icon(Icons.highlight_remove),
        color: Colors.grey[400],
        onPressed: () => widget.deleteHandler!(widget.id),
      )
    ]);
  }

  Widget _titleBar(String title) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                )),
            Expanded(flex: 1, child: _icons())
          ],
        ));
  }

  Widget _bodyContent(String body) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Wrap(children: [
          Text(
            body,
          )
        ]));
  }
}
