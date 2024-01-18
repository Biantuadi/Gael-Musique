import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileOption(label: 'Déconnexion', iconData: Iconsax.logout4, voidCallback: () =>logoutBottomSheet(),),
            ProfileOption(label: 'A propos', iconData: Iconsax.info_circle, voidCallback: () {  },),


          ],
        ),
      ),
    );
  }
  logoutBottomSheet(){
    showCustomBottomSheet(context: context, content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Voulez-vous vous déconnecter?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
            child: Row(
              children: [
                const Icon(Iconsax.close_circle),
                SizedBox(width: Dimensions.spacingSizeDefault,),
                Text("Non",  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        const Divider(color: Colors.white, thickness: 0.2, height: 0.5,),
        InkWell(
          onTap: (){
            Provider.of<AuthProvider>(context, listen: false).logOut();
            Navigator.pushNamedAndRemoveUntil(context, Routes.landingScreen, (route) => false);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault),
            child: Row(
              children: [
                const Icon(Iconsax.logout),
                SizedBox(width: Dimensions.spacingSizeDefault,),
                Text("Oui", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    ), );
  }
}