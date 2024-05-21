import 'package:journal/database/entry_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  /// Development mode for the data
  /// `true` - Database is created in memory
  /// `false` - Database uses file path
  final bool _devMode = false;

  Future<Database> get database async {
    // If Database exists return database
    if (_database != null) {
      return _database!;
    }

    // If no database init databse
    _database = await _initalize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "entries.db";
    final path = await getDatabasesPath();

    return join(path, name);
  }

  Future<Database> _initalize() async {
    final path = _devMode ? ':memory:' : await fullPath;

    var database = await openDatabase(path,
        version: 1, onCreate: _create, singleInstance: true);

    return database;
  }

  Future<void> _create(Database database, int version) async {
    await EntryDB().createTable(database);
  }
}
