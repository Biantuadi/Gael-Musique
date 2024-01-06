import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class StreamingFilter extends StatelessWidget{
  final String title;
  final bool? isSelected;
  final VoidCallback onTap;
  const StreamingFilter({super.key, required this.title, required this.onTap,  this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Dimensions.spacingSizeDefault),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraLarge),
      ),
      child: InkWell(
        onTap: ()=>onTap(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.spacingSizeSmall,
            vertical: Dimensions.spacingSizeExtraSmall * 1.5
          ),
          decoration: BoxDecoration(
            gradient:isSelected==true?ThemeVariables.primaryGradient : null,
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraLarge),
            border: isSelected==true? null: const Border.fromBorderSide(BorderSide(color: Colors.grey))
          ),
          child: Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: isSelected==true?Colors.black : Colors.grey, fontWeight: FontWeight.w600),),
        ),
      ),
    );
  }
}