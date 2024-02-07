import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PaymentScreen extends StatefulWidget{
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState()=> PaymentScreenState();
}
class PaymentScreenState extends State<PaymentScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("Paiements", style: Theme.of(context).textTheme.titleMedium,),
      ),
    );
  }
}