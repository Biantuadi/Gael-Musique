

import 'package:Gael/data/models/podcast_model.dart';
import 'package:Gael/data/models/radio_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class RadioWidget extends StatelessWidget{
  final RadioModel radio;

  const RadioWidget({super.key, required this.radio});
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
                child: NetWorkImageWidget(imageUrl: radio.cover, size: size,)),
            IconButton(onPressed: (){}, icon: Icon(radio.isFavorite(user: user)? Iconsax.heart5 : Iconsax.heart4,color: (radio.isFavorite(user: user)? ThemeVariables.primaryColor : Colors.white ))),
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(radio.title, style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(
                    width: size.width,
                    child: Text(radio.description, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,)),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}