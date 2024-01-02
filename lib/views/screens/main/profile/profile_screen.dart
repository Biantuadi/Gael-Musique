
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'component/profile_option_tile.dart';
import 'component/user_info_tile.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
   Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SplashProvider splashProvider = Provider.of<SplashProvider>(context, listen: false);
    return Consumer<AuthProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return CustomScrollView(
            slivers: [
        
              SliverSafeArea(sliver: SliverPadding(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                sliver: SliverList.list(children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        AssetImageWidget(imagePath: Assets.avatarPNG, size: Size(size.width , size.width *.55),),
                        IconButton(onPressed: (){}, icon: const Icon(Iconsax.edit, color: Colors.white,))
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.spacingSizeDefault,),
                  Center(child: Text("${splashProvider.userFirstName??'Trésor'} ${splashProvider.userName??'Biantuadi'}" , style: Theme.of(context).textTheme.titleLarge,)),
                  SizedBox(height: Dimensions.spacingSizeLarge,),
                  const Divider(color: Colors.white, height: 0.4, thickness: .1,),
                  SizedBox(height: Dimensions.spacingSizeLarge,),
                  UserInfoTile(info: splashProvider.userFirstName??'Trésor', label: 'Prénom',),
                  UserInfoTile(info: splashProvider.userName??'Biantuadi', label: 'Nom',),
                  UserInfoTile(info: splashProvider.userEmail??'Tresor@gmail.com', label: 'Email',),
                  UserInfoTile(info: splashProvider.userPhone??'00 243 674 4477 263' , label: 'Téléphone',),
                  const Divider(color: Colors.white, height: 0.4, thickness: .1,),
                  ProfileOption(label: 'Paramètres', iconData: Iconsax.setting, voidCallback: () {  },),
                  ProfileOption(label: 'Déconnexion', iconData: Iconsax.logout4, voidCallback: () {  },),
                  ProfileOption(label: 'A propos', iconData: Iconsax.info_circle, voidCallback: () {  },),
                ]),
              ),)

            ],
          );
        }
    );
  }
}
