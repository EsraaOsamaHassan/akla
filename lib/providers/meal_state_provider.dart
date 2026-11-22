
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/models/meal.dart';

final favoriteMealIdsProvider =
    NotifierProvider<FavoriteMealsNotifier, Set<String>>(
      FavoriteMealsNotifier.new,
    );

class FavoriteMealsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => const {};

  void toggle(Meal meal) {
    final updatedFavorites = {...state};
    if (!updatedFavorites.add(meal.id)) {
      updatedFavorites.remove(meal.id);
    }
    state = updatedFavorites;
  }

  void clear() => state = const {};
}

final cartProvider = NotifierProvider<CartNotifier, Map<String, int>>(
  CartNotifier.new,
);

class CartNotifier extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() => const {};

  void add(Meal meal) {
    state = {
      ...state,
       meal.id: (state[meal.id] ?? 0) + 1};
  }

  void removeOne(Meal meal) {
    final quantity = state[meal.id] ?? 0;
    if (quantity <= 1) {
      state = {...state}..remove(meal.id);
      return;
    }
    state = {...state, meal.id: quantity - 1};
  }

  void clear() => state = const {};
}
