import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../constants/currencies.dart';
import '../constants/cetegories.dart';
import '../model/currency.dart';
import '../model/category.dart';

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
    await _createCurrencyTable(db);
    await _createCategoriesTable(db);
  }

  Future readTable(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final Database db = await instance.database;

    final List<Map<String, dynamic>> list = await db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );

    return list;
  }
}

Future _createCurrencyTable(Database db) async {
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

Future _createCategoriesTable(Database db) async {
  const String createTable = '''
    CREATE TABLE category (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
    ''';
  await db.execute(createTable);

  for (final cat in Categories.values) {
    await db.insert('category', {"name": categoryMap[cat]});
  }
}

List<Map<String, dynamic>> _initCurrencies() {
  final List<CurrencyModel> list = [];
  for (final currency in Currencies.values) {
    list.add(CurrencyModel(
      symbol: NumberFormat.simpleCurrency(name: currency.name).currencySymbol,
      code: currency.name,
      name: currencyName[currency]!,
    ));
  }

  return list.map((e) => e.toJson()).toList();
}

Future<List<CurrencyModel>> fetchAllCurrencies() async {
  final DatabaseHelper db = DatabaseHelper.instance;
  final List<Map<String, dynamic>> list = await db.readTable('currency');

  return list.map((json) => CurrencyModel.fromJson(json)).toList();
}

Future<List<CategoryModel>> fetchAllCategories() async {
  final DatabaseHelper db = DatabaseHelper.instance;
  final List<Map<String, dynamic>> list = await db.readTable('category');

  return list.map((json) => CategoryModel.fromJson(json)).toList();
}
