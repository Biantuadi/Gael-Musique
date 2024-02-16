import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'components/event_widget.dart';


class EventDetailsScreen extends StatefulWidget{
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  State<StatefulWidget> createState() {
    return EventDetailsScreenState();
  }

}
class EventDetailsScreenState extends State<EventDetailsScreen>{
  ScrollController scrollController = ScrollController();

  bool showHeader = true;
  double value = 0;
  @override
  void initState() {
    super.initState();

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
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                      //title: Text(widget.album.title,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                      pinned: true,
                      backgroundColor:Colors.black,
                      actions:[],
                    ),

                    SliverList.list(children: [

                    ]),

                    provider.events!.isEmpty?

                    SliverPadding(
                      padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                      sliver:SliverList.list(children: [
                        Center(child: Text("Aucun évenement trouvé", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),),
                      ]),
                    ) :SliverPadding(
                        padding: EdgeInsets.only(top : Dimensions.spacingSizeDefault),
                        sliver: SliverList.builder(
                            itemCount:provider.events!.length ,
                            itemBuilder: (BuildContext ctx, int i){
                              return EventWidget(event: provider.events![i],);
                            })),
                  ],
                ),

              ],
            ),
          );
        }
    );
  }
}