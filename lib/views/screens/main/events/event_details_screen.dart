import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/get_formatted_duration.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';


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
                    SliverList.list(children: [
                      Stack(
                        children: [
                          NetWorkImageWidget(imageUrl:widget.event.image , size: Size(size.width, size.height/2), radius: 0,),
                          Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4)
                            ),
                            child: SafeArea(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      icon:const Icon(Iconsax.arrow_left,color: Colors.white, )
                                  ),
                                  SizedBox(width: Dimensions.spacingSizeDefault,),
                                  Text(widget.event.title, style: Theme.of(context).textTheme.titleMedium,)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Wrap(
                              spacing: Dimensions.spacingSizeDefault,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                                  decoration: BoxDecoration(
                                      color: ThemeVariables.primaryColor,
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Iconsax.calendar, size: Dimensions.iconSizeSmall, color: Colors.black,),
                                      SizedBox(
                                        width: Dimensions.spacingSizeExtraSmall,
                                      ),
                                      Text(getFormattedDate(widget.event.datetime), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                                  ),
                                  child:  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Iconsax.clock, size: Dimensions.iconSizeSmall, color: Colors.black,),
                                      SizedBox(
                                        width: Dimensions.spacingSizeExtraSmall,
                                      ),
                                      Text("${widget.event.startTime} - ${widget.event.endTime}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.spacingSizeDefault,),
                            Row(
                              children: [
                                Icon(Iconsax.location, size: Dimensions.iconSizeSmall,),
                                SizedBox(
                                  width: Dimensions.spacingSizeExtraSmall,
                                ),
                                Expanded(child: Text(widget.event.location, style: Theme.of(context).textTheme.bodyMedium,)),
                              ],
                            ),
                            SizedBox(height: Dimensions.spacingSizeDefault,),
                            Text("Description", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ThemeVariables.primaryColor,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: Dimensions.spacingSizeDefault,),
                            Text(widget.event.description, style: Theme.of(context).textTheme.bodyMedium,),
                          ],
                        ),
                      )
                    ])
                  ],
                ),
                Positioned(
                    child:Container(
                      padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                      child: GradientButton(onTap: (){
                        if(Provider.of<AuthProvider>(context, listen: false).userIsAuthenticated){
                          Navigator.of(context).pushNamed(Routes.paymentDetailsScreen);
                        }else{
                          Navigator.of(context).pushNamed(Routes.loginScreen, arguments: Routes.eventDetailsScreen);
                        }

                      }, size: size, child: Text("Réserver", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),)),
                    )

                )

              ],
            ),
          );
        }
    );
  }
}