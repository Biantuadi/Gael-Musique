import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget{
  final String label;
  final String info;
  const UserInfoTile({super.key,required this.info, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(label, style: Theme.of(context).textTheme.titleSmall,),
         SizedBox(height: Dimensions.spacingSizeSmall*.5,),
         Text(info, style: Theme.of(context).textTheme.bodySmall,),
         SizedBox(height: Dimensions.spacingSizeDefault,)
       ],
    );
  }

}