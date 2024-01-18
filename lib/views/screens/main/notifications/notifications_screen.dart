
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../components/streaming_widget.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}




class _NotificationsScreenState extends State<NotificationsScreen> {
  ScrollController scrollController = ScrollController();

  bool showHeader = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<StreamingProvider>(context, listen: false).getStreaming();
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
    return Consumer<StreamingProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                title: Text("Vos favoris",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
                pinned: true,
                backgroundColor:ThemeVariables.thirdColorBlack,
              ),
              SliverList.list(children: [
                Container(
                  padding: EdgeInsets.only(
                    top : Dimensions.spacingSizeDefault,
                    left : Dimensions.spacingSizeDefault,
                  ),
                  child:Text("Revivez ces moments", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                ),
              ]),

              SliverPadding(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.spacingSizeDefault, mainAxisSpacing: Dimensions.spacingSizeDefault, childAspectRatio: .8),
                  itemBuilder: (BuildContext ctx, int index){
                    if(provider.streamingToShow == null){
                      return  Container(
                        width: size.width,
                        height: size.width * 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                        ),
                      );
                    }
                    return StreamingWidget(streaming: provider.streamingToShow![index],);
                  },
                  itemCount: provider.streamingToShow!.length,
                ),
              )
            ],
          );
        }
    );
  }
}
