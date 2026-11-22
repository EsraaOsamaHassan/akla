
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/data/dummy.dart';
import 'package:item_details_app/providers/category_provider.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    final categoryList = categories;

    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: categoryList.length + 1,
        itemBuilder: (context, index) {
          final category = index == 0 ? null : categoryList[index - 1];

          final isSelected = category?.id == selectedCategory?.id;

          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              onTap: () {
                ref.read(selectedCategoryProvider.notifier).select(category);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFB71C1C)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category == null
                          ? Icons.restaurant_menu
                          : Icons.fastfood_rounded,
                      size: 17,
                      color: isSelected
                          ? Colors.white
                          : Colors.black87,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      category?.title ?? 'All',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
