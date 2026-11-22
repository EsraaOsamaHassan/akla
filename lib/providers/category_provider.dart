
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/models/category.dart';

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, Category?>(
      SelectedCategoryNotifier.new,
    );

class SelectedCategoryNotifier extends Notifier<Category?> {
  @override
  Category? build() => null;

  void select(Category? category) => state = category;
}
