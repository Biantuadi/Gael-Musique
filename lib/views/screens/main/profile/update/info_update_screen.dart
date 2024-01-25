import 'dart:io';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/auth_validators/email_validator.dart';
import 'package:Gael/utils/auth_validators/password_validator.dart';
import 'package:Gael/utils/auth_validators/phone_validator.dart';
import 'package:Gael/utils/auth_validators/string_validator.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class InfoUpdateScreen extends StatefulWidget{
  const InfoUpdateScreen({super.key});

  @override
  InfoUpdateScreenState createState()=> InfoUpdateScreenState();
}
class InfoUpdateScreenState extends State<InfoUpdateScreen>{
  final formKey = GlobalKey<FormState>();
  String name = "";
  String firstName = "";
  String password = "";
  String email = "";
  String phone = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
            Navigator.pop(context);
          },),
          title: Text("Mise à jour", style: Theme.of(context).textTheme.titleMedium,),
        ),
      body: Consumer<AuthProvider>(
          builder: (BuildContext context, provider, Widget? child) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: size.width ,
                        height: size.height/4,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            imageFile == null?
                            NetWorkImageWidget(imageUrl: provider.userProfileUrl!, size: Size(size.width , size.height/4),)
:
                            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),child: Image.file(imageFile!, width:size.width, height: size.height/4, fit: BoxFit.cover),),
                            IconButton(onPressed: (){
                              sourceBottomSheet();
                            }, icon:  Icon(Iconsax.edit, color: Colors.white, size: Dimensions.iconSizeSmall,))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
                        width: size.width,
                        child:    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Informations personnelles", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),),
                                TextButton(onPressed: ()=>updatePersonalInfo()
                                , child: Text("Modifier", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),))
                              ],
                            ),
                            Text("Prénom : ${provider.userFirstName}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                            SizedBox(height: Dimensions.spacingSizeSmall,),
                            Text("Nom : ${provider.userName}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                          ],
                        ),
                      ),
                      const Divider( thickness: 0.1,),
                      Container(
                        padding: EdgeInsets.only(bottom: Dimensions.spacingSizeDefault),
                        width: size.width,
                        child:    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Informations du compte", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),),
                                TextButton(onPressed: ()=>updateAccountInfo()
                                , child: Text("Modifier", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),))
                              ],
                            ),
                            Text("Email : ${provider.userEmail}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                            SizedBox(height: Dimensions.spacingSizeSmall,),
                            Text("Téléphone : ${provider.userPhone}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                            SizedBox(height: Dimensions.spacingSizeDefault*2,),

                            GradientButton(onTap: (){
                          updatePassword();
                            }, size: size, child: Text("Mettre à jour le mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))


                          ],
                        ),
                      ),
                    ],
                  )


                ],
              ),
            ),
          );
        }
      )
    );
  }
  canPop(){
    Size size = MediaQuery.sizeOf(context);
    if(name.isNotEmpty || firstName.isNotEmpty){
      showCustomBottomSheet(content: Column(
        children: [
          Text("Les informations entrées seront perdues, voulez-vous vraiment quitter?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
          SizedBox(height: Dimensions.spacingSizeDefault,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }, child: Text("Oui",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white))),
              GradientButton(onTap: (){
                Navigator.pop(context);
              }, size: Size(50, size.width * 0.2), child: Text("Non", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),))
            ],
          )
        ],
      ), context: context);
    }else{
      Navigator.pop(context);
    }
  }
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
     // Navigator.pop(context);
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

  updatePersonalInfo(){
    Size size = MediaQuery.sizeOf(context);
    final personalFormKey = GlobalKey<FormState>();
    showCustomBottomSheet(
      context: context,
      content: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Informations personnelles", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),),
              SizedBox(height: Dimensions.spacingSizeDefault,),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: personalFormKey,
                canPop: false,
                onPopInvoked: (didPop){
                  if(didPop){
                    return;
                  }
                  canPop();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Prénom", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                        CustomTextField(
                          controller: TextEditingController(),
                          onChanged: (value) {
                            firstName = value;
                          }, hintText: 'Athoms',
                          validator: (value)=>validateName(value: value, emptyMessage: 'Le prénom est obligatoire', message: "Le prenom entré n'est pas valide"),
                        ),
                        SizedBox(height: Dimensions.spacingSizeDefault,),
                        Text("Nom", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                        CustomTextField(
                          controller: TextEditingController(),
                          onChanged: (value) {
                            // Utilize the input value here
                            // print('Search query: $value');
                            name = value;
                          }, hintText: 'Mbuma',
                          validator: (value)=>validateName(value: value, emptyMessage: 'Le nom est obligatoire', message: "Le nom entré n'est pas valide"),

                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.spacingSizeLarge,),
                    GradientButton(onTap: (){

                      if (personalFormKey.currentState!.validate()) {
                        Provider.of<AuthProvider>(context, listen: false).setRegisterNames(name: name, firstName: firstName);
                        //Navigator.pushNamed(context, Routes.registerInfoConfigScreen);
                      }
                    }, size: size, child: Text("Mettre à jour", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))
                  ],
                ),
              ),
            ],
          ),
        ),
      ), );
  }
  updateAccountInfo(){
    Size size = MediaQuery.sizeOf(context);
    final personalFormKey = GlobalKey<FormState>();
    showCustomBottomSheet(
      context: context,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Text("Informations du compte", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),),
            SizedBox(height: Dimensions.spacingSizeDefault,),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: personalFormKey,
              canPop: false,
              onPopInvoked: (didPop){
                if(didPop){
                  return;
                }
                canPop();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                      SizedBox(height: Dimensions.spacingSizeSmall,),
                      CustomTextField(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          firstName = value;
                        }, hintText: 'Athoms@gmail.com',
                        validator: (value)=>validateEmail(value),
                      ),
                      SizedBox(height: Dimensions.spacingSizeDefault,),
                      Text("Téléphone", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                      SizedBox(height: Dimensions.spacingSizeSmall,),
                      CustomTextField(
                        controller: TextEditingController(),
                        textInputType: const TextInputType.numberWithOptions(decimal: false,),
                        onChanged: (value) {
                          // Utilize the input value here
                          // print('Search query: $value');
                          name = value;
                        }, hintText: '00 243 826 037 382 ',
                        validator: (value)=>validatePhoneNumber(value: value),

                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.spacingSizeLarge,),
                  GradientButton(onTap: (){

                    if (personalFormKey.currentState!.validate()) {
                      Provider.of<AuthProvider>(context, listen: false).setRegisterNames(name: name, firstName: firstName);
                      //Navigator.pushNamed(context, Routes.registerInfoConfigScreen);
                    }
                  }, size: size, child: Text("Mettre à jour", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ],
        ),
      ), );
  }
  updatePassword(){
    Size size = MediaQuery.sizeOf(context);
    final personalFormKey = GlobalKey<FormState>();
    showCustomBottomSheet(
      context: context,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Text("Mettre à jour le mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),),
            SizedBox(height: Dimensions.spacingSizeDefault,),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: personalFormKey,
              canPop: false,
              onPopInvoked: (didPop){
                if(didPop){
                  return;
                }
                canPop();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                      SizedBox(height: Dimensions.spacingSizeSmall,),
                      CustomTextField(
                        controller: TextEditingController(),
                        onChanged: (value) {
                          //firstName = value;
                        }, hintText: '******',
                        validator: (value)=>validatePassword(value),
                      ),
                      SizedBox(height: Dimensions.spacingSizeDefault,),
                      Text("Confirmez le mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                      SizedBox(height: Dimensions.spacingSizeSmall,),
                      CustomTextField(
                        controller: TextEditingController(),
                        textInputType: TextInputType.text,
                        onChanged: (value) {
                          // Utilize the input value here
                          // print('Search query: $value');
                          name = value;
                        }, hintText: '******',
                        validator:  (value){
                          if(value.toString() != password){
                            return "Les mots de passe ne correspondent pas!";
                          }
                        },

                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.spacingSizeLarge,),
                  GradientButton(onTap: (){
                    if (personalFormKey.currentState!.validate()) {
                     // Provider.of<AuthProvider>(context, listen: false).setRegisterNames(name: name, firstName: firstName);
                      //Navigator.pushNamed(context, Routes.registerInfoConfigScreen);
                    }
                  }, size: size, child: Text("Mettre à jour", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ],
        ),
      ), );
  }
}