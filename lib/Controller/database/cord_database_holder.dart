import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:th_dkweb/Model/fav_caetegory_item.dart';

import '../../constant.dart';

class CordDatabaseHelper {
  CordDatabaseHelper._();

  static final CordDatabaseHelper db = CordDatabaseHelper._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
      CREATE TABLE $tableFavwall (
        $columncategory TEXT NOT NULL,
        $columnimage_url TEXT NOT NULL,
        $columnloves TEXT NOT NULL,
        $columntimestamp INTEGER NOT NULL)
      ''');
    });
  }

  Future<List<FavCategoryItem>> getAllProdects() async {
    var dbClient = await database;
    List<Map> maps = await dbClient!.query(tableFavwall);
    List<FavCategoryItem> list = maps.isNotEmpty
        ? maps.map((product) => FavCategoryItem.fromJson(product)).toList()
        : [];
    return list;
  }

  inser(FavCategoryItem model) async {
    var dbClient = await database;

    await dbClient!.insert(tableFavwall, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  removeProducs(FavCategoryItem model) async {
    var dbClient = await database;
    return await dbClient!.delete(tableFavwall,
        where: '$columnimage_url=?', whereArgs: [model.image_url]);
  }
}
