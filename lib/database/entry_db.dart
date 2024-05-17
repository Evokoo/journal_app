import 'package:sqflite/sqflite.dart';
import 'package:journal/database/database_service.dart';
import 'package:uuid/uuid.dart';
import 'package:journal/model/entry.dart';

const uuid = Uuid();

/// Class containing CRUD logic and Schema for the Entry Type / Entries Table
class EntryDB {
  final tableName = "entries";

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        "id" TEXT NOT NULL,
        "index" INTEGER PRIMARY KEY AUTOINCREMENT,
        "title" TEXT NOT NULL,
        "body" TEXT NOT NULL,
        "created_at" TEXT NOT NULL,
        "updated_at" TEXT
      );
      ''');
  }

  Future<void> clearTable() async {
    final database = await DatabaseService().database;
    await database.rawDelete('DELETE FROM $tableName');
  }

  Future<int> create({required String title, required String body}) async {
    final database = await DatabaseService().database;
    final timeNow = DateTime.now().toString();

    return await database.rawInsert(
      '''INSERT INTO $tableName (id,title,body,created_at,updated_at) VALUES (?,?,?,?,?)''',
      [uuid.v4(), title, body, timeNow, timeNow],
    );
  }

  Future<int> update(
      {required String id, required String title, required String body}) async {
    final database = await DatabaseService().database;

    return await database.rawUpdate(
        '''UPDATE $tableName SET title = ?, body = ?, updated_at = ? WHERE id = ?''',
        [title, body, DateTime.now().toString(), id]);
  }

  Future<int> delete(String id) async {
    final database = await DatabaseService().database;
    return await database
        .rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  Future<List<Entry>> fetchAll() async {
    final database = await DatabaseService().database;
    final entries = await database.rawQuery('''SELECT * FROM $tableName''');
    return entries.map((entry) => Entry.convertQuery(entry)).toList();
  }

  Future<Entry> fetchById(String id) async {
    final database = await DatabaseService().database;
    final entry = await database
        .rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);

    return Entry.convertQuery(entry.first);
  }
}
