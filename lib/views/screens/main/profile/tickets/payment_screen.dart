import 'package:Gael/data/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget{
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState()=> PaymentScreenState();
}
class PaymentScreenState extends State<PaymentScreen>{
  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(builder: (ctx, provider, child){
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
            Navigator.pop(context);
          },),
          title: Text("Paiements", style: Theme.of(context).textTheme.titleMedium,),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.list(children: [

            ])
          ],
        ),
      );
    });
  }
}