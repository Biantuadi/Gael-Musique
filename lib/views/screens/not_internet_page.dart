import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetWidget extends StatelessWidget{
  final VoidCallback voidCallback;
  const NoInternetWidget({super.key, required this.voidCallback});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Center(
        child: Column(
          children: [
            Text("Vous êtes hors ligne", style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: Dimensions.spacingSizeDefault,),
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
              child: SvgPicture.asset(Assets.noInternet, width: size.width/3,),
            ),
            GradientButton(onTap: (){
              voidCallback();
            }, size: Size(size.width/4, 50),
                child: Text("Continuer",style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      )
    ;
  }
  
}