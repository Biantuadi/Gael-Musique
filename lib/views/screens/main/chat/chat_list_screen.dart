// ignore_for_file: unused_local_variable

import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/chat_provider.dart';
import 'package:Gael/data/providers/config_provider.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/screens/main/chat/components/chat_list_item.dart';
import 'package:Gael/views/screens/not_internet_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  ScrollController scrollController = ScrollController();
  bool showAppBar = true;
  Connectivity connectivity = Connectivity();
  getData(){
    Provider.of<ChatProvider>(context, listen: false).getChatsFromDB();
    if(Provider.of<ConfigProvider>(context, listen: false).isOfflineMode){
      Provider.of<ChatProvider>(context, listen: false).getUsersFromDB();
    }else{
      connectivity.checkConnectivity().then((value){
        if(value.contains(ConnectivityResult.wifi) || value.contains(ConnectivityResult.mobile)){
          Provider.of<ChatProvider>(context, listen: false).getUsersFromApi();
        }else{
          showCustomBottomSheet(
              context: context,
              content: NoInternetWidget(
                voidCallback: () {
                  Navigator.pop(context);
                },
              )
          );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          showAppBar = false;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showAppBar = true;
        });
      }
    });
    scrollController.addListener(loadMore);
  }

  void loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Provider.of<ChatProvider>(context, listen: true).incrementCurrentPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer3<ChatProvider, SocketProvider, AuthProvider>(builder: (ctx, chatProvider, socketProvider,authProvider,child) {
      if(authProvider.userIsAuthenticated){
      return CustomScrollView(
        slivers: [
          SliverList.list(children: [
            Container(
              color: ThemeVariables.thirdColorBlack,
              padding: EdgeInsets.only(
                  top: Dimensions.spacingSizeDefault * 3,
                  left: Dimensions.spacingSizeDefault),
              child: Text(
                "Messages",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            )
          ]),
          SliverAppBar(
            pinned: true,
            backgroundColor: ThemeVariables.thirdColorBlack,
            title: CustomTextField(
              onChanged: (value) {
                chatProvider.setChatKeySearch(value);
              },
              hintText: 'Recherche...',
            ),
          ),
          SliverList.builder(
            itemCount: chatProvider.users != null? chatProvider.users!.length : 10,
            itemBuilder: (context, index) {
              if(chatProvider.users != null){
                return ChatListItem(chat: chatProvider.chats![index],  );
              }
              return const ChatItemShimmer();

            },
          ),
        ],
      );}
      return SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Veillez vous connecter", style: Theme.of(context).textTheme.bodyLarge,),
                SizedBox(height: Dimensions.spacingSizeSmall,),
                SizedBox(
                  width: size.width,
                  child: GradientButton(onTap: () {
                    Navigator.pushNamed(context, Routes.loginScreen);
                  }, size: Size(size.width, 50),
                  child: Text('connexion', style: Theme.of(context).textTheme.titleSmall,),),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
