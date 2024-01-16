import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wallpaper_app/models/user_model.dart';

class DatabaseService {
  static const String _databaseName = 'user_database.db';
  static const String _tableName = 'user_table';
  static const String columnId = 'id';
  static const String columnUserId = 'user_id';
  static const String columnFirstName = 'first_name';
  static const String columnLastName = 'last_name';
  static const String columnEmail = 'email';
  static const String columnPhoneNumber = 'phone_number';
  static const String columnFavoriteImages = 'favorite_images';

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnUserId TEXT,
            $columnFirstName TEXT,
            $columnLastName TEXT,
            $columnEmail TEXT,
            $columnPhoneNumber TEXT,
            $columnFavoriteImages TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertUser({
    required String userId,
    required UserModel model,
  }) async {
    final data = model.toJson();
    data[columnUserId] = userId;
    await _database.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser({
    required String userId,
    required UserModel updatedData,
  }) async {
    await _database.update(
      _tableName,
      updatedData.toJson(),
      where: '$columnUserId = ?',
      whereArgs: [userId],
    );
  }

  Future<UserModel?> getUser(String userId) async {
    List<Map<String, dynamic>> maps = await _database.query(
      _tableName,
      where: '$columnUserId = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> deleteUser(String userId) async {
    await _database.delete(
      _tableName,
      where: '$columnUserId = ?',
      whereArgs: [userId],
    );
  }
}
