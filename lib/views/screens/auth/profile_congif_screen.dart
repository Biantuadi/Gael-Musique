import 'dart:io';

import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/string_extensions.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class ProfileConfigScreen extends StatefulWidget {
  const ProfileConfigScreen({super.key});

  @override
  ProfileConfigScreenState createState() => ProfileConfigScreenState();
}

class ProfileConfigScreenState extends State<ProfileConfigScreen> {
  XFile? xImageFile;
  File? imageFile;
  ImagePicker imagePicker = ImagePicker();

  pickImageFromSource(ImageSource imageSource)async{
      xImageFile = await imagePicker.pickImage(source: imageSource);
      final file = xImageFile;
      if(xImageFile != null){
       setState(() {
         imageFile = File(file!.path);
       });
        // ignore: use_build_context_synchronously

      }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.1,
              child: Image.asset(
                Assets.loginBg,
                width: size.width,
                height: size.height,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: Consumer<AuthProvider>(
                  builder: (BuildContext context, provider, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                        width: size.width,
                        child:   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize : MainAxisSize.max,
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize : MainAxisSize.max,
                                children: [
                                  Image.asset(Assets.logoPNG, width: size.width/4,),
                                  SizedBox(height: Dimensions.spacingSizeDefault,),
                                  Stack(
                                    alignment : Alignment.bottomRight,
                                    children: [
                                      imageFile == null?
                                      Container(
                                        width : size.width / 2.5,
                                        height : size.width / 2.5,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(size.width / 2.5),
                                            color: Colors.white.withOpacity(0.1)
                                        ),
                                        child: Icon(Iconsax.user, size: size.width / 4,),
                                      ):
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(size.width / 2.5),
                                        child: Image.file(imageFile!,  width : size.width / 2.5,height : size.width / 2.5, fit: BoxFit.cover,),
                                      ),
                                      IconButton(onPressed: ()=>sourceBottomSheet(), icon: const Icon(Iconsax.edit), highlightColor: Colors.white10,)
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.spacingSizeSmall,),
                                  Text(
                                    "${provider.registerModel.firstName}".capitalize()+" ${provider.registerModel.lastName}".capitalize(),
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                  ),
                                  const Divider(color: Colors.white,),
                                  SizedBox(height: Dimensions.spacingSizeSmall,),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.spacingSizeLarge,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                SizedBox(height: Dimensions.spacingSizeSmall,),
                                Text("${provider.registerModel.email}".capitalize(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                SizedBox(height: Dimensions.spacingSizeDefault,),
                                Text("Téléphone", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                SizedBox(height: Dimensions.spacingSizeSmall,),
                                Text("${provider.registerModel.phone}".capitalize(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold))

                              ],
                            ),
                            SizedBox(height: Dimensions.spacingSizeLarge,),
                            GradientButton(onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);

                            }, size: size, child: Text("continuer", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))
                          ],
                        )
                      )


                    ],
                  );
                }
              ),
            ),

          ],
        ),
      ),
    );
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
            pickImageFromSource(ImageSource.gallery).then((value){
              Navigator.pop(context);
            });
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
}
