import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/get_formatted_duration.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget{
 final  Event event;

  const EventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.spacingSizeDefault),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetWorkImageWidget(imageUrl:event.image , size: Size(size.width/3, size.width/3),),
              SizedBox(width: Dimensions.spacingSizeDefault,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
                    SizedBox(height: Dimensions.spacingSizeDefault,),
                    Text(event.description, style: Theme.of(context).textTheme.bodyMedium,),
                    Text(getFormattedDate(event.datetime), style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}