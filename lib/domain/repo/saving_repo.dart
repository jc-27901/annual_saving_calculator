import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/saving_entities.dart';
import '../entities/withdrawal_entity.dart';

class SavingsRepository {
  late Database _database;

  Future<void> initializeDB() async {
    String path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'savings.db'),
      onCreate: (database, version) async {
        await database.execute(
          """CREATE TABLE savings(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            date TEXT,
            compA REAL,
            compB REAL
          )""",
        );
        await database.execute(
          """CREATE TABLE withdrawals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            date TEXT,
            component TEXT
          )""",
        );
      },
      version: 1,
    );
  }

  Future<void> insertSavings(Savings savings) async {
    await _database.insert('savings', savings.toMap());
  }

  Future<void> insertWithdrawal(Withdrawal withdrawal) async {
    await _database.insert('withdrawals', withdrawal.toMap());
  }

  Future<List<Savings>> getSavings() async {
    final List<Map<String, dynamic>> maps = await _database.query('savings');
    return List.generate(maps.length, (i) => Savings.fromMap(maps[i]));
  }

  Future<List<Withdrawal>> getWithdrawals() async {
    final List<Map<String, dynamic>> maps = await _database.query('withdrawals');
    return List.generate(maps.length, (i) => Withdrawal.fromMap(maps[i]));
  }
}