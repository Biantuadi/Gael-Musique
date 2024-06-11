import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget{
  final VoidCallback onTap;
  final Widget child;
  final Size size;
  const CustomOutlinedButton({Key? key, required this.onTap, required this.child, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side:  const BorderSide(
          width: 1,
          color: ThemeVariables.primaryColor,),
      padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
      maximumSize: size,
      minimumSize: size,
      shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusSizeDefault)))),
        child: Center(
          child: child,
        )
    );
  }

}