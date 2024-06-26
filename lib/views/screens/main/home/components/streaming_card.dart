import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
// import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamingCard extends StatelessWidget{
  final Streaming streaming;
  final double size;
  const StreamingCard({super.key ,required this.streaming, required this.size});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(Provider.of<StreamingProvider>(context, listen: false).currentStreaming == null){
          Provider.of<StreamingProvider>(context, listen: false).setCurrentStreaming(streaming:streaming, autoPlay: true);
        }else{
          if(streaming.id != Provider.of<StreamingProvider>(context, listen: false).currentStreaming!.id){
            Provider.of<StreamingProvider>(context, listen: false).setCurrentStreaming(streaming:streaming, autoPlay: true);
          }
        }
        Navigator.pushNamed(context, Routes.streamingDetailsScreen);

      },
      child: Container(
        //height: size * 3/2,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [
            NetWorkImageWidget(size: Size(size, size * 4/3),imageUrl : streaming.cover,),
            SizedBox(height: Dimensions.spacingSizeSmall,),
            SizedBox(
              width: size,
              child: Text(streaming.title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white), overflow: TextOverflow.clip, maxLines: 2, textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}