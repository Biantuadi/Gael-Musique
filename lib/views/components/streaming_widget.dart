import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'images/network_image_widget.dart';

class StreamingWidget extends StatelessWidget{
  final Streaming streaming;

  const StreamingWidget({super.key, required this.streaming});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    Size size = Size(screenSize.width *0.8, screenSize.width *2);

    User? user =   Provider.of<AuthProvider>(context, listen: false).user;

    return InkWell(
      onTap: (){
        if(Provider.of<StreamingProvider>(context, listen: false).currentStreaming == null){
           Provider.of<StreamingProvider>(context, listen: false).setCurrentStreaming(streaming:streaming, autoPlay: true);
           if(Provider.of<StreamingProvider>(context, listen: false).videoPlayerHasBeenInitialized){
             Navigator.pushNamed(
               context,
               Routes.streamingDetailsScreen,
             );
           }
        }else{
          if(streaming.id != Provider.of<StreamingProvider>(context, listen: false).currentStreaming!.id){
            Provider.of<StreamingProvider>(context, listen: false).setCurrentStreaming(streaming:streaming, autoPlay: true);
            if(Provider.of<StreamingProvider>(context, listen: false).videoPlayerHasBeenInitialized){
              Navigator.pushNamed(
                context,
                Routes.streamingDetailsScreen,
              );
            }

          }
        }

      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Opacity(
              opacity: .6,
                child: NetWorkImageWidget(imageUrl: streaming.cover, size: size,)),
            IconButton(
                onPressed: (){},
                icon: Icon(
                    streaming.isFavorite(user)? Iconsax.heart5 : Iconsax.heart4,color: (streaming.isFavorite(user)? ThemeVariables.primaryColor : Colors.white ))),
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(streaming.title, style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(
                  width: size.width,
                    child: Text(streaming.description, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,)),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}