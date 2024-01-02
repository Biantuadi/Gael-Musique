import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/auth_validators/password_validator.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/custom_snackbar.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
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
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  "${provider.registerInfo['firstName']} ${provider.registerInfo['name']},",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                                ),

                                Text(
                                  "${provider.registerInfo['email']}",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                                ),
                                SizedBox(height: Dimensions.spacingSizeSmall,),
                                Text(
                                  "C'est le moment de sécuriser votre compte!",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                ),
                                SizedBox(height: Dimensions.spacingSizeLarge,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Entrez un mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                    SizedBox(height: Dimensions.spacingSizeSmall,),
                                    CustomTextField(
                                      controller: TextEditingController(),
                                      isForPassword: true,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      }, hintText: '**********',
                                      validator:(value)=> validatePassword(value),
                                    ),
                                    SizedBox(height: Dimensions.spacingSizeDefault,),
                                    Text("Confirmez le mot de passe", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                    SizedBox(height: Dimensions.spacingSizeSmall,),
                                    CustomTextField(
                                      controller: TextEditingController(),
                                      isForPassword: true,
                                      onChanged: (value) {
                                        confirmPassword = value;
                                      }, hintText: '**************',
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
                                SizedBox(height: Dimensions.spacingSizeLarge,),
                                GradientButton(onTap: (){

                                  if (formKey.currentState!.validate()) {
                                    if(conditionsAccepted){
                                      Navigator.pushNamedAndRemoveUntil(context, Routes.registerProfileConfigScreen, (route) => false);
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(customSnack(text: "Vous devez accepter les conditions avant de continuer", context: context, bgColor: Colors.red));
                                    }
                                  }
                                }, size: size, child: Text("Créer le compte", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))
                              ],
                            ),
                          ),
                        )


                      ],
                    ),
                  );
                }
              ),
            ),

          ],
        ),
      ),
    );
  }
}