import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(FlowerShopApp());
}

class FlowerShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Çiçek Dükkanı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'flowers2.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE flowers (
            id INTEGER PRIMARY KEY,
            name TEXT,
            price REAL,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getFlowers() async {
    final db = await database;
    return await db.query('flowers');
  }

  Future<void> insertFlower(String name, double price, String imageUrl) async {
    final db = await database;
    await db.insert(
      'flowers',
      {'name': name, 'price': price, 'image': imageUrl},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

