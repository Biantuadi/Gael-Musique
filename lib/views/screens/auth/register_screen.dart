import 'package:Gael/utils/auth_validators/string_validator.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/button_gradient.dart';
import 'package:Gael/views/components/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState()=>RegisterScreenState();
}
class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  String firstName = "";
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

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                         canPop();
                        }, icon: const Icon(Iconsax.arrow_left, color: Colors.white,))
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                      width: size.width,
                      child:    Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: formKey,
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
                            Image.asset(Assets.logoPNG, width: size.width/4,),
                            SizedBox(height: Dimensions.spacingSizeDefault,),
                            Text(
                              "Register",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: Dimensions.spacingSizeSmall,),
                            Text(
                              "Faisons connaissance!",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: Dimensions.spacingSizeLarge,),
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

                              if (formKey.currentState!.validate()) {
                                Provider.of<AuthProvider>(context, listen: false).setNames(name: name, firstName: firstName);
                                Navigator.pushNamed(context, Routes.registerInfoConfigScreen);
                              }
                            }, size: size, child: Text("Continuer", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    )


                  ],
                ),
              ),
            ),
            Positioned(
                bottom: size.height * 0.000,
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.07,
                  color: Colors.black.withOpacity(0.6),
                  child: RichText(
                    text: TextSpan(
                        text: "Vous avez déjà un compte?",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                        children: [
                          TextSpan(
                            text: " Connectez-vous",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushNamed(
                                  context, Routes.loginScreen),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ))
          ],
        ),
      ),
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
}