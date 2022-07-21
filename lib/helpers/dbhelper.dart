import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> get favoritesDatabase async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'favorites.db'),
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
            "CREATE TABLE favorites(id TEXT PRIMARY KEY, city TEXT, latitude DOUBLE, longitude DOUBLE)");
      },
    );
  }

  static Future<void> insertFavoriteCity(
      String id, String city, double latitude, double longitude) async {
    final sqlDatabase = await favoritesDatabase;
    await sqlDatabase.insert(
      'favorites',
      {
        'id': id,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> get favoritesData async {
    final sqlDatabase = await favoritesDatabase;
    return sqlDatabase.query('favorites');
  }

  static Future<void> delete(String id) async {
    final sqlDatabase = await favoritesDatabase;
    await sqlDatabase.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
