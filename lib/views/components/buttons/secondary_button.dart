import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Size size;
  const SecondaryButton({Key? key, required this.onTap, required this.child, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = size;
    if(screenSize.height >= 50){
      screenSize =  Size (size.width, 50);
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
          border: Border.all(color: Colors.white)
        ),
        child:  Center(
          child: child,
        ),
      ),
    );
  }
}
