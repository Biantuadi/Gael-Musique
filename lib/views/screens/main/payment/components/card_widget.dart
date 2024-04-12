import 'package:Gael/data/providers/payment_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/auth_validators/card_num_validator.dart';
import 'package:Gael/utils/auth_validators/email_validator.dart';
import 'package:Gael/utils/auth_validators/phone_validator.dart';
import 'package:Gael/utils/auth_validators/string_validator.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/screens/auth/components/country_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class PaymentWidget extends StatefulWidget{
  const PaymentWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return PaymentWidgetState();
  }

}
class PaymentWidgetState extends State<PaymentWidget>{
  String? cardNumber;
  String? expireDate;
  String? cvsCode;
  String? nameOnCard;
  String? phone;
  List<String> devises = ["EURO", "USD","CDF", "CFA", ];
  String selectedDevise = "";
  @override
  void initState() {
    super.initState();
    selectedDevise = devises.first;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder:(ctx, provider, child){
      return AnimatedContainer(
        duration: const Duration(seconds: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           (provider.paymentModel.paymentMean!.isMasterCard == true || provider.paymentModel.paymentMean!.isVisa == true)?
           cardContent():
           provider.paymentModel.paymentMean?.isPaypal == true?
           payPalContent():
           phoneContent()
          ],
        ),
      );
    } );
  }
  Widget cardContent(){
    Size size = MediaQuery.sizeOf(context);
    return Consumer<PaymentProvider>(builder: (ctx, provider, child){
      return Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.width/2 + Dimensions.spacingSizeDefault,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.spacingSizeDefault),
                    color: ThemeVariables.primaryColor,
                  gradient: ThemeVariables.primaryGradient
                ),
              ),
              Container(
                height: size.width/2 + Dimensions.spacingSizeDefault,
                width: size.width,
                padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.spacingSizeDefault)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                   // provider.paymentModel.paymentMean?.isMasterCard == true?
                    Container(
                      alignment: Alignment.topLeft,
                      height: (size.width/2)/3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Débit", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.7)),),
                          const Icon(Iconsax.wallet, color: Colors.white,)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.spacingSizeDefault),
                      width: size.width *.1,
                      height: (size.width *.1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                        color: Colors.grey
                      ),
                    ),
                    SizedBox(
                      height: (size.width/2)/3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cardNumber??"0000 0000 0000 0000", style: Theme.of(context).textTheme.bodyMedium,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Expire date ${expireDate??""}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.7)),)
                            ],
                          ),
                          Text(nameOnCard??"Mr JOHN KALOMBA", ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(
                height: size.width/2 + Dimensions.spacingSizeDefault,
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                      child: Image.asset(
                        provider.paymentModel.paymentMean?.isMasterCard == true?
                        Assets.mastercardLogo :
                        Assets.visa,
                        width: size.width * .2,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: Dimensions.spacingSizeDefault,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * .7,
                child: CustomTextField(
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      cardNumber = value;
                    });
                    }, hintText: 'Numéro de la carte',
                  maxLines: 1,
                  validator: (value){
                    return validateCardNumber(value);
                  },
                ),
              ),
              SizedBox(
                width: size.width * .18,
                child: CustomTextField(
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    cardNumber = value;
                  }, hintText: 'cvs',
                  maxLines: 1,
                  maxLenght: 3,
                  validator: (value){
                    if(value == "" || value == null) return "Le code cvs est obligatoire";
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.spacingSizeDefault/2,),
          CustomTextField(
            textInputType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                nameOnCard = value;
                nameOnCard = nameOnCard!.toUpperCase();
              });
            }, hintText: 'Mr John KALOMBA',
            maxLines: 1,
            validator: (value){
              return validateName(value: value, emptyMessage: 'Le nom est obligatoire', message: 'Le nom entré semble incorrect');
            },
          ),
          SizedBox(height: Dimensions.spacingSizeDefault/2,),
          CustomTextField(
            textInputType: TextInputType.datetime,
            onChanged: (value) {
              setState(() {
                expireDate = value;
              });
            }, hintText: "Date d'expiration ( 11/24 )",
            maxLines: 1,
            validator: (value){
              return validateName(value: value, emptyMessage: 'Le nom est obligatoire', message: 'Le nom entré semble incorrect');
            },
          )
        ],
      );
    });
  }
  Widget payPalContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Adresse mail", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
        SizedBox(height: Dimensions.spacingSizeSmall,),
        CustomTextField(
          textInputType: TextInputType.phone,
          onChanged: (value) {
            setState(() {
              phone = value;
            });
          }, hintText: 'email@gmail.com',
          validator: (value)=>validateEmail(value),
        ),
      ],
    );
  }

  Widget phoneContent(){
    Size size = MediaQuery.sizeOf(context);
    return  Consumer<PaymentProvider>(builder: (ctx, provider, child){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Numéro de téléphone", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
          SizedBox(height: Dimensions.spacingSizeSmall/2,),
          CustomTextField(
            textInputType: TextInputType.phone,
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
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            }, hintText: '834 363 363',
            validator: (value)=>validatePhoneNumber(value: value),
          ),
          SizedBox(height: Dimensions.spacingSizeSmall,),
          Text("Dévise", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
            child: DropdownButton(
                padding:  EdgeInsets.symmetric(vertical:Dimensions.spacingSizeDefault),
                isExpanded :true,
                itemHeight : kMinInteractiveDimension * 1.2,
                alignment: AlignmentDirectional.bottomCenter,
                items: devises.map((devise) => DropdownMenuItem<String>(
                    value: devise,
                    child: Container(
                      margin: EdgeInsets.only(bottom: Dimensions.spacingSizeSmall),
                      padding: EdgeInsets.only(bottom: Dimensions.spacingSizeSmall),
                      child: Row(
                        children: [
                          Text(devise, style: Theme.of(context).textTheme.bodySmall,)
                        ],
                      ),
                    ))).toList(),
                value: selectedDevise,
                onChanged: (value){
                  setState(() {
                    selectedDevise =value!;
                  });
                }),
          ),

        ],
      );
    });
  }
}