
import 'dart:io';

import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'component/profile_option_tile.dart';
import 'component/user_cart_widget.dart';
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
    return SafeArea(
      child: Consumer<AuthProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return CustomScrollView(
              slivers: [
                SliverList.list(children: [
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: Dimensions.spacingSizeDefault),
                                child: Text("Profil", style: Theme.of(context).textTheme.titleMedium,)),
                            IconButton(onPressed: (){
                              logoutBottomSheet();
                            }, icon: const Icon(Iconsax.logout,))
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault),
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width / 3,
                                height: size.width / 3,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    AssetImageWidget(imagePath: Assets.avatarPNG, size: Size(size.width / 3 , size.width/3),),
                                    IconButton(onPressed: (){
                                      sourceBottomSheet();
                                    }, icon:  Icon(Iconsax.edit, color: Colors.white, size: Dimensions.iconSizeSmall,))
                                  ],
                                ),
                              ),
                              SizedBox(width: Dimensions.spacingSizeDefault,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Salut!" , style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1),),
                                  Text("${splashProvider.userFirstName??'Trésor'} ${splashProvider.userName??'Biantuadi'}" , style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1),),
                                  Text("${splashProvider.userEmail??'Trésor'} ${splashProvider.userName??'Biantuadi'}" , style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1),),
                                  Text("${splashProvider.userPhone??'Trésor'} ${splashProvider.userName??'Biantuadi'}" , style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1),),
      
                                ],
                              ),
                            ],
                          ),
      
                        ),
      
      
                      ],
                    ),
                  ),
                  Container(
                  padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                    child: Column(
                      children: [
                        CustomTextField(
                          onChanged: (value) {
                            // Utilize the input value here
                            // print('Search query: $value');
                          }, hintText: 'Recherche...',
                          prefixIcon: Icon(CupertinoIcons.search, color: Theme.of(context).primaryColor, size: Dimensions.iconSizeSmall,), controller: TextEditingController(),
                        ),
      
      
                        SizedBox(height: Dimensions.spacingSizeLarge,),
      
                        const Divider(color: Colors.white, height: 0.4, thickness: .1,),
                        Wrap(
                          children: [
                            UserCartWidget(title: 'Mes payements', svgFile: Assets.payment,),
                            UserCartWidget(title: 'Mes favoris', svgFile: Assets.favorite,),
                            UserCartWidget(title: 'Mes enseignements', svgFile: Assets.course,),
                            UserCartWidget(title: 'Events', svgFile: Assets.event,),
                          ],
                        ),
                        ProfileOption(label: 'Paramètres', iconData: Iconsax.setting, voidCallback: () {},),
                        ProfileOption(label: 'Déconnexion', iconData: Iconsax.logout4, voidCallback: () =>logoutBottomSheet(),),
                        ProfileOption(label: 'A propos', iconData: Iconsax.info_circle, voidCallback: () {  },),
                      ],
                    ),
                  ),
                  Container(
                    color: ThemeVariables.thirdColorBlack,
                    height: size.height / 3,
                  )
                ]),
      
              ],
            );
          }
      ),
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
      // ignore: use_build_context_synchronously
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
            Provider.of<AuthProvider>(context, listen: false).logOut();
            Navigator.pushNamedAndRemoveUntil(context, Routes.landingScreen, (route) => false);
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
