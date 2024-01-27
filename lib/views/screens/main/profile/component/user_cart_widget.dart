import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';

class UserCartWidget extends StatelessWidget{
  final String title;
  final String svgFile;
  final VoidCallback onTap;
  const UserCartWidget({super.key, required this.title, required this.svgFile, required this.onTap});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap:()=>  onTap(),
      child: Container(
        padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                child: Image.asset(svgFile, width:size.width/3, height: size.width/3.5, fit: BoxFit.cover,)
            ),
            SizedBox(height: Dimensions.spacingSizeSmall,),
            SizedBox(
            width: size.width/3,
                child: Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,))

          ],
        ),
      ),
    );
  }
}