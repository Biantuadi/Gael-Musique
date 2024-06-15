import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/chat_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/components/images/image_base64_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AssistanceScreen extends StatefulWidget{
  const AssistanceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AssistanceScreenState();
  }

}

class AssistanceScreenState extends State<AssistanceScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer2<AuthProvider, ChatProvider>(builder: (context, authProvider, chatProvider, child){
      return Scaffold(
        appBar:  AppBar(
          leading:  SizedBox(
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Iconsax.arrow_left),
            ),
          ),
          title: Row(
            children: [
              Container(
                width: Dimensions.iconSizeExtraLarge * 1.2  ,
                height: Dimensions.iconSizeExtraLarge * 1.2,
                padding: EdgeInsets.all(Dimensions.spacingSizeExtraSmall),
                margin: EdgeInsets.only(right: Dimensions.spacingSizeDefault),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.iconSizeExtraLarge * 1.2),
                    border: Border.all(color: Colors.white)
                ),
                alignment: Alignment.center,
                child: const Icon(Iconsax.user),
              ),

              Text("Gael", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
            ],
          )
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
               SliverList.list(children: [])
              ],
            ),
            Positioned(
                child: Container(
                  padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * .75,
                        child: CustomTextField(
                            onChanged: (value){},
                            hintText: 'votre message'),
                      ),
                      InkWell(
                        onTap: (){},
                        child:Container(
                          padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                              color: ThemeVariables.primaryColor
                            ),
                            child: Icon(Iconsax.send1)),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      );
    });
  }
}