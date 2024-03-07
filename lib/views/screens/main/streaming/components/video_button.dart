import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class VideoButton extends StatelessWidget{
  final IconData icon;
  final String text;
  const VideoButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault, vertical: Dimensions.spacingSizeSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraLarge* 1.5),
          color: ThemeVariables.iconInactive
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: Dimensions.iconSizeSmall,),
            SizedBox(width: Dimensions.spacingSizeSmall/2,),
            Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}