import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../constants/currencies.dart';
import '../model/currency.dart';

class DatabaseHelper {
  static const String _dbName = "Database.db";

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(
    Database db,
    int version,
  ) async {
    await _createCurrencyTable(db, version);
  }
}

Future _createCurrencyTable(
  Database db,
  int version,
) async {
  const String createCurrencyTable = '''
    CREATE TABLE currency (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      symbol TEXT NOT NULL,
      code TEXT NOT NULL
    )
    ''';
  await db.execute(createCurrencyTable);

  final List<Map<String, dynamic>> initialData = _initCurrencies();

  for (final data in initialData) {
    await db.insert('currency', data);
  }
}

List<Map<String, dynamic>> _initCurrencies() {
  final List<Currency> list = [];
  for (final currency in Currencies.values) {
    list.add(Currency(
      symbol: NumberFormat.simpleCurrency(name: currency.name).currencySymbol,
      code: currency.name,
      name: currencyName[currency]!,
    ));
  }

  return list.map((e) => e.toJson()).toList();
}

Future<List<Currency>> fetchAllCurrencies() async {
  final Database db = await DatabaseHelper.instance.database;

  final List<Map<String, dynamic>> list = await db.query('currency');

  return list.map((json) => Currency.fromJson(json)).toList();
}
