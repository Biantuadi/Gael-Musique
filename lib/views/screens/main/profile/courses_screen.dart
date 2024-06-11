import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CoursesScreen extends StatefulWidget{
  const CoursesScreen({super.key});

  @override
  CoursesScreenState createState()=> CoursesScreenState();
}
class CoursesScreenState extends State<CoursesScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("Enseignements", style: Theme.of(context).textTheme.titleMedium,),
      ),
    );
  }
}

