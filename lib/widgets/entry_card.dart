import 'package:flutter/material.dart';
import 'package:journal/assets/my_colors.dart';
import 'package:journal/database/entry_db.dart';
// import 'package:journal/pages/entry_form_page.dart';
import 'package:journal/pages/form_page.dart';

final entryDB = EntryDB();
final myColors = ColorHelper();

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
  MaterialColor cardColor = myColors.getColor(0);

  @override
  void initState() {
    super.initState();
    cardColor = myColors.getColor(widget.colorID);
  }

  @override
  void didUpdateWidget(covariant EntryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.colorID != oldWidget.colorID) {
      setState(() => cardColor = myColors.getColor(widget.colorID));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: cardColor.shade200,
        child: Padding(
            padding: const EdgeInsets.all(5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _titleBar(widget.title),
              _bodyContent(widget.body),
              _date(),
            ])));
  }

  String _parseDate(String input) {
    DateTime dt = DateTime.parse(input);
    String mm = dt.month.toString().padLeft(2, "0");
    String dd = dt.day.toString().padLeft(2, "0");
    String yyyy = dt.year.toString().substring(2);
    String min = dt.minute.toString().padLeft(2, "0");
    String hour = dt.hour.toString();

    return "$dd/$mm/$yyyy @ $hour:$min";
  }

  Widget _date() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Created at: ${_parseDate(widget.createdAt)}",
              style: const TextStyle(fontSize: 12),
            ),
            if (widget.updatedAt != null)
              Text(
                "Updated at: ${_parseDate(widget.updatedAt!)}",
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
                builder: (context) => InputFormPage(
                  id: widget.id,
                  title: widget.title,
                  body: widget.body,
                  colourID: widget.colorID,
                  createMode: false,
                  entryUpdate: widget.updateHandler,
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
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
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
