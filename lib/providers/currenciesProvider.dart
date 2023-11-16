import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../services/database.dart';
import '../model/currency.dart';

class CurrenciesNotifier extends StateNotifier<List<CurrencyModel>> {
  CurrenciesNotifier() : super([]) {
    _getCurrencyList();
  }

  _getCurrencyList() async {
    try {
      final todoList = await fetchAllCurrencies();
      state = todoList;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> _hasCurrency(
      CurrencyModel currency) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'currency',
      columns: ['id'],
      where: "code = ? AND name = ?",
      whereArgs: [currency.code, currency.name],
    );
    return result;
  }

  Future<void> addCurrency(CurrencyModel currency) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final List<Map<String, dynamic>> result = await _hasCurrency(currency);
      if (result.isEmpty) {
        await db.insert(
          'currency',
          currency.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        state = [...state, currency];
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeCurrency(CurrencyModel currency) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final List<Map<String, dynamic>> result = await _hasCurrency(currency);
      if (result.isNotEmpty) {
        final int id = result[0]['id'];
        await db.delete(
          'currency',
          where: "id = ?",
          whereArgs: [id],
        );
        state = [
          for (final c in state)
            if (c != currency) c,
        ];
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}

final currenciesProvider =
    StateNotifierProvider.autoDispose<CurrenciesNotifier, List<CurrencyModel>>(
  (ref) => CurrenciesNotifier(),
);
