import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/database.dart';
import '../model/category.dart';
import '../model/period.dart';
import '../model/payment_method.dart';

class CategoriesNotifier extends AsyncNotifier<List<CategoryModel>> {
  @override
  Future<List<CategoryModel>> build() async {
    return await fetchTable('categories', CategoryModel.fromJson);
  }
}

final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<CategoryModel>>(() {
  return CategoriesNotifier();
});

final periodsProvider = FutureProvider((ref) async {
  return await fetchTable('periods', PeriodModel.fromJson);
});

final paymentMethodsProvider = FutureProvider((ref) async {
  return await fetchTable('payment_methods', PaymentMethodModel.fromJson);
});
