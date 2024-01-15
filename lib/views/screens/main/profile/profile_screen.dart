
import 'dart:io';

import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'component/profile_option_tile.dart';
import 'component/user_info_tile.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
   Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SplashProvider splashProvider = Provider.of<SplashProvider>(context, listen: false);
    return Consumer<AuthProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return CustomScrollView(
            slivers: [
        
              SliverSafeArea(sliver: SliverPadding(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                sliver: SliverList.list(children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        AssetImageWidget(imagePath: Assets.avatarPNG, size: Size(size.width , size.width *.55),),
                        IconButton(onPressed: (){
                          sourceBottomSheet();
                        }, icon: const Icon(Iconsax.edit, color: Colors.white,))
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.spacingSizeDefault,),
                  Center(child: Text("${splashProvider.userFirstName??'Trésor'} ${splashProvider.userName??'Biantuadi'}" , style: Theme.of(context).textTheme.titleLarge,)),
                  Center(child: Text("Ma bio" , style: Theme.of(context).textTheme.bodyMedium,)),
                  SizedBox(height: Dimensions.spacingSizeLarge,),
                  const Divider(color: Colors.white, height: 0.4, thickness: .1,),
                  SizedBox(height: Dimensions.spacingSizeLarge,),
                  UserInfoTile(info: splashProvider.userFirstName??'Trésor', label: 'Prénom',),
                  UserInfoTile(info: splashProvider.userName??'Biantuadi', label: 'Nom',),
                  UserInfoTile(info: splashProvider.userEmail??'Tresor@gmail.com', label: 'Email',),
                  UserInfoTile(info: splashProvider.userPhone??'00 243 674 4477 263' , label: 'Téléphone',),
                  const Divider(color: Colors.white, height: 0.4, thickness: .1,),
                  ProfileOption(label: 'Paramètres', iconData: Iconsax.setting, voidCallback: () {},),
                  ProfileOption(label: 'Déconnexion', iconData: Iconsax.logout4, voidCallback: () =>logoutBottomSheet(),),
                  ProfileOption(label: 'A propos', iconData: Iconsax.info_circle, voidCallback: () {  },),
                ]),
              ),)

            ],
          );
        }
    );
  }
  XFile? xImageFile;
  File? imageFile;
  ImagePicker imagePicker = ImagePicker();

  pickImageFromSource(ImageSource imageSource)async{
    xImageFile = await imagePicker.pickImage(source: imageSource);
    final file = xImageFile;
    if(xImageFile != null){
      imageFile = File(file!.path);
      Navigator.pop(context);
    }
  }
  sourceBottomSheet(){
    showCustomBottomSheet(context: context, content: Column(
      children: [
        InkWell(
          onTap: (){
            pickImageFromSource(ImageSource.camera);
          },
          child: Container(
            padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
            child: Row(
              children: [
                const Icon(Iconsax.camera),
                SizedBox(width: Dimensions.spacingSizeDefault,),
                Text("Caméra",  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        const Divider(color: Colors.white, thickness: 0.2, height: 0.5,),
        InkWell(
          onTap: (){
            pickImageFromSource(ImageSource.gallery);
          },
          child: Container(
            padding: EdgeInsets.all(Dimensions.spacingSizeDefault),

            child: Row(
              children: [
                const Icon(Iconsax.image),
                SizedBox(width: Dimensions.spacingSizeDefault,),
                Text("Téléphone", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    ), );
  }
  logoutBottomSheet(){
    showCustomBottomSheet(context: context, content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Voulez-vous vous déconnecter?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
            child: Row(
              children: [
                const Icon(Iconsax.close_circle),
                SizedBox(width: Dimensions.spacingSizeDefault,),
                Text("Non",  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        const Divider(color: Colors.white, thickness: 0.2, height: 0.5,),
        InkWell(
          onTap: (){
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
            child: Row(
              children: [
                const Icon(Iconsax.logout),
                SizedBox(width: Dimensions.spacingSizeDefault,),
                Text("Oui", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    ), );
  }
}
