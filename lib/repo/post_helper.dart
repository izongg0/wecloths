import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wecloths/main.dart';
import 'package:wecloths/model/ClothsModel.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String path = await getDatabasesPath();
    path = join(path, 'items.db');

    return await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY,
            img TEXT,
            link TEXT,
            category TEXT,
            title TEXT,
            content TEXT,
            price TEXT
          )
        ''');
    }, version: 2);
  }

  Future<int> insertItem(ClothsModel item) async {
    final Database? dbClient = await db;
    int id = await dbClient!.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<ClothsModel>> getItems() async {
    final Database? dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('items');

    var clothsList = List.generate(maps.length, (i) {
      return ClothsModel.fromMap(maps[i]);
    });
    print(clothsList);
    return clothsList;
  }

  // 모든 항목 삭제
  Future<void> deleteAllItems() async {
    final Database? dbClient = await db;
    await dbClient!.delete('items');
  }

  // 칼럼 추가
  Future<void> updateDatabase() async {
    final Database? dbClient = await db;
    await dbClient!.execute('ALTER TABLE items ADD COLUMN link TEXT');
  }
  // Future<void> updateItem(ClothsModel item) async {
  //   final Database dbClient = await db;
  //   await dbClient.update(
  //     'items',
  //     item.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [item.id],
  //   );
  // }

  Future<void> deleteItem(int id) async {
    final Database? dbClient = await db;
    await dbClient!.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );


  }
}



