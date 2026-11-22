
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/data/dummy.dart';
import 'package:item_details_app/providers/meal_state_provider.dart';
import 'package:item_details_app/widget/meal_cards.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 1000 ? 4 : width >= 650 ? 3 : 2;
    final favoriteIds = ref.watch(favoriteMealIdsProvider);
    final meals = dummyMeals.where((meal) => favoriteIds.contains(meal.id)).toList();

    if (meals.isEmpty) {
      return  Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite_border, size: 72, color: Colors.grey),
              SizedBox(height: 16),
              Text('No favorite meals yet'),
              SizedBox(height: 8),
              Text('Tap the heart icon on a meal to save it.'),
            ],
          ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'),
        backgroundColor: Color(0xFFB71C1C),
        foregroundColor: Colors.white,),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: GridView.builder(
            padding: EdgeInsets.all(width >= 650 ? 24 : 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: 205,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: meals.length,
            itemBuilder: (_, index) => MealCards(meal: meals[index]),
          ),
        ),
      ),
    );
  }
}
