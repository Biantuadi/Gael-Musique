// ignore_for_file: unused_local_variable

import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'components/event_widget.dart';


class EventsScreen extends StatefulWidget{

  const EventsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return EventsScreenState();
  }

}
class EventsScreenState extends State<EventsScreen>{
  ScrollController scrollController = ScrollController();

  bool showHeader = true;
  double value = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<EventsProvider>(context, listen: false).getEventsFromAPi();

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          showHeader = false;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showHeader = true;
        });
      }
    });
    scrollController.addListener(loadMore);
  }
  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      Provider.of<EventsProvider>(context, listen: true).incrementCurrentPage();
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SocketProvider socketProvider = Provider.of<SocketProvider>(context, listen: true);
    return Consumer<EventsProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
                        Navigator.pop(context);
                      },),
                      title: Text("Evenements",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                      pinned: true,
                      backgroundColor:Colors.black,
                    ),

                    SliverList.list(children: []),

                    provider.events != null?
                        provider.events!.isNotEmpty?
                    SliverPadding(
                        padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                        sliver: SliverList.builder(
                            itemCount:provider.events!.length ,
                            itemBuilder: (BuildContext ctx, int i){
                              return EventWidget(event: provider.events!.toList()[1],);
                            })):SliverPadding(
                          padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                          sliver:SliverList.list(children: [
                            Center(child: Text("Aucun évenement trouvé", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),),
                          ]),
                        )  : SliverPadding(
                      padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                      sliver:SliverList.list(children: const [
                        Center(child:CircularProgressIndicator(color: ThemeVariables.primaryColor, strokeWidth: 1,)),

                      ]),
                    )
                    ,
                  ],
                ),

              ],
            ),
          );
        }
    );
  }
}