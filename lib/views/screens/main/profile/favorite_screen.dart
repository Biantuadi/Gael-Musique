import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatefulWidget{
  const FavoriteScreen({super.key});

  @override
  FavoriteScreenState createState()=> FavoriteScreenState();
}
class FavoriteScreenState extends State<FavoriteScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("Favoris", style: Theme.of(context).textTheme.titleMedium,),
      ),
    );
  }
}