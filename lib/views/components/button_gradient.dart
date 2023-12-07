import 'package:Gael/utils/routes/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.homeScreen);
      },
      child: Container(
        width: width * 0.34,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [ThemeVariables.primaryColor, ThemeVariables.secondaryColor],
          ),
        ),
        child: const Center(
          child: Text(
            'Press me',
            style: TextStyle(
              color: ThemeVariables.backgroundBlack,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
