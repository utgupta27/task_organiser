import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:task_organiser/dataModle.dart';

class DatabaseHandler {
  static final _dbName = 'task_organiser.db';
  static final _dbVersion = 1;
  static final _tableName = 'todoModleTodoModleList';

  static final index = 'id';
  static final title = 'title';
  static final subtitle = 'subtitle';
  static final priority = 'priority';
  static final dueDate = 'dueDate';
  static final date = 'date';
  // dynamic database;

  static final DatabaseHandler instance = DatabaseHandler._privateConstructor();
  // factory DatabaseHandler() => instance;
  DatabaseHandler._privateConstructor() {
    _initDatabase();
  }

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName(
        $index INTEGER PRIMARY KEY,
        $title TEXT,
        $subtitle TEXT,
        $priority TEXT,
        $dueDate TEXT,
        $date TEXT
      )
      ''');
  }

  insert(TodoModle todoModleTodoModleData) async {
    Database db = await instance.database;
    return await db.insert(_tableName, todoModleTodoModleData.toMap());
  }

  queryAll() async {
    Database db = await instance.database;
    var res = await db.query(_tableName);
    List<TodoModle> lst =
        res.isNotEmpty ? res.map((e) => TodoModle.fromMap(e)).toList() : [];
    return lst;
  }

  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[index];
  //   return await db
  //       .update(_tableName, row, where: '$index = ?', whereArgs: [id]);
  // }

  delete(int id) async {
    Database db = await instance.database;
    await db.delete(_tableName, where: '$id = ?', whereArgs: [id]);
  }
}
