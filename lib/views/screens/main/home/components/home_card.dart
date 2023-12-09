import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

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
            horizontal :Provider.of<ThemeProvider>(context, listen: false).spacingSizeSmall,
            vertical :Provider.of<ThemeProvider>(context, listen: false).spacingSizeDefault,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Provider.of<ThemeProvider>(context, listen: false).radiusSizeSmall),
          color: ThemeVariables.iconInactive.withOpacity(0.2)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(iconData, color: ThemeVariables.primaryColor,size:Provider.of<ThemeProvider>(context, listen: false).iconSizeSmall),
            Container(
              width: width / 2,
              alignment: Alignment.center,
              child:Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
            ),
            Icon(Iconsax.arrow_right_34, color: Colors.white, size:Provider.of<ThemeProvider>(context, listen: false).iconSizeSmall ,)
          ],
        ),
      ),
    );
  }
  
}