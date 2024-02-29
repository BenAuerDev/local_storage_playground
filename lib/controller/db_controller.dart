import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_storage_playground/models/flashlist.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'db_controller.g.dart';

class DBController {
  Database? db;

  Future<Database?> get getDb async {
    db ??= await initializeDb();
    return db;
  }

  Future<Database> initializeDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'flashlist.db'),
      onCreate: createDb,
      version: 1,
    );
  }

  Future<void> createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE flashlists(id INTEGER PRIMARY KEY, title TEXT, isSent INTEGER)',
    );
  }

  Future<void> insertFlashlist(Flashlist flashlist) async {
    final Database db = await getDb as Database;
    await db.insert(
      'flashlists',
      flashlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Flashlist>> getFlashlists() async {
    final Database db = await getDb as Database;
    final List<Map<String, dynamic>> maps = await db.query('flashlists');
    return List.generate(maps.length, (i) {
      return Flashlist(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
      );
    });
  }
}

@riverpod
DBController databaseController(Ref ref) => DBController();

@riverpod
Future<Database?> database(Ref ref) =>
    ref.read(databaseControllerProvider).getDb;

@riverpod
Future<List<Flashlist>> flashlists(Ref ref) =>
    ref.read(databaseControllerProvider).getFlashlists();
