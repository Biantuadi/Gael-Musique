import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserCartWidget extends StatelessWidget{
  final String title;
  final String svgFile;
  const UserCartWidget({super.key, required this.title, required this.svgFile});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
              child: Image.asset(svgFile, width:size.width/3, height: size.width/3, fit: BoxFit.cover,)
          ),
          SizedBox(height: Dimensions.spacingSizeSmall,),
          SizedBox(
          width: size.width/3,
              child: Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,))

        ],
      ),
    );
  }
}