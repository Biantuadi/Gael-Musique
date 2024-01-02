import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

void showCustomBottomSheet({required BuildContext context,required Widget content, Color? bgColor}) {
  Size size =  MediaQuery.sizeOf(context);
  showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    context: context,
    elevation: 10,
    backgroundColor: ThemeVariables.thirdColorBlack,
    barrierColor: ThemeVariables.thirdColorBlack.withOpacity(0.5),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radiusSizeDefault),
        topRight: Radius.circular(Dimensions.radiusSizeDefault),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: <Widget>[
                Container(
                    width: size.width,
                    padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                    margin: EdgeInsets.all(Dimensions.spacingSizeDefault),
                    decoration: BoxDecoration(
                      color: bgColor??Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault ),
                    ),
                    child: content),
              ],
            );
          });
    },
  );
}