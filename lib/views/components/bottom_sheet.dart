import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

void showCustomBottomSheet({required BuildContext context,required Widget content, Color? bgColor}) {
  Size size =  MediaQuery.sizeOf(context);
  showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    context: context,
    elevation: 10,
    backgroundColor: Colors.transparent,
    barrierColor: ThemeVariables.thirdColorBlack.withOpacity(0.5),
    clipBehavior: Clip.antiAlias,

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
              children: [
                Container(
                    width: size.width,
                    padding: EdgeInsets.only(
                        top:Dimensions.spacingSizeDefault,
                        left:Dimensions.spacingSizeDefault,
                        right:Dimensions.spacingSizeDefault,
                      bottom: MediaQuery.of(context).viewInsets.bottom
                    ),
                    margin: EdgeInsets.all(Dimensions.spacingSizeDefault),
                    decoration: BoxDecoration(
                      color: bgColor??Colors.black,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault ),
                    ),
                    child: content),
              ],
            );
          });
    },
  );
}