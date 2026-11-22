
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/data/dummy.dart';
import 'package:item_details_app/providers/meal_state_provider.dart';
import 'package:item_details_app/theme/app_colors.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    final meals = dummyMeals
        .where((meal) => cart.containsKey(meal.id))
        .toList();

    final total = meals.fold<double>(
      0,
      (sum, meal) => sum + meal.price * cart[meal.id]!,
    );

    // Empty Cart
    if (meals.isEmpty) {
      return const _EmptyState(
        icon: Icons.shopping_cart_outlined,
        title: 'Your cart is empty',
        subtitle: 'Add meals to see them here.',
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.05;
    final bottomSafePadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),

          child: Column(
            children: [
              // Cart Items
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: meals.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),

                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    final quantity = cart[meal.id]!;

                    return Card(
                      child: ListTile(
                        // Meal Image
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            meal.imageUrl,
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,

                            errorBuilder: (_, _, _) {
                              return const SizedBox(
                                width: 54,
                                height: 54,
                                child: Icon(Icons.fastfood),
                              );
                            },
                          ),
                        ),

                        // Meal Name
                        title: Text(
                          meal.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Meal Price
                        subtitle: Text('${meal.price.toStringAsFixed(2)} EGP'),

                        // Quantity Controls
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                ref.read(cartProvider.notifier).removeOne(meal);
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: AppColors.primary,
                              ),
                            ),

                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                ref.read(cartProvider.notifier).add(meal);
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Checkout Section (Floating & Responsive)
              Container(
                margin: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  bottomSafePadding > 0 ? bottomSafePadding + 8 : 16,
                ),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  shadowColor: Colors.black.withOpacity(0.15),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                            ),
                            Text(
                              '${total.toStringAsFixed(2)} EGP',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Checkout Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              ref.read(cartProvider.notifier).clear();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Order placed successfully.'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Checkout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Empty Cart Widget
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 72, color: Colors.grey),

              const SizedBox(height: 16),

              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(subtitle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}