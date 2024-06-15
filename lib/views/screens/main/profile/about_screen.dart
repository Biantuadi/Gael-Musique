import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/launch_url.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget{
  const AboutScreen({super.key});

  @override
  AboutScreenState createState()=> AboutScreenState();
}
class AboutScreenState extends State<AboutScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("A propos", style: Theme.of(context).textTheme.titleMedium,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gael Music", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 40),),
              SizedBox(height: Dimensions.spacingSizeSmall,),
              Text(
                  """Le groupe évangélique est fondé en 1998 avec Alain Moloto et Franck Mulaja ainsi que des artistes de l'I.N.A. (Institut National des Arts) à Kinshasa au Congo-Kinshasa, soit Bibiche Mulaja, Anna Muyansi, Hugo Mbunga, Rachel Mpaka, Franck Mulaja, Henri-Papa Mulaja, Depaul Mulaja, Willy Kabamba, Douceur Mulongo, Athoms Mbuma, Nadège Mbuma Impote, Junior Biantuadi, Tempo Bilongo, Faustin Ngono, Blaise Mikanda, Francis Nsemi, Trésor Biantuadi, Mireille Basirwa, Lydie Lusamba, John Mwaka, Korino Sandjomb, Anne Keps, Marthe Bulay, Christian Mvuanda, Israël Longo, Hugo Mbunga, Serge Cibuyi, Serge Tabu, Krystel Nsaraza, Clovis Santu et Robert Ngoy
              """,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: Dimensions.spacingSizeDefault,),
              Text("Vos données", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 40),),
              SizedBox(height: Dimensions.spacingSizeSmall,),
              Text(
                """Vos données, telles que votre nom, votre numéro , votre addresse mail, vos achats via m'application ne seront partagées avec aucun service tiers.
              """,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: Dimensions.spacingSizeSmall,),
              Text('Contactez les développeurs', style:Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) ,),
              SizedBox(height: Dimensions.spacingSizeSmall,),
              TextButton(
                  onPressed: ()async{
                    try{
                      final Uri emailLauncherUri = Uri(scheme: 'mailto', path: "giftbundjoko1963@gmail.com", queryParameters: {
                        'subject': "Contact from gael app",
                        'body': ""
                      });
                      await launchUrl(emailLauncherUri);
                    }catch (e){
                      print(e);
                    }
                    launchAUrl("");
                  },
                  child: Text('- Don De Dieu Bundjoko', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ThemeVariables.primaryColor),)
              ),
              TextButton(
                  onPressed: ()async{
                    try{
                      final Uri emailLauncherUri = Uri(scheme: 'mailto', path: "benibiantuadi@gmail.com", queryParameters: {
                        'subject': "Contact from gael app",
                        'body': ""
                      });
                      await launchUrl(emailLauncherUri);
                    }catch (e){
                      print(e);
                    }
                    launchAUrl("");
                  },
                  child: Text('- Kévin Biantuadi', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ThemeVariables.primaryColor),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}