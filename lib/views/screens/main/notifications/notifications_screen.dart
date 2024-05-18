
// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:Gael/data/models/notification_model.dart';
import 'package:Gael/data/providers/notification_provider.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'components/notification_widget.dart';

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
    scrollController.addListener(loadMore);
  }
  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      Provider.of<NotificationProvider>(context, listen: true).incrementCurrentPage();
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SocketProvider socketProvider = Provider.of<SocketProvider>(context, listen: true);
    return Consumer<NotificationProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                title: Text("Notifications",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
                pinned: true,
                leadingWidth: 0,
                leading: Container(),
                backgroundColor:ThemeVariables.thirdColorBlack,
              ),
              SliverList.list(children: [
              ]),

              SliverPadding(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                sliver: SliverList.builder(
                  itemCount: 10,
                    itemBuilder: (ctx, index){
                      return NotificationWidget(
                        notification: NotificationModel(
                            id: 'wvttesuia$index',
                            title: 'Account notification',
                            message: 'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Amet vitae nemo tempore, accusantium, quaerat laborum ex quibusdam natus aperiam beatae at officia, suscipit mollitia saepe incidunt provident! Ratione, quam molestias!',
                            dateTime: DateTime.now(),
                            read: false)
                        ,
                      );
                    }),
              )
            ],
          );
        }
    );
  }
}
