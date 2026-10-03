import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> getdatabase()async {
    if(_database != null){
      return _database!;
    }
    _database = await _initDatabase();
      return _database!;
  }


  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = join(
      dbPath,
      "bus_ticket_registe.db"
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE auth(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            token TEXT,
            is_logged_in INTEGER NOT NULL DEFAULT 0,
            updated_at TEXT
          )
          """
        );
      },
    );
  }
}