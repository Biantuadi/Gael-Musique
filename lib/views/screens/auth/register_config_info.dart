import 'package:Gael/utils/auth_validators/email_validator.dart';
import 'package:Gael/utils/auth_validators/phone_validator.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/string_extensions.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:countries_info/countries_info.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class RegisterConfigScreen extends StatefulWidget{
  const RegisterConfigScreen({super.key});

  @override
  RegisterConfigScreenState createState()=>RegisterConfigScreenState();
}
class RegisterConfigScreenState extends State<RegisterConfigScreen> {
  final formKey = GlobalKey<FormState>();
  String phone = "";
  String email = "";
  Countries countries = Countries();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    countries.all().forEach((element) {
    });

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
                                //Center(child: Image.asset(Assets.logoPNG, width: size.width/4,)),
                                SizedBox(height: Dimensions.spacingSizeLarge,),
                                Text(
                                  "Salut, ${provider.registerModel.firstName} ${provider.registerModel.lastName}".capitalize(),
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, height: 1, ),
                                ),
                                SizedBox(height: Dimensions.spacingSizeSmall,),
                                Text(
                                  "Configurons vos informations",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, height: 1),
                                ),
                                SizedBox(height: Dimensions.spacingSizeLarge * 2,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Numéro de téléphone", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                    SizedBox(height: Dimensions.spacingSizeSmall,),
                                    CustomTextField(
                                      controller: TextEditingController(),
                                      textInputType: TextInputType.phone,
                                      onChanged: (value) {
                                        setState(() {
                                          phone = value;
                                        });
                                      }, hintText: '+243 820 000 000',
                                      validator:(value)=> validatePhoneNumber(value: value),
                    
                                    ),
                                    SizedBox(height: Dimensions.spacingSizeDefault,),
                                    Text("Email", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                                    SizedBox(height: Dimensions.spacingSizeSmall,),
                                    CustomTextField(
                                      controller: TextEditingController(),
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      }, hintText: 'Athomsmbuma@gmail.com',
                                      validator: (value)=>validateEmail(value),
                                    ),
                    
                                  ],
                                ),
                                SizedBox(height: Dimensions.spacingSizeLarge,),
                                GradientButton(onTap: (){
                                  if (formKey.currentState!.validate()) {
                                    provider.setRegisterInfo(email: email, phone: phone);
                                    Navigator.pushNamed(context, Routes.registerPasswordConfigScreen);
                                  }
                                }, size: size, child: Text("Continuer", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))
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