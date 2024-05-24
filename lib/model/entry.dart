class Entry {
  final int index;
  final String id;
  final String title;
  final String body;
  final String createdAt;
  final int colorID;
  final String? updatedAt;

  Entry(
      {required this.id,
      required this.index,
      required this.title,
      required this.body,
      required this.createdAt,
      required this.colorID,
      this.updatedAt});

  factory Entry.convertQuery(Map<String, dynamic> query) => Entry(
      id: query["id"],
      index: query["index"],
      title: query["title"] ?? "",
      body: query["body"] ?? "",
      colorID: query["color_id"],
      createdAt: query["created_at"],
      updatedAt: query["updated_at"]);

  @override
  String toString() {
    return "index:$index, id:$id, title:$title, body: $body, created_at: $createdAt, updated_at: $updatedAt";
  }
}
