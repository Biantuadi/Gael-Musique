import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class OverlayScreen extends StatelessWidget{
  final Widget? child;
  const OverlayScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      color: ThemeVariables.thirdColorBlack.withOpacity(0.8),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          child ?? const Text("Requête en cours!"),
          const Text("Veillez patienter..."),
        ],
      ),
    );
  }
}