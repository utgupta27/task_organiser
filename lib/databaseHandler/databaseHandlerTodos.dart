import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_organiser/dataModle/todoDataModle.dart';

class DatabaseHandlerTodos {
  static final DatabaseHandlerTodos instance = DatabaseHandlerTodos._init();
  static Database? _database;
  DatabaseHandlerTodos._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
      CREATE TABLE $tableTodos ( 
        ${TodoFields.id} $idType,
        ${TodoFields.title} $textType,
        ${TodoFields.subtitle} $textType,
        ${TodoFields.priority} $textType,
        ${TodoFields.dueDate} $textType,
        ${TodoFields.date} $textType
        )
      ''');
  }

  Future<Todo> create(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(tableTodos, todo.toJson());
    return todo.copy(id: id);
  }

  Future<Todo> readTodo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableTodos,
      columns: TodoFields.values,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Todo>> readAllTodos() async {
    final db = await instance.database;

    final orderBy = '${TodoFields.id} DESC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableTodos ORDER BY $orderBy');

    final result = await db.query(tableTodos, orderBy: orderBy);

    return result.map((json) => Todo.fromJson(json)).toList();
  }

  Future<int> update(Todo Todo) async {
    final db = await instance.database;

    return db.update(
      tableTodos,
      Todo.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [Todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableTodos,
      where: '${TodoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
