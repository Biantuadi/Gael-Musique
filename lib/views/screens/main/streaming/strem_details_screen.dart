import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class StreamingDetailsScreen extends StatefulWidget{
  final Streaming streaming;
  const StreamingDetailsScreen({super.key, required this.streaming});
  @override
  StreamingDetailsScreenState createState()=>StreamingDetailsScreenState();
}
class StreamingDetailsScreenState extends State<StreamingDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    String title = widget.streaming.isEmission==true? "Emission":  widget.streaming.isPodcast==true? 'Podcast' : widget.streaming.isRadio==true? "Radio": "Stream";
   return Scaffold(
     appBar: AppBar(
       backgroundColor: ThemeVariables.thirdColorBlack,
       leading: IconButton(onPressed: (){
         Navigator.pop(context);
       },icon: const Icon(Iconsax.arrow_left, color: Colors.white,),),
       title: Text("Playing", style: Theme.of(context).textTheme.titleMedium,),
       centerTitle: true,
     ),
     body: Center(
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             AssetImageWidget(imagePath: Assets.splashBgJPG, size: Size(size.width * 0.6, size.width *0.8)),
             SizedBox(height: Dimensions.spacingSizeSmall,),
             Text('papa Alain moloto', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
             Text(title, style: Theme.of(context).textTheme.titleSmall,),
             SizedBox(height: Dimensions.spacingSizeSmall,),
             SvgPicture.asset(Assets.mediaSonSVG, width: size.width * 0.8,),
             SizedBox(height: Dimensions.spacingSizeDefault,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 IconButton(
                   onPressed: () {
                   },
                   icon: Icon(
                     CupertinoIcons.chevron_left,
                     size: Dimensions.iconSizeDefault,
                     //color: Colors.red,
                   ),
                 ),

                 IconButton(
                   color: ThemeVariables.primaryColor,
                   onPressed: () {

                   },
                   icon: Icon(
                     CupertinoIcons.play_circle_fill,
                     size: Dimensions.iconSizeExtraLarge * 2,
                     //color: Colors.red,
                   ),
                 ),
                 IconButton(
                   onPressed: (){
                   },
                   icon: Icon(
                     CupertinoIcons.right_chevron,
                     size: Dimensions.iconSizeDefault,
                     //color: repeatSong? Colors.red : null,
                   ),
                 ),
               ],
             )
           ],
         ),
       ),
     ),
   );
  }

}