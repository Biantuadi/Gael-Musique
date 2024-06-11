import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserEventScreen extends StatefulWidget{
  const UserEventScreen({super.key});

  @override
  UserEventScreenState createState()=> UserEventScreenState();
}
class UserEventScreenState extends State<UserEventScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("Evenements", style: Theme.of(context).textTheme.titleMedium,),
      ),
    );
  }
}