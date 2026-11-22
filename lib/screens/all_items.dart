
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/data/dummy.dart';
import 'package:item_details_app/providers/category_provider.dart';
import 'package:item_details_app/providers/search_provider.dart';
import 'package:item_details_app/widget/category_list.dart';
import 'package:item_details_app/widget/meal_cards.dart';
import 'package:item_details_app/widget/search_bar.dart';

class AllItems extends ConsumerWidget {
  const AllItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 1000 ? 4 : width >= 650 ? 3 : 2;
    final selectedCategory =
        ref.watch(selectedCategoryProvider);

    final searchText = ref.watch(searchProvider);

    final meals = dummyMeals.where((meal) {
      final matchesSearch =
          meal.title.toLowerCase().contains(
                searchText.toLowerCase(),
              );

      final matchesCategory =
          selectedCategory == null ||
              meal.categories.contains(
                selectedCategory.id,
              );

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Items',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor:
            const Color(0xFFB71C1C),

        foregroundColor: Colors.white,

      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: EdgeInsets.all(width >= 650 ? 24 : 16),
            child: Column(
          children: [
            CustomSearchBar(
              onChanged:
                  ref.read(searchProvider.notifier).search,
            ),

            const SizedBox(height: 16),

            const CategoryList(),

            const SizedBox(height: 16),

            Expanded(
              child: meals.isEmpty
                  ? const Center(
                      child: Text(
                        'No meals found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: meals.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisExtent: 205,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),

                      itemBuilder:
                          (context, index) {
                        final meal =
                            meals[index];

                        return MealCards(
                          meal: meal,
                        );
                      },
                    ),
            ),
            ],
          ),
        ),
          ),
      ),
    );
  }
}
