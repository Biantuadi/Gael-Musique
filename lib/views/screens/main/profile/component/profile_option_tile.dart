import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget{
  final String label;
  final VoidCallback voidCallback;
  final IconData iconData;
  const ProfileOption({super.key, required this.label, required this.iconData, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>voidCallback(),
      child: Container(
        padding: EdgeInsets.all(Dimensions.spacingSizeDefault * 0.7),
        margin: EdgeInsets.symmetric(vertical :Dimensions.spacingSizeExtraSmall),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
        ),
        child: Row(
         children: [
           Icon(iconData, color: Colors.white,),
           SizedBox(width: Dimensions.spacingSizeDefault,),
           Text(label, style: Theme.of(context).textTheme.titleSmall,),

         ],
        ),
      ),
    );
  }

}