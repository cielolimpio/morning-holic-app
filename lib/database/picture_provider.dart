import 'dart:async';
import 'package:morning_holic_app/entities/picture.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PictureProvider {
  static final PictureProvider _pictureProvider = PictureProvider._internal();
  PictureProvider._internal() {
  }
  factory PictureProvider() {
    return _pictureProvider;
  }

  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    String path = join(await getDatabasesPath(), 'pictures.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE pictures(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              picture BLOB NOT NULL,
              minusScore INTEGER NOT NULL,
              datetime TEXT NOT NULL
            )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  Future<int> insertAndGetId(Picture pic) async {
    final db = await database;
    pic.id = await db.insert('pictures', pic.toMap());
    return pic.id!;
  }

  Future<Picture?> getPictureById(int pictureId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'pictures',
      where: "id = ?",
      whereArgs: [pictureId],
    );
    if (maps.isNotEmpty) {
      return Picture(
        id: maps.first["id"],
        picture: maps.first["picture"],
        minusScore: maps.first["minusScore"],
        datetime: maps.first["datetime"],
      );
    } else {
      return null;
    }
  }

  Future<void> delete(Picture pic) async {
    final db = await database;
    await db.delete(
      'pictures',
      where: "id = ?",
      whereArgs: [pic.id],
    );
  }

  Future<List<Picture>> getDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pictures');
    if( maps.isEmpty ) return [];
    List<Picture> list = List.generate(maps.length, (index) {
      return Picture(
        id: maps[index]["id"],
        picture: maps[index]["picture"],
        minusScore: maps[index]["minusScore"],
        datetime: maps[index]["datetime"],
      );
    });
    return list;
  }

  Future<List<Picture>> getQuery(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    if( maps.isEmpty ) return [];
    List<Picture> list = List.generate(maps.length, (index) {
      return Picture(
        id: maps[index]["id"],
        picture: maps[index]["picture"],
        minusScore: maps[index]["minusScore"],
        datetime: maps[index]["datetime"],
      );
    });
    return list;
  }
}