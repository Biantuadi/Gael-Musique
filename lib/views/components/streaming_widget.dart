import 'package:Gael/data/models/preference_model.dart';
import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StreamingWidget extends StatelessWidget{
  final Streaming streaming;

  const StreamingWidget({super.key, required this.streaming});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    Size size = Size(screenSize.width *0.8, screenSize.width *2);
    User user =   User(phone: "", firstName: "", id: "", address: "", bio: "", birthDay: DateTime.now(), createdAt: DateTime.now(), email: "", lastName: "", preferences: Preference(theme: '',language: '', notifications: true), profileImage: "", role: "");
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.streamingDetailsScreen, arguments: streaming);
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
                child: AssetImageWidget(imagePath: Assets.loginBg, size: size,)),
            IconButton(onPressed: (){}, icon: Icon(streaming.isFavorite(user: user)? Iconsax.heart : Iconsax.heart5)),
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