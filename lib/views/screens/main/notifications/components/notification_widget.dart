import 'package:Gael/data/models/notification_model.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel notification;

  const NotificationWidget({super.key, required this.notification});
  @override
  NotificationWidgetState createState()=>NotificationWidgetState();
}
class NotificationWidgetState extends State<NotificationWidget>{
  bool showAll = false;
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        setState(() {
          widget.notification.read = true;
          showAll = !showAll;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeSmall),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
            color: widget.notification.read ? Colors.transparent : ThemeVariables.thirdColorBlack.withOpacity(0.1)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.notification.imgUrl != null?
            NetWorkImageWidget(
              imageUrl: widget.notification.imgUrl!, size: Size(Dimensions.iconSizeExtraLarge,Dimensions.iconSizeExtraLarge),
            ) : Container(
              padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                border: Border.all(color: Colors.white, width: 0.4)
              ),child: const Icon(Iconsax.notification, color: Colors.white,),
            ),
            SizedBox(
              width: Dimensions.spacingSizeSmall,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.notification.title, style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(
                  height: Dimensions.spacingSizeExtraSmall,
                ),
                Text(widget.notification.message, style: Theme.of(context).textTheme.bodySmall, maxLines:showAll?null: 2,),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
