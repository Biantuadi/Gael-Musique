import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/chat_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/images/image_base64_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserWidget extends StatelessWidget{
  final User user;
  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        await Provider.of<ChatProvider>(context, listen: false).createChat(
            user1: Provider.of<AuthProvider>(context, listen: false).user!.id,
            user2: user.id,).then(
            (value){
              Chat? chat = value;
              Navigator.pushNamed(context, Routes.chatDetailScreen, arguments: chat);
            }
        );

      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.spacingSizeSmall
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Base64ImageWidget(base64String: user.profileImage, size: Size(Dimensions.iconSizeExtraLarge * 1.2, Dimensions.iconSizeExtraLarge*1.2), radius: Dimensions.radiusSizeExtraSmall,),
            SizedBox(width: Dimensions.spacingSizeSmall,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${user.firstName} ${user.lastName}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(),),
                SizedBox(width: Dimensions.spacingSizeExtraSmall,),
                Text("${user.email} ", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

}