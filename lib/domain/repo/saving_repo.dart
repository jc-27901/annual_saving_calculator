import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/saving_entities.dart';
import '../entities/withdrawal_entity.dart';

interface class SavingsRepository {
  late final Database _database;
  static const String savingsTable = 'savings';
  static const String withdrawalsTable = 'withdrawals';
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
    await _database.insert(savingsTable, savings.toMap());
  }

  Future<void> insertWithdrawal(Withdrawal withdrawal) async {
    await _database.insert(withdrawalsTable, withdrawal.toMap());
  }

  Future<List<Savings>> getSavings() async {
    final List<Map<String, dynamic>> maps = await _database.query(savingsTable);
    return List.generate(maps.length, (i) => Savings.fromMap(maps[i]));
  }

  Future<List<Withdrawal>> getWithdrawals() async {
    final List<Map<String, dynamic>> maps =
        await _database.query(withdrawalsTable);
    return List.generate(maps.length, (i) => Withdrawal.fromMap(maps[i]));
  }

  Future<void> clearData() async {
    await _database.delete(savingsTable);
    await _database.delete(withdrawalsTable);
  }
}
