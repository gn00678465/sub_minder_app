import 'dart:convert';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../constants/currencies.dart';
import '../constants/categories.dart';
import '../constants/periods.dart';
import '../constants/payment_methods.dart';
import '../model/currency.dart';
import '../model/settings.dart';
import '../utils/string.dart';

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
    if (version == 1) {
      await _createCurrencyTable(db);
      await _createCategoriesTable(db);
      await _createPeriodsTable(db);
      await _createPaymentTable(db);
      await _createNotificationTable(db);
      await _createSubscribeTable(db);
      // await _createSettingsTable(db);
    }
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

/// Create currency table
Future _createCurrencyTable(Database db) async {
  const String createCurrencyTable = '''
    CREATE TABLE currencies (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      symbol TEXT NOT NULL,
      code TEXT NOT NULL
    )
    ''';
  await db.execute(createCurrencyTable);

  final List<Map<String, dynamic>> initialData = _initCurrencies();

  for (final data in initialData) {
    await db.insert('currencies', data);
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

/// Create category table
Future _createCategoriesTable(Database db) async {
  const String createTable = '''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
    ''';
  await db.execute(createTable);

  for (final cat in Categories.values) {
    await db.insert('categories', {"name": categoryMap[cat]});
  }
}

/// 取得 table 資料並轉換為 list
Future<List<T>> fetchTable<T>(
    String tableName, T Function(Map<String, dynamic>) cb) async {
  final DatabaseHelper db = DatabaseHelper.instance;
  final List<Map<String, dynamic>> list = await db.readTable(tableName);

  return list.map(cb).toList();
}

/// Create period table
Future _createPeriodsTable(Database db) async {
  const String createTable = '''
    CREATE TABLE periods (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
    ''';

  await db.execute(createTable);

  for (final period in Periods.values) {
    await db.insert('periods', {"name": period.name.capitalize()});
  }
}

/// Create payment table
Future _createPaymentTable(Database db) async {
  const String createTable = '''
  CREATE TABLE payment_methods (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    icon TEXT NOT NULL
  )
  ''';

  await db.execute(createTable);

  for (final payment in PaymentMethods.values) {
    if (paymentMethodMap.containsKey(payment)) {
      await db.insert('payment_methods', paymentMethodMap[payment]!);
    }
  }
}

// Create notifications table
Future _createNotificationTable(Database db) async {
  const String createTable = '''
  CREATE TABLE notifications (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    days INTEGER NOT NULL
  )
''';
  await db.execute(createTable);

  for (var i = 1; i <= 7; i++) {
    if (i != 1) {
      await db.insert('notifications', {"name": "$i days before", "days": i});
    } else {
      await db.insert('notifications', {"name": "$i day before", "days": i});
    }
  }
}

/// Create subscribe table
Future _createSubscribeTable(Database db) async {
  const String createTable = '''
  CREATE TABLE subscribes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  category_id INTEGER NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id),
  currency_id INTEGER NOT NULL,
  FOREIGN KEY (currency_id) REFERENCES currencies(id),
  price INTEGER NOT NULL,
  FOREIGN KEY (payment_id) REFERENCES payment_methods(id),
  auto_subscribe INTEGER NOT NULL,
  period_id INTEGER NOT NULL,
  FOREIGN KEY (period_id) REFERENCES periods(id),
  next_payment REAL NOT NULL,
  notification_id INTEGER NOT NULL,
  FOREIGN KEY (period_id) REFERENCES notifications(id),
  create_at REAL NOT NULL,
  note TEXT
)
''';
  await db.execute(createTable);
}

/// Create settings table
Future _createSettingsTable(Database db) async {
  const String createTable = '''
  CREATE TABLE settings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    data JSON NOT NULL
  )
''';
  await db.execute(createTable);

  await db.insert('settings', {
    "name": "notification",
    "data": jsonEncode(
        const NotificationSettings(days: 1, enabled: false).toJson()),
  });
  await db.insert('settings', {
    "name": "display",
    "data": jsonEncode(const DisplaySettings(darkMode: false).toJson()),
  });
}
