import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileSwitch extends StatelessWidget{
  final String label;
  final Function onChanged;
  final bool isActive;
  final IconData iconData;
  const ProfileSwitch({super.key, required this.label, required this.isActive, required this.onChanged, required this.iconData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal:  Dimensions.spacingSizeDefault * 0.7),
      margin: EdgeInsets.symmetric(vertical :Dimensions.spacingSizeExtraSmall),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
      ),
      child: Row(
        children: [
          Icon(iconData, color: Colors.white,),
          SizedBox(width: Dimensions.spacingSizeDefault,),
          SizedBox(
            width: size.width /2 ,
              child: Text(label, style: Theme.of(context).textTheme.titleSmall,)),
          SizedBox(width: Dimensions.spacingSizeDefault,),
          Expanded(child: Switch(
              value: isActive,
              onChanged:(value)=> onChanged(value),
              activeColor: ThemeVariables.primaryColor,
          ))

        ],
      ),
    );
  }

}