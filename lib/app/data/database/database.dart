
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseSqlite {
  static final  DatabaseSqlite _dbsqlite = DatabaseSqlite._internal();
  Database? _db ;

  factory DatabaseSqlite() {
    return _dbsqlite;
  }

  DatabaseSqlite._internal() {
    db;
  }

  Future<Database> get db async {
    _db ??= await initializeDatabase();
    return _db!;
  }

  final _databaseVersion = 1;

  // Script criação das tabelas
  static final createTableFazenda = '''
    CREATE TABLE ${DBTableName.farms.value} (
      FRM_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      FRM_NAME TEXT NOT NULL
    )
  ''';
  static final createTableAnimal = '''
    CREATE TABLE ${DBTableName.animals.value} (
      ANM_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      ANM_FRM_ID INTEGER,
      ANM_NAME TEXT NOT NULL,
      ANM_TAG TEXT NOT NULL,
      FOREIGN KEY (ANM_FRM_ID) REFERENCES ${DBTableName.farms.value} (FRM_ID) 
      ON DELETE CASCADE
    )
  ''';

  // Método para inicializar o banco de dados
  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'database.db');

    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute(createTableFazenda);
        db.execute(createTableAnimal);
      },
    );
  }
}

enum DBTableName {
  animals('ANIMALS'),
  farms('FARMS');

  final String value;
  const DBTableName(this.value);
}