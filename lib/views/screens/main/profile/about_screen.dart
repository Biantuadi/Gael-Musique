import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AboutScreen extends StatefulWidget{
  const AboutScreen({super.key});

  @override
  AboutScreenState createState()=> AboutScreenState();
}
class AboutScreenState extends State<AboutScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("A propos", style: Theme.of(context).textTheme.titleMedium,),
      ),
    );
  }
}