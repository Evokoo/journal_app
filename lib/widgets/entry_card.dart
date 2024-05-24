import 'package:flutter/material.dart';
import 'package:journal/assets/card_colors.dart';
import 'package:journal/database/entry_db.dart';
import 'package:journal/pages/entry_form_page.dart';

var entryDB = EntryDB();

class EntryCard extends StatefulWidget {
  final String id;
  final int index;
  final String title;
  final String body;
  final String createdAt;
  final int colorID;
  final String? updatedAt;
  final Function? deleteHandler;
  final Function? updateHandler;

  const EntryCard(
      {super.key,
      required this.index,
      required this.id,
      required this.title,
      required this.body,
      required this.createdAt,
      required this.colorID,
      this.updatedAt,
      this.deleteHandler,
      this.updateHandler});

  @override
  State<EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<EntryCard> {
  bool readMore = false;
  MaterialColor cardColor = getColor(0);

  @override
  void initState() {
    super.initState();
    cardColor = getColor(widget.colorID);
  }

  @override
  void didUpdateWidget(covariant EntryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.colorID != oldWidget.colorID) {
      setState(() => cardColor = getColor(widget.colorID));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: cardColor[200],
        margin: const EdgeInsets.all(5),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _titleBar(widget.title),
              _bodyContent(widget.body),
              _date(),
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
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      IconButton(
          icon: const Icon(Icons.edit),
          color: cardColor[700],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EntryFormPage(
                  id: widget.id,
                  title: widget.title,
                  body: widget.body,
                  colorID: widget.colorID,
                  createMode: false,
                  updateHandler: widget.updateHandler,
                ),
              ),
            );
          }),
      IconButton(
        icon: const Icon(Icons.highlight_remove),
        color: cardColor[700],
        onPressed: () => widget.deleteHandler!(widget.id),
      )
    ]);
  }

  Widget _titleBar(String title) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
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
          if (body.length > 200)
            GestureDetector(
              child: Text(readMore ? body : "${body.substring(0, 200)}..."),
              onTap: () {
                setState(() {
                  readMore = !readMore;
                  print(readMore);
                });
              },
            )
          else
            Text(body),
          // body,
        ]));
  }
}
