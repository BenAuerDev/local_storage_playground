import 'package:local_storage_playground/models/flashlist.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'db_controller.g.dart';

@riverpod
class DBController extends _$DBController {
  Database? db;

  @override
  List<Flashlist> build() {
    _initializeDb();
    return [];
  }

  Future<void> _initializeDb() async {
    db ??= await openDatabase(
      join(await getDatabasesPath(), 'flashlist.db'),
      onCreate: _createDb,
      version: 1,
    );
    _fetchFlashlists();
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashlists(
        id INTEGER PRIMARY KEY, 
        title TEXT, 
        isSent INTEGER, 
        items TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE flashlist_items(
        id INTEGER PRIMARY KEY,
        parentId INTEGER,
        name TEXT,
        FOREIGN KEY(parentId) REFERENCES flashlists(id)
      )
    ''');
  }

  Future<void> insertFlashlist(Flashlist flashlist) async {
    final Database db = this.db as Database;

    await db.insert(
      'flashlists',
      {
        'id': flashlist.id,
        'title': flashlist.title,
      },
    );

    _fetchFlashlists();
  }

  Future<void> removeFlashlist(int id) async {
    final Database db = this.db as Database;
    await db.delete(
      'flashlists',
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchFlashlists();
  }

  Future<void> addItemToFlashlist(int id, String name) async {
    final Database db = this.db as Database;
    await db.insert(
      'flashlist_items',
      <String, dynamic>{
        'flashlist_id': id,
        'item': name,
      },
    );
    _fetchFlashlists();
  }

  Future<void> _fetchFlashlists() async {
    final Database db = this.db as Database;

    // Query flashlists
    final List<Map<String, dynamic>> flashlistMaps =
        await db.query('flashlists');

    // Query items
    final List<Map<String, dynamic>> flashlistItemsMaps =
        await db.query('flashlist_items');

    state = List.generate(
      flashlistMaps.length,
      (i) {
        final items = flashlistItemsMaps
            .where((element) {
              return element['flashlist_id'] == flashlistMaps[i]['id'];
            })
            .map((e) => e['item'])
            .toList();

        return Flashlist(
          id: flashlistMaps[i]['id'],
          title: flashlistMaps[i]['title'],
          items: List<String>.from(items),
        );
      },
    );
  }
}
