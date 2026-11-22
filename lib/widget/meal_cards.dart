
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/data/dummy.dart';
import 'package:item_details_app/models/meal.dart';
import 'package:item_details_app/providers/meal_state_provider.dart';
import 'package:item_details_app/screens/meal_detail_screen.dart';
  import 'package:transparent_image/transparent_image.dart';

class MealCards extends ConsumerWidget {
  const MealCards({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMealIdsProvider).contains(meal.id);
    final category = categories.firstWhere(
      (category) => meal.categories.contains(category.id),
    );

    return SizedBox(
      height: 175,
      width: 175,
      child: Card(
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => MealDetail(meal)),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                      meal.imageUrl,
                    ),
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    top: 5,
                    right: 5,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 17,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: const Color(0xFFB71C1C),
                        onPressed: () {
                          ref.read(favoriteMealIdsProvider.notifier).toggle(meal);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  6,
                  8,
                  0,
                ),
                child: Text(
                  meal.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  category.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: category.color,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 5,
                  top: 5,
                  bottom: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${meal.price}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB71C1C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ref.read(cartProvider.notifier).add(meal);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${meal.title} added to cart.')),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

