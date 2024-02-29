import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetStreamingCard extends StatelessWidget{
  final Streaming streaming;
  final double width;
  const DetStreamingCard({super.key, required this.streaming, required this.width});
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: (){
       Provider.of<StreamingProvider>(context, listen: false).setCurrentStreaming(streaming);
     },
     child: Container(
       padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
       margin: EdgeInsets.only(left :Dimensions.spacingSizeSmall),
       decoration: BoxDecoration(
         color: ThemeVariables.iconInactive.withOpacity(0.3),
         borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
       ),
       child: Column(
         crossAxisAlignment:
         CrossAxisAlignment.start,
         children: [
       NetWorkImageWidget(imageUrl: streaming.cover, size: Size(width,width *.5), radius: Dimensions.radiusSizeDefault,),
           SizedBox(height: Dimensions.spacingSizeSmall,),
           Text(streaming.title, style: Theme.of(context).textTheme.titleSmall,)
         ],
       ),
     ),
   ) ;
  }
}