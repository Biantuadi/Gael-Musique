import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeCard extends StatelessWidget{
  final double width;
  final IconData iconData;
  final VoidCallback onTap;
  final String title;
  const HomeCard({super.key, required this.iconData, required this.width, required this.onTap, required this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onTap(),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal :Dimensions.spacingSizeSmall,
            vertical :Dimensions.spacingSizeDefault,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
          color: ThemeVariables.iconInactive.withOpacity(0.2)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(iconData, color: ThemeVariables.primaryColor,size:Dimensions.iconSizeSmall),
            Container(
              width: width / 2,
              alignment: Alignment.center,
              child:Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
            ),
            Icon(Iconsax.arrow_right_34, color: Colors.white, size:Dimensions.iconSizeSmall ,)
          ],
        ),
      ),
    );
  }
  
}