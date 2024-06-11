import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';


SnackBar customSnack({required String text,required BuildContext context, Color? bgColor}){
  return  SnackBar(
    content: Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
    backgroundColor:bgColor??Colors.black,
    behavior: SnackBarBehavior.floating,
    shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
    ),
  );
}