import 'package:Gael/data/models/event_ticket_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'components/ticket_widget.dart';

class PaymentScreen extends StatefulWidget{
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState()=> PaymentScreenState();
}
class PaymentScreenState extends State<PaymentScreen>{
  @override
  Widget build(BuildContext context) {
    return Consumer2<EventsProvider, AuthProvider>(builder: (ctx, eventProvider,authProvider, child){
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
            Navigator.pop(context);
          },),
          title: Text("Tickets", style: Theme.of(context).textTheme.titleMedium,),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                  return TicketWidget(
                    eventTicket: EventTicket(
                        event: eventProvider.events!.last,
                        id: 'hxjUSuygVYhhIINSYZHSBJyz-j',
                        createdAt: DateTime.now(),
                        price: 10,
                        user: authProvider.user!
                    ),
                  );
              },
            )
          ],
        ),
      );
    });
  }
}