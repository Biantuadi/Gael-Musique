import 'package:Gael/utils/auth_validators/email_validator.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool showPositional = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    showPositional = !(keyBoardHeight > 0);
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(Assets.logoPNG, width: size.width/4,),
                            SizedBox(height: Dimensions.spacingSizeDefault,),
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: Dimensions.spacingSizeSmall,),
                            Text(
                              "Heureux de vous revoir!",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: Dimensions.spacingSizeLarge,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                SizedBox(height: Dimensions.spacingSizeSmall,),
                                CustomTextField(
                                  controller: TextEditingController(),
                                  onChanged: (value) {
                                    // Utilize the input value here
                                    // print('Search query: $value');
                                  }, hintText: 'Athomsmbuma@gmail.com',
                                  validator: (value)=>validateEmail(value),
                                ),
                                SizedBox(height: Dimensions.spacingSizeDefault,),
                                Text("Mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                SizedBox(height: Dimensions.spacingSizeSmall,),
                                CustomTextField(
                                  controller: TextEditingController(),
                                  onChanged: (value) {
                                    // Utilize the input value here
                                    // print('Search query: $value');
                                  }, hintText: '**********',
                                  isForPassword: true,
                                  maxLines: 1,
                                  validator: (value){
                                    if(value.toString().trim()==""){
                                      return "Le mot de passe est obligatoire";
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.spacingSizeLarge,),
                            GradientButton(onTap: (){
                            if (formKey.currentState!.validate()) {
                              Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);
                            }
                            }, size: size, child: Text("Connexion", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),)),

                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){}, child:const Text("Mot de passe oublié? "))
                      ],
                    )


                  ],
                ),
              ),
            ),
            Positioned(
                bottom: size.height * 0.000,
                child: Visibility(
                  visible: showPositional,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height * 0.07,
                    color: Colors.black.withOpacity(0.6),
                    child: RichText(
                      text: TextSpan(
                          text: "Vous n'avez pas un compte?",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                          children: [
                            TextSpan(
                              text: " Créez-en",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, Routes.registerScreen),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
