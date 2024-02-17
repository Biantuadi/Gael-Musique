import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetScreen extends StatefulWidget{
  const NoInternetScreen({super.key});

  @override
  NoInternetScreenState createState()=>NoInternetScreenState();
}
class NoInternetScreenState extends State<NoInternetScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Aucune connexion internet", style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: Dimensions.spacingSizeDefault,),
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
              child: SvgPicture.asset(Assets.noInternet, width: size.width, height: size.width * 3/4, fit: BoxFit.cover,),
            ),
            GradientButton(onTap: (){

            }, size: Size(size.width/4, 50),
                child: Text("Rafraîchir",style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
  
}