
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

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
        return db.execute(
            'CREATE TABLE characters(id INTEGER PRIMARY KEY, name TEXT, status TEXT, species TEXT, image TEXT)'
        );
      },
    );
    return _database!;
  }

  Future<void> cacheCharacters(List<Character> characters) async {
    final db = await database;
    await db.delete('characters');
    for (var character in characters) {
      await db.insert('characters', character.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Character>> getCachedCharacters() async {
    final db = await database;
    final maps = await db.query('characters');

    return List<Character>.from(maps.map((map) => Character.fromMap(map)));
  }
}