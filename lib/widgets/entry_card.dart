import 'package:flutter/material.dart';

class EntryCard extends StatelessWidget {
  final String title;
  final String body;

  const EntryCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(5),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
                children: [_titleBar(title), _bodyContent(body), _date()])));
  }

  Widget _date() {
    DateTime dt = DateTime.now();
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
      Icon(Icons.edit, color: Colors.grey[400]),
      Icon(Icons.highlight_remove, color: Colors.grey[400])
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
