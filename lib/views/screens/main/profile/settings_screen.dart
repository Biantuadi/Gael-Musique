import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'component/profile_option_tile.dart';

class SettingsScreen extends StatefulWidget{
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState()=> SettingsScreenState();
}
class SettingsScreenState extends State<SettingsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("Paramètres", style: Theme.of(context).textTheme.titleMedium,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
          child: Column(
            children: [
              ProfileOption(label: 'Déconnexion', iconData: Iconsax.logout4, voidCallback: () =>logoutBottomSheet(),),
              ProfileOption(label: 'A propos', iconData: Iconsax.info_circle, voidCallback: () {
                Navigator.pushNamed(context, Routes.aboutScreen);
              },),
          
          
            ],
          ),
        ),
      ),
    );
  }
  logoutBottomSheet(){
    Size size = MediaQuery.sizeOf(context);
    showCustomBottomSheet(context: context, content: Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Voulez-vous vous déconnecter?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
          SizedBox(height: Dimensions.spacingSizeDefault,),
          Row(
            children: [
              GradientButton(onTap: (){
                Provider.of<AuthProvider>(context, listen: false).logOut();
                Navigator.pushNamedAndRemoveUntil(context, Routes.landingScreen, (route) => false);
              },
                  size: Size(size.width / 5, 50), child: Text("Oui", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white), )),
              SizedBox(width: Dimensions.spacingSizeDefault,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
                  child: Text("Non",  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
                ),
              ),

            ],
          )
        ],
      ),
    ), );
  }
}