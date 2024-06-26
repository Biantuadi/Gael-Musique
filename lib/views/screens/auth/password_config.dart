import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/validators/password_validator.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/string_extensions.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/custom_snackbar.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/components/overlay_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';


class PasswordConfigScreen extends StatefulWidget{
  const PasswordConfigScreen({super.key});
  @override
  PasswordConfigScreenState createState()=>PasswordConfigScreenState();
}
class PasswordConfigScreenState extends State<PasswordConfigScreen> {
  final formKey = GlobalKey<FormState>();
  String password = "";
  String confirmPassword = "";
  bool conditionsAccepted = false;
  @override
  void initState() {

    super.initState();
    Provider.of<AuthProvider>(context, listen: false).nullAuthVars();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer<AuthProvider>(builder: (ctx, provider, child){
        return SafeArea(
          child: Stack(
            children: [
              Stack(
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

                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: const Icon(Iconsax.arrow_left, color: Colors.white,))
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                            width: size.width,
                            child:    Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Image.asset(Assets.logoPNG, width: size.width/4,),
                                  //SizedBox(height: Dimensions.spacingSizeLarge * 2,),
                                  Text(
                                    "${"${provider.registerModel.firstName}".capitalize()} ${"${provider.registerModel.lastName}".capitalize()},",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                                  ),

                                  Text(
                                    "${provider.registerModel.email}",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: Dimensions.spacingSizeDefault,),
                                  Text(
                                    "C'est le moment de sécuriser votre compte!",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: Dimensions.spacingSizeLarge * 3,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Entrez un mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                      SizedBox(height: Dimensions.spacingSizeSmall,),
                                      CustomTextField(
                                        isForPassword: true,
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        }, hintText: '********',
                                        validator:(value)=> validatePassword(value),
                                      ),
                                      SizedBox(height: Dimensions.spacingSizeDefault,),
                                      Text("Confirmez le mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                      SizedBox(height: Dimensions.spacingSizeSmall,),
                                      CustomTextField(
                                        isForPassword: true,
                                        onChanged: (value) {
                                          confirmPassword = value;
                                        }, hintText: '********',
                                        validator: (value){
                                          if(value.toString() != password){
                                            return "Les mots de passe ne correspondent pas!";
                                          }
                                        },
                                      ),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(value: conditionsAccepted, onChanged: (value){
                                        setState(() {
                                          conditionsAccepted  = value!;
                                        });
                                      }),
                                      Expanded(
                                        child: RichText(
                                          //overflow: TextOverflow.,
                                            text: TextSpan(
                                                text: "En créant le compte, vous acceptez ",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: Colors.white
                                                ),

                                                children: [
                                                  TextSpan(
                                                    text: "les conditions d'utilisation",
                                                    recognizer: TapGestureRecognizer()
                                                    // ignore: avoid_print
                                                      ..onTap = () => print('hello world'),
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                                ]
                                            )),
                                      )

                                    ],
                                  ),
                                  provider.registerError != null? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Dimensions.spacingSizeLarge,),
                                      Text(provider.registerError!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),)
                                    ],
                                  ) : const SizedBox(),
                                  SizedBox(height: Dimensions.spacingSizeLarge,),
                                  GradientButton(onTap: (){
                                    if (formKey.currentState!.validate()) {
                                      if(conditionsAccepted){
                                        provider.setRegisterPassword(password);
                                        provider.register(successCallBack: (){
                                          Navigator.pushNamedAndRemoveUntil(context, Routes.registerProfileConfigScreen, (route) => false);
                                        }, errorCallback: (){});
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "Vous devez accepter les conditions avant de continuer", context: context, bgColor: Colors.red));
                                      }
                                    }
                                  }, size: size, child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      provider.isLoading? Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(right: Dimensions.spacingSizeSmall),
                                              width:Dimensions.iconSizeExtraSmall,
                                              height: Dimensions.iconSizeExtraSmall,
                                              child:  const CircularProgressIndicator(strokeWidth: 1, color: Colors.black,))
                                        ],
                                      ):const SizedBox(),
                                      Text("Créer le compte", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          )


                        ],
                      ),
                    ),
                  ),

                ],
              ),
              provider.isLoading?  OverlayScreen(child: Column(
                children: [
                  Icon(Iconsax.emoji_happy4, size: Dimensions.iconSizeExtraLarge,),
                  SizedBox(height: Dimensions.spacingSizeDefault,),
                  const Text("Création du compte en cours!")
                ],
              )): const SizedBox()
            ],
          ),
        );
      },),
    );
  }
}