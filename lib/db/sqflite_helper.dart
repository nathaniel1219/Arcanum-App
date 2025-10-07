import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQFLiteHelper {
  static final SQFLiteHelper _instance = SQFLiteHelper._internal();
  factory SQFLiteHelper() => _instance;
  SQFLiteHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // Products table
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        product_name TEXT,
        image_url TEXT,
        price REAL,
        description TEXT,
        category TEXT,
        sub_category TEXT,
        details TEXT
      )
    ''');

    // Users table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        token TEXT
      )
    ''');

    // Cart table
    await db.execute('''
      CREATE TABLE cart(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        product_id INTEGER,
        quantity INTEGER,
        FOREIGN KEY(user_id) REFERENCES users(id),
        FOREIGN KEY(product_id) REFERENCES products(id)
      )
    ''');
  }


  Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    return await db.insert('products', product,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }

  Future<int> clearProducts() async {
    final db = await database;
    return await db.delete('products');
  }


  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await database;
    final result =
        await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) return result.first;
    return null;
  }


  Future<int> addToCart(int userId, int productId, int quantity) async {
    final db = await database;
    return await db.insert('cart', {
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCart(int userId) async {
    final db = await database;
    return await db.query('cart', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<int> clearCart(int userId) async {
    final db = await database;
    return await db.delete('cart', where: 'user_id = ?', whereArgs: [userId]);
  }
}
