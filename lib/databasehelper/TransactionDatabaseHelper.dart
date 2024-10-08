import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Model/TransactionModel.dart';

class TransactionDatabaseHelper {
  static final TransactionDatabaseHelper _instance = TransactionDatabaseHelper._internal();
  static Database? _database;

  TransactionDatabaseHelper._internal();

  // Factory constructor to return the singleton instance
  factory TransactionDatabaseHelper() {
    return _instance;
  }

  // Method to get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, we create it
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, place TEXT, totalAmount TEXT, date TEXT, icon TEXT, color TEXT)',
        );
      },
    );
  }
  // Fetch all transactions from the database

  Future<List<TransactionModel>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> transactionMaps = await db.query('transactions');

    // Convert each map to a TransactionModel
    return List.generate(transactionMaps.length, (i) {
      return TransactionModel.fromMap(transactionMaps[i]);
    });
  }

}
