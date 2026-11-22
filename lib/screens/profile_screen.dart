
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:item_details_app/providers/category_provider.dart';
import 'package:item_details_app/providers/demo_session.dart';
import 'package:item_details_app/providers/meal_state_provider.dart';
import 'package:item_details_app/providers/nav_bar_provider.dart';
import 'package:item_details_app/providers/search_provider.dart';
import 'package:item_details_app/screens/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = DemoSession.displayName;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundColor: Color(0xFFB71C1C),
          child: Icon(
            Icons.person,
            size: 48,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          userName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 28),

        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Delivery addresses'),
                onTap: () {},
              ),

              const Divider(height: 1),

              const ListTile(
                leading: Icon(Icons.receipt_long_outlined),
                title: Text('Order history'),
              ),

              const Divider(height: 1),

              const ListTile(
                leading: Icon(Icons.payment_outlined),
                title: Text('Payment methods'),
              ),

              const Divider(height: 1),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  DemoSession.clear();
                  ref.read(favoriteMealIdsProvider.notifier).clear();
                  ref.read(cartProvider.notifier).clear();
                  ref.read(searchProvider.notifier).search('');
                  ref.read(selectedCategoryProvider.notifier).select(null);
                  ref.read(navBarProvider.notifier).selectPage(0);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
