import 'package:Gael/utils/auth_validators/email_validator.dart';
import 'package:Gael/utils/auth_validators/phone_validator.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/string_extensions.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'components/country_widget.dart';

class RegisterConfigScreen extends StatefulWidget{
  const RegisterConfigScreen({super.key});

  @override
  RegisterConfigScreenState createState()=>RegisterConfigScreenState();
}
class RegisterConfigScreenState extends State<RegisterConfigScreen> {
  final formKey = GlobalKey<FormState>();
  String phone = "";
  String email = "";
  String countrySearchKey = "";

  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).setInitialCountry();
    super.initState();
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
                                      prefixIcon: IconButton(
                                        onPressed: (){
                                          showCustomBottomSheet(
                                              context: context,
                                              content: SizedBox(
                                                height: size.height * .9,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("Sélectionnez votre pays", style: Theme.of(context).textTheme.titleSmall,),
                                                        IconButton(onPressed: (){
                                                          Navigator.pop(context);
                                                        }, icon: const Icon(CupertinoIcons.xmark))
                                                      ],
                                                    ),
                                                    CustomTextField(
                                                      controller: TextEditingController(),
                                                      initialValue: provider.countrySearchKey,
                                                      onChanged: (value) {
                                                        provider.setCountrySearchKey(value);
                                                      }, hintText: 'Votre pays',
                                                    ),
                                                    SizedBox(height: Dimensions.spacingSizeDefault,),
                                                    const Expanded(child:  CountriesWidget())
                                                  ],
                                                ),
                                              )
                                          );
                                        },
                                        icon: Text(provider.countryFlag),
                                      ),
                                      controller: TextEditingController(),
                                      onChanged: (value) {
                                        setState(() {
                                          phone = value;
                                        });
                                      }, hintText: '834 363 363',
                                      validator: (value)=>validatePhoneNumber(value: value),
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
                                    provider.setRegisterInfo(email: email, phone: provider.countryCode + phone);
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

  void getPhoneNumber(String phoneNumber) async {
    //PhoneNumber number =
   // await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {

    });
  }

}