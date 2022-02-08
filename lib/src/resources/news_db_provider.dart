import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    final path = join(docDir.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items(
            id INT PRIMARY KEY,
            type TEXT,
            by TEXT, 
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )  
        """);
      },
    );
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final mapList = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (mapList.isNotEmpty) {
      return ItemModel.fromDb(mapList.first);
    } else {
      return null;
    }
  }

  @override
  Future<int>? addItem(ItemModel item) {
    db.insert(
      "Items",
      item.toMapforDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();
