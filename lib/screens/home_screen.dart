

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/data/dummy.dart';
import 'package:item_details_app/providers/category_provider.dart';
import 'package:item_details_app/providers/demo_session.dart';
import 'package:item_details_app/providers/nav_bar_provider.dart';
import 'package:item_details_app/providers/search_provider.dart';
import 'package:item_details_app/screens/all_items.dart';
import 'package:item_details_app/screens/cart_screen.dart';
import 'package:item_details_app/screens/favorites_screen.dart';
import 'package:item_details_app/screens/meal_detail_screen.dart';
import 'package:item_details_app/screens/profile_screen.dart';
import 'package:item_details_app/widget/category_list.dart';
import 'package:item_details_app/widget/meal_cards.dart';
import 'package:item_details_app/widget/nav_bar.dart';
import 'package:item_details_app/widget/search_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class MyHomeScreen extends ConsumerWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWide = MediaQuery.sizeOf(context).width >= 700;
    final searchText = ref.watch(searchProvider);
    final selectedIndex = ref.watch(navBarProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    final userName = DemoSession.displayName;

    final meals = dummyMeals.where((meal) {
      return selectedCategory == null ||
          meal.categories.contains(selectedCategory.id);
    }).toList();

    final searchResults = searchText.trim().isEmpty
        ? []
        : dummyMeals.where((meal) {
            return meal.title.toLowerCase().contains(
                  searchText.toLowerCase(),
                );
          }).toList();

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isWide ? 24 : 12),
                  child: SingleChildScrollView(
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isWide ? 32 : 24),

                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFB71C1C),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $userName',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                          ),

                          Text(
                            'Choose your meals',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  CustomSearchBar(
                    onChanged: (value) {
                      ref.read(searchProvider.notifier).search(value);
                    },
                  ),

                  if (searchText.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        maxHeight: 280,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: searchResults.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'No meals found',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: searchResults.length,
                              separatorBuilder: (_, __) {
                                return const Divider(
                                  height: 1,
                                );
                              },
                              itemBuilder: (context, index) {
                                final meal = searchResults[index];

                                return ListTile(
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),

                                  leading: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                    child: FadeInImage(
                                      placeholder: MemoryImage(
                                        kTransparentImage,
                                      ),
                                      image: NetworkImage(
                                        meal.imageUrl,
                                      ),
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  title: Text(
                                    meal.title,
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  subtitle: Text(
                                    '\$${meal.price}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFB71C1C),
                                    ),
                                  ),

                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey,
                                  ),

                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            MealDetail(meal),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],

                  const SizedBox(height: 15),

                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/images/deals.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(20),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const DiscountsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Order Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const CategoryList(),

                  const SizedBox(height: 15),

                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Our Meals',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                          ),

                          const Spacer(),

                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AllItems(),
                                ),
                              );
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Color(0xFFB71C1C),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 205,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: meals.map((meal) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                right: 10,
                              ),
                              child: MealCards(
                                meal: meal,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const FavoritesScreen(),
          const CartScreen(),
          const ProfileScreen(),
        ],
      ),

      bottomNavigationBar: NavBar(),
    );
  }
}

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discounts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFB71C1C),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Discounts',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
