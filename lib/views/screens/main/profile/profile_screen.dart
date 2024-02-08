
import 'dart:io';

import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'component/profile_option_tile.dart';
import 'component/user_cart_widget.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
   Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                        Container(
                          padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width / 3,
                                height: size.width / 3,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    imageFile == null?
                                    NetWorkImageWidget(imageUrl: provider.userProfileUrl!, size: Size(size.width / 3 , size.width/3),) :

                                    ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),child: Image.file(imageFile!, width:size.width/3, height: size.width/3, fit: BoxFit.cover,),),

                                    IconButton(onPressed: (){
                                      sourceBottomSheet();
                                    }, icon:  Icon(Iconsax.edit, color: Colors.white, size: Dimensions.iconSizeSmall,))
                                  ],
                                ),
                              ),
                              SizedBox(width: Dimensions.spacingSizeDefault,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${provider.userFirstName??'firstname'} ${provider.userName??'lastname'}" , style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1), overflow: TextOverflow.ellipsis,),
                                    Text(provider.userEmail??'email' , style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
                                    Text(provider.userPhone??'phone' , style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey,),),
                                    SizedBox(height: Dimensions.spacingSizeSmall,),
                                    GradientButton(onTap: (){
                                      Navigator.pushNamed(context, Routes.infoUpdateScreen);
                                    }, size: Size(size.width/5, 40), child: Text("Modifier", style: Theme.of(context).textTheme.bodySmall,))
                                      
                                  ],
                                ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(color: Colors.white, height: 0.4, thickness: .1,),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                       Text("Mon Dashboard", style: Theme.of(context).textTheme.titleMedium,),
                        SizedBox(height: Dimensions.spacingSizeSmall,),

                        Center(
                          child: Wrap(

                            children: [
                              UserCartWidget(title: 'Mes payements', svgFile: Assets.payment, onTap: (){
                                Navigator.pushNamed(context, Routes.paymentScreen);
                              },),
                              UserCartWidget(title: 'Mes favoris', svgFile: Assets.favorite,onTap: (){
                                Navigator.pushNamed(context, Routes.favoritesScreen);
                              }),
                              UserCartWidget(title: 'Mes enseignements', svgFile: Assets.course,onTap: (){
                                Navigator.pushNamed(context, Routes.coursesScreen);
                              }),
                              UserCartWidget(title: 'Mes Events', svgFile: Assets.event,onTap: (){
                                Navigator.pushNamed(context, Routes.userEventScreen);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom:Dimensions.spacingSizeDefault,
                        left:Dimensions.spacingSizeDefault,
                        right:Dimensions.spacingSizeDefault,
                    ),
                      child: Column(
                        children: [
                          ProfileOption(label: 'Paramètres', iconData: Iconsax.setting, voidCallback: () {
                            Navigator.pushNamed(context, Routes.settingsScreen);
                          },),
                          ProfileOption(label: 'Déconnexion', iconData: Iconsax.logout4, voidCallback: () =>logoutBottomSheet(),),
                        ],
                      )),

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
      //Navigator.pop(context);
    }
  }
  sourceBottomSheet(){
    showCustomBottomSheet(context: context, content: Column(
      children: [
        InkWell(
          onTap: (){
            pickImageFromSource(ImageSource.camera).then((value){
              Navigator.pop(context);
            });
          },
          child: Container(
            padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
            child: Row(
              children: [
                const Icon(Iconsax.camera, color: Colors.white,),
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
            pickImageFromSource(ImageSource.gallery).then((value){
              Navigator.pop(context);
            });
          },
          child: Container(
            padding: EdgeInsets.all(Dimensions.spacingSizeDefault),

            child: Row(
              children: [
                const Icon(CupertinoIcons.device_phone_portrait, color: Colors.white,),
                SizedBox(width: Dimensions.spacingSizeDefault,),
                Text("Téléphone", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        imageFile != null?
        Column(
          children: [
            const Divider(color: Colors.white, thickness: 0.2, height: 0.5,),
            InkWell(
              onTap: (){
                setState(() {
                  imageFile = null;
                });
              },
              child: Container(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),

                child: Row(
                  children: [
                    const Icon(Iconsax.box_remove, color: Colors.white,),
                    SizedBox(width: Dimensions.spacingSizeDefault,),
                    Text("Supprimer", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ): const SizedBox(height: 0,)
      ],
    ), );
  }
  logoutBottomSheet(){
    Size size = MediaQuery.sizeOf(context);
    showCustomBottomSheet(context: context, content: Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Voulez-vous vous déconnecter?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
          SizedBox(height: Dimensions.spacingSizeLarge,),
          Row(
            children: [
      
              GradientButton(onTap: (){
                Provider.of<AuthProvider>(context, listen: false).logOut();
                Navigator.pushNamedAndRemoveUntil(context, Routes.landingScreen, (route) => false);
              },
               size: Size(size.width / 5, 50), child: Text("Oui", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white), )),
              SizedBox(width: Dimensions.spacingSizeDefault,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
                  child: Text("Non",  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
                ),
              ),
      
            ],
          )
        ],
      ),
    ), );
  }
    

}
