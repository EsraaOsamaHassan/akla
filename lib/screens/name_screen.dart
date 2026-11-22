
import 'package:flutter/material.dart';
import 'package:item_details_app/providers/demo_session.dart';
import 'package:item_details_app/screens/home_screen.dart';
import 'package:item_details_app/theme/app_colors.dart';
class ChooseNameScreen extends StatefulWidget {
  const ChooseNameScreen({super.key});

  @override
  State<ChooseNameScreen> createState() =>
      _ChooseNameScreenState();
}

class _ChooseNameScreenState
    extends State<ChooseNameScreen> {
  final nameController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> saveName() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      DemoSession.displayName = name;

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MyHomeScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save your name'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.waving_hand,
                size: 70,
                color: AppColors.primary,
              ),

              const SizedBox(height: 24),

              Text(
                "What's your name?",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              Text(
                'Tell us your name so we can personalize your experience.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nameController,
                textCapitalization:
                    TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Your name',
                  hintText: 'Esraa',
                  prefixIcon:
                      Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primary,
                  ),
                  onPressed:
                      isLoading ? null : saveName,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
