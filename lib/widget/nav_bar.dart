import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/providers/nav_bar_provider.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final selectedIndex = ref.watch(navBarProvider);

    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFB71C1C),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BottomNavigationBar(
          currentIndex: selectedIndex,

          onTap: ref.read(navBarProvider.notifier).selectPage,

          backgroundColor: Colors.transparent,
          elevation: 0,

          type: BottomNavigationBarType.fixed,

          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,

          showSelectedLabels: false,
          showUnselectedLabels: false,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'profile',
            ),
          ],
            ),
          ),
        ),
      ),
    );
  }
}
