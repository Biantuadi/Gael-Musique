import 'dart:io';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/validators/email_validator.dart';
import 'package:Gael/utils/validators/password_validator.dart';
import 'package:Gael/utils/validators/phone_validator.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/custom_snackbar.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/components/images/image_base64_widget.dart';
import 'package:Gael/views/components/images/image_file_widget.dart';
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
  String? name = "";
  String? firstName = "";
  String? password = "";
  String? oldPassword = "";
  String? email = "";
  String? phone = "";

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

                            Base64ImageWidget(base64String: provider.userProfileUrl!, size: Size(size.width , size.height/4),),
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
    if((name != "" && name != null) || (firstName != "" && firstName != null)){
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
              updateAvatar();
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
              updateAvatar();
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
      content:Consumer<AuthProvider>(builder: (BuildContext ctx, provider, child){
        return  Container(
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
                            initialValue: provider.user!.firstName,
                            onChanged: (value) {
                              firstName = value;
                            }, hintText: 'user firstname',
                          ),
                          SizedBox(height: Dimensions.spacingSizeDefault,),
                          Text("Nom", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                          SizedBox(height: Dimensions.spacingSizeSmall,),
                          CustomTextField(
                            initialValue: provider.user!.lastName,
                            onChanged: (value) {
                              name = value;
                            }, hintText: 'user lastname',

                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.spacingSizeLarge,),
                      GradientButton(onTap: (){
                        if (personalFormKey.currentState!.validate()) {
                          provider.setUpdateUpdateNames(lastName: name, firstName: firstName);
                          if(provider.userUpdate.id != null && (name != "" || firstName != "" )){
                            provider.updateUser(successCallBack: (){
                              ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "informations mises à jour avec succès", context: context, bgColor: Colors.green));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, errorCallback: (){
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(customSnack(text:Provider.of<AuthProvider>(context, listen: false).userUpdateError?? "une erreur s'est produite", context: context, bgColor: Colors.red));
                            });
                          }
                          else{
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "Veillez insérer les informations pour continuer", context: context, bgColor: Colors.red));
                          }
                        }
                      }, size: size, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.isLoading? Container(
                            padding: EdgeInsets.only(right: Dimensions.spacingSizeDefault),
                            child: SizedBox(
                              width: Dimensions.iconSizeExtraSmall,
                              height: Dimensions.iconSizeExtraSmall,
                              child: const CircularProgressIndicator(color: Colors.black,),
                            ),
                          ): const SizedBox(width: 0,),
                          Text("Mettre à jour", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }), );
  }
  updateAccountInfo(){
    Size size = MediaQuery.sizeOf(context);
    final personalFormKey = GlobalKey<FormState>();
    showCustomBottomSheet(
      context: context,
      content: Consumer<AuthProvider>(builder: (BuildContext ctx, provider, child){
        return Container(
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
                          initialValue: provider.user!.email,
                          onChanged: (value) {
                            email = value;
                          }, hintText: 'E-mail@gmail.com',
                          validator:email != "" || email != null? (value)=>validateEmail(value):null,
                        ),
                        SizedBox(height: Dimensions.spacingSizeDefault,),
                        Text("Téléphone", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                        CustomTextField(
                          textInputType: const TextInputType.numberWithOptions(decimal: false,),
                          initialValue: provider.user!.phone,
                          onChanged: (value) {
                            phone = value;
                          }, hintText: '00 243 826 037 382 ',
                          validator:phone != "" || phone != null? (value)=>validatePhoneNumber(value: value): null,

                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.spacingSizeLarge,),
                    GradientButton(onTap: (){
                      if (personalFormKey.currentState!.validate()) {
                       if(email != null || phone != null){
                         email = email != "" ? email : null;
                         phone = phone != "" ? phone : null;
                         provider.setUpdateInfo(email: email, phone: phone);
                         provider.updateUser(successCallBack: (){
                           ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "informations mises à jour aavec succès", context: context, bgColor: Colors.green));
                           Navigator.pop(context);
                           Navigator.pop(context);
                         }, errorCallback: (){
                           Navigator.pop(context);
                           ScaffoldMessenger.of(context).showSnackBar(customSnack(text: Provider.of<AuthProvider>(context, listen: false).userUpdateError?? "une erreur s'est produite", context: context, bgColor: Colors.red));
                         });
                       }
                       else{
                         Navigator.pop(context);
                         ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "Vous devez insérer de nouvelles informations pour continuer", context: context, bgColor: Colors.red));
                       }

                      }
                    }, size: size, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        provider.isLoading? Container(
                          padding: EdgeInsets.only(right: Dimensions.spacingSizeDefault),
                          child: SizedBox(
                            width: Dimensions.iconSizeExtraSmall,
                            height: Dimensions.iconSizeExtraSmall,
                            child: const CircularProgressIndicator(color: Colors.black, strokeWidth: 1,),
                          ),
                        ): const SizedBox(width: 0,),
                        Text("Mettre à jour", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        );
      }), );
  }
  updatePassword(){
    Size size = MediaQuery.sizeOf(context);
    final personalFormKey = GlobalKey<FormState>();
    showCustomBottomSheet(
      context: context,
      content: Consumer<AuthProvider>(builder: (BuildContext ctx, provider, child){
        return Container(
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
                        Text("Ancien mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                        CustomTextField(
                          onChanged: (value) {
                            oldPassword = value;
                          }, hintText: '******',
                          //validator: (value)=>validatePassword(value),
                        ),
                        SizedBox(height: Dimensions.spacingSizeDefault,),
                        Text("Nouveau mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                        CustomTextField(
                          onChanged: (value) {
                            password = value;
                          }, hintText: '******',
                          validator: (value)=>validatePassword(value),
                        ),
                        Text("Confirmez le mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                        CustomTextField(
                          textInputType: TextInputType.text,
                          onChanged: (value) {
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
                       if(oldPassword != null && password != null){
                         provider.updateUserPassword(
                             successCallBack: (){
                               ScaffoldMessenger.of(context).showSnackBar(customSnack(text: 'Mot de passse mis à jour avec succès!', context: context));
                               Navigator.pop(context);
                               Navigator.pop(context);
                             },
                             errorCallback: (){
                               Navigator.pop(context);
                               ScaffoldMessenger.of(context).showSnackBar(customSnack(text: provider.userUpdateError?? "une erreur s'est produite", context: context, bgColor: Colors.red));
                             },
                             passwordMap: {
                               "oldPassword": oldPassword!,
                               "newPassword": password!
                             });
                       }
                       else{
                         Navigator.pop(context);
                         ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "Vous devez insérer le mot de passe pour continuer", context: context, bgColor: Colors.red
                         ));
                       }
                        //Navigator.pushNamed(context, Routes.registerInfoConfigScreen);
                      }
                    }, size: size, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        provider.isLoading? Container(
                          padding: EdgeInsets.only(right: Dimensions.spacingSizeDefault),
                          child: SizedBox(
                            width: Dimensions.iconSizeExtraSmall,
                            height: Dimensions.iconSizeExtraSmall,
                            child: const CircularProgressIndicator(color: Colors.black, strokeWidth: 1,),
                          ),
                        ): const SizedBox(width: 0,),
                        Text("Mettre à jour", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        );
      }), );
  }
  updateAvatar(){
    Size size = MediaQuery.sizeOf(context);
    showCustomBottomSheet(context: context, content:Consumer<AuthProvider>(builder: (BuildContext ctx, provider, child){
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nouvel avatar", style: Theme.of(context).textTheme.titleSmall,),
          SizedBox(height: Dimensions.spacingSizeDefault,),
          FileImageWidget(imagePath: imageFile!.path, size: Size(size.width, size.height / 4),),
          SizedBox(height: Dimensions.spacingSizeDefault,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton(onTap: (){
                if(!provider.isLoading){
                  provider.updateUserAvatar(successCallBack: (){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "Avatar mise à jour avec succès", context: context, bgColor: Colors.green));

                  }, errorCallback: (){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(customSnack(text: provider.avatarUpdateError??"une erreur s'est produite, veillez réessayer plus tard", context: context, bgColor: Colors.red));
                  }, avatar: imageFile!);
                }
              }, size: Size(size.width / 3, 50),
                bgColor: provider.isLoading? Colors.grey :null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    provider.isLoading? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: Dimensions.spacingSizeSmall),
                            width:Dimensions.iconSizeExtraSmall,
                            height: Dimensions.iconSizeExtraSmall,
                            child:  const CircularProgressIndicator(strokeWidth: 1, color: Colors.black,))
                      ],
                    ):const SizedBox(),
                    Text("Mettre à jour", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(width: Dimensions.spacingSizeDefault,),
              TextButton(onPressed: (){
                setState(() {
                  imageFile = null;
                  Navigator.pop(context);

                });
              }, child: Text("Annuler", style: Theme.of(context).textTheme.titleSmall))
            ],
          ),
          SizedBox(height: Dimensions.spacingSizeDefault,),

        ],
      );
    }));
  }
}