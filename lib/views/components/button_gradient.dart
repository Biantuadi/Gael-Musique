import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final Widget child;
  const GradientButton({Key? key, required this.voidCallback, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: voidCallback,
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
        child:  Center(
          child: child,
        ),
      ),
    );
  }
}
