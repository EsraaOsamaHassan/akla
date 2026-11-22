import 'package:flutter/material.dart';
import 'package:item_details_app/theme/app_colors.dart';

class FoodBackground extends StatefulWidget {
  const FoodBackground({
    super.key,
    required this.height,
  });

  final double height;

  @override
  State<FoodBackground> createState() => _FoodBackgroundState();
}

class _FoodBackgroundState extends State<FoodBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> burgerAnimation;
  late Animation<double> friesAnimation;
  late Animation<double> drinkAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    burgerAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    friesAnimation = Tween<double>(
      begin: 8,
      end: -8,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    drinkAnimation = Tween<double>(
      begin: -6,
      end: 8,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = (constraints.maxWidth / 375).clamp(0.8, 1.4);

          return Stack(
            children: [
          Positioned(
            top: 65 * scale,
            left: 28 * scale,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  'FAST',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48 * scale,
                    fontWeight: FontWeight.w900,
                    height: 0.9,
                  ),
                ),

                Text(
                  'FOOD',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 48 * scale,
                    fontWeight: FontWeight.w900,
                    height: 0.9,
                  ),
                ),

                SizedBox(height: 10 * scale),

                Text(
                  'YUMMY & FAST!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          AnimatedBuilder(
            animation: burgerAnimation,
            builder: (context, child) {
              return Positioned(
                right: -20 * scale,
                top: 80 * scale + burgerAnimation.value,
                child: child!,
              );
            },
            child: Image.asset(
              'assets/images/Burger.png',
              width: 260 * scale,
            ),
          ),

          AnimatedBuilder(
            animation: friesAnimation,
            builder: (context, child) {
              return Positioned(
                left: -15 * scale,
                top: 210 * scale + friesAnimation.value,
                child: child!,
              );
            },
            child: Image.asset(
              'assets/images/Fries.png',
              width: 110 * scale,
            ),
          ),

          AnimatedBuilder(
            animation: drinkAnimation,
            builder: (context, child) {
              return Positioned(
                right: 40 * scale,
                bottom: 25 * scale + drinkAnimation.value,
                child: child!,
              );
            },
            child: Image.asset(
              'assets/images/Drink.png',
              width: 90 * scale,
            ),
          ),
            ],
          );
        },
      ),
    );
  }
}
