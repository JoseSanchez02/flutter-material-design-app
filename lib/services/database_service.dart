import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item.dart';

/// Service for managing SQLite database operations
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  /// Get database instance (singleton pattern)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'items_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  /// Create database tables
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        imagePath TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  /// Insert sample data for demonstration
  Future<void> _insertSampleData(Database db) async {
    final sampleItems = [
      Item(
        title: 'Material Design Guide',
        description:
            'Comprehensive guide to implementing Material Design in Flutter applications with responsive layouts.',
      ),
      Item(
        title: 'Responsive Layouts',
        description:
            'Best practices for creating responsive UIs that adapt to different screen sizes and orientations.',
      ),
      Item(
        title: 'Flutter Architecture',
        description:
            'Clean architecture patterns for Flutter apps including repository pattern and state management.',
      ),
      Item(
        title: 'Accessibility First',
        description:
            'Ensuring your Flutter apps are accessible to all users with proper semantic labels and touch targets.',
      ),
      Item(
        title: 'Performance Optimization',
        description:
            'Tips and techniques for optimizing Flutter app performance on various Android devices.',
      ),
      Item(
        title: 'Testing Strategies',
        description:
            'Unit, widget, and integration testing strategies for robust Flutter applications.',
      ),
    ];

    for (var item in sampleItems) {
      await db.insert('items', item.toMap());
    }
  }

  /// Create a new item
  Future<int> createItem(Item item) async {
    final db = await database;
    return await db.insert('items', item.toMap());
  }

  /// Read all items
  Future<List<Item>> getAllItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      orderBy: 'updatedAt DESC',
    );
    return List.generate(maps.length, (i) => Item.fromMap(maps[i]));
  }

  /// Read a single item by id
  Future<Item?> getItem(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Item.fromMap(maps.first);
  }

  /// Update an existing item
  Future<int> updateItem(Item item) async {
    final db = await database;
    return await db.update(
      'items',
      item.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  /// Delete an item
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Search items by title or description
  Future<List<Item>> searchItems(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'updatedAt DESC',
    );
    return List.generate(maps.length, (i) => Item.fromMap(maps[i]));
  }

  /// Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
