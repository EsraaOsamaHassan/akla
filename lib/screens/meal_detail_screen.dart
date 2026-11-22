
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/models/meal.dart';
import 'package:item_details_app/providers/meal_state_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetail extends ConsumerStatefulWidget {
  const MealDetail(this.meal, {super.key});

  final Meal meal;

  @override
  ConsumerState<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends ConsumerState<MealDetail> {
  int selectedIndex = 0;
  
  

  @override
  Widget build(BuildContext context ) {
    final meal = widget.meal;
    final favoriteIds = ref.watch(favoriteMealIdsProvider);
  

    final attributes = [
      meal.ingredients,
      meal.steps,
    ];

    final titles = [
      'Ingredients',
      'Steps',
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          meal.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFB71C1C),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteMealIdsProvider.notifier).toggle(meal);
            },
            icon: Icon(
              favoriteIds.contains(meal.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [

            Stack(
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  height: 330,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
               
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 100,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Transform.translate(
              offset: const Offset(0, -30),

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.fromLTRB(
                  20,
                  25,
                  20,
                  30,
                ),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      meal.title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [

                        Expanded(
                          child: _InfoCard(
                            icon: Icons.attach_money,
                            title: 'Price',
                            value: '\$${meal.price}',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _InfoCard(
                            icon: Icons.access_time,
                            title: 'Duration',
                            value: '${meal.duration} min',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 45,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,

                        itemCount: titles.length,

                        itemBuilder: (context, index) {

                          final isSelected =
                              selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },

                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 250),

                              margin: const EdgeInsets.only(
                                right: 10,
                              ),

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 10,
                              ),

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFB71C1C)
                                    : Colors.grey.shade100,

                                borderRadius:
                                    BorderRadius.circular(22),
                              ),

                              child: Text(
                                titles[index],

                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,

                                  fontSize: 15,

                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    AnimatedSwitcher(
                      duration:
                          const Duration(milliseconds: 300),

                      child: Column(
                        key: ValueKey(selectedIndex),

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          for (
                            int i = 0;
                            i < attributes[selectedIndex].length;
                            i++
                          )

                            Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom: 12,
                              ),

                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  Container(
                                    width: 28,
                                    height: 28,

                                    alignment:
                                        Alignment.center,

                                    decoration:
                                        BoxDecoration(
                                      color: const Color(
                                        0xFFB71C1C,
                                      ),

                                      shape: BoxShape.circle,
                                    ),

                                    child: Text(
                                      '${i + 1}',

                                      style:
                                          const TextStyle(
                                        color: Colors.white,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Text(
                                      attributes[
                                          selectedIndex][i],

                                      style:
                                          const TextStyle(
                                        fontSize: 16,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB71C1C),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add , size: 30,),
        onPressed: () {
          ref.read(cartProvider.notifier).add(meal);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${meal.title} added to cart.')),
          );
        },

      ),
    );
  }
}


class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFFB71C1C),
            size: 25,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
