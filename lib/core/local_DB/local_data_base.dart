
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

import '../../features/characters/data/models/CharacterResponse.dart';
import '../../features/characters/data/models/info_model.dart';
import '../Models/character_model.dart';

// Local Data Source
class CharacterLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'characters.db'),
      version: 1,
      onCreate: (db, version) {
         db.execute(
            'CREATE TABLE characters(id INTEGER PRIMARY KEY, name TEXT, status TEXT, species TEXT, image TEXT)'
        );
         db.execute(
             'CREATE TABLE info(count INTEGER, pages INTEGER, next TEXT, prev TEXT)'
         );
      },
    );
    return _database!;
  }

  Future<void> cacheCharacters(CharacterResponse response) async {

    final db = await database;

    for (var character in response.results) {
      await db.insert(Character.TABLE_NAME, character.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await db.insert('info', response.info.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<List<Character>> getCachedCharacters() async {
    final db = await database;
    final maps = await db.query('characters');

    return List<Character>.from(maps.map((map) => Character.fromMap(map)));
  }

  Future<Info?> getCachedInfo() async {
    final db = await database;
    final maps = await db.query('info', limit: 1);

    if (maps.isNotEmpty) {
      return Info.fromJson(maps.first);
    }
    return null;
  }

}