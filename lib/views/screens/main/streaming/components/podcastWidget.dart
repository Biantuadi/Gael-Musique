

import 'package:Gael/data/models/podcast_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class PodcastWidget extends StatelessWidget{
  final Podcast podcast;

  const PodcastWidget({super.key, required this.podcast});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    Size size = Size(screenSize.width *0.8, screenSize.width *2);
    User user =   Provider.of<AuthProvider>(context, listen: false).user!;

    return InkWell(
      onTap: (){
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
                child: NetWorkImageWidget(imageUrl: podcast.cover, size: size,)),
            IconButton(onPressed: (){}, icon: Icon(podcast.isFavorite(user: user)? Iconsax.heart5 : Iconsax.heart4,color: (podcast.isFavorite(user: user)? ThemeVariables.primaryColor : Colors.white ))),
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(podcast.title, style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(
                    width: size.width,
                    child: Text(podcast.description, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,)),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}