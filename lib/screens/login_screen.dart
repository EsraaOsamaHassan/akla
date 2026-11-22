
import 'package:flutter/material.dart';
import 'package:item_details_app/theme/app_colors.dart';
import 'package:item_details_app/widget/food_background.dart';
import 'package:item_details_app/widget/login_form.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final formWidth = size.width >= 528 ? 480.0 : size.width - 48;

    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.dark,
                  AppColors.primary,
                  AppColors.accent,
                ],
              ),
            ),
          ),

          FoodBackground(
            height: height * 0.47,
          ),

          Positioned(
            top: height * 0.40,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: FoodClipper(),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(
                  25,
                  70,
                  25,
                  20,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: formWidth,
                    child: const SingleChildScrollView(
                      child: LoginForm(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 55);

    path.quadraticBezierTo(
      size.width * 0.20,
      0,
      size.width * 0.45,
      40,
    );

    path.quadraticBezierTo(
      size.width * 0.72,
      85,
      size.width,
      25,
    );

    path.lineTo(
      size.width,
      size.height,
    );

    path.lineTo(
      0,
      size.height,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(
    CustomClipper<Path> oldClipper,
  ) {
    return false;
  }
}
