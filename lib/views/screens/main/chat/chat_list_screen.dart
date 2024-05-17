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
import 'package:Gael/views/components/buttons/secondary_button.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:Gael/views/screens/main/chat/components/chat_list_item.dart';
import 'package:Gael/views/screens/main/chat/components/user_widget.dart';
import 'package:Gael/views/screens/not_internet_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
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
    getData();
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
          return Scaffold(
              floatingActionButton: GestureDetector(
                onTap: (){
                  showCustomBottomSheet(
                      context: context,
                      content: usersSheet()
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                  decoration: BoxDecoration(
                      color: ThemeVariables.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall)
                  ),
                  child: const Icon(Iconsax.add,
                    color: ThemeVariables.backgroundBlack,
                  ),
                ),
              ),
            body: CustomScrollView(

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
                leading: const SizedBox(),
                leadingWidth: 0,
                title: CustomTextField(
                  initialValue: chatProvider.chatKeySearch,
                  onChanged: (value) {
                    chatProvider.setChatKeySearch(value);
                  },
                  hintText: 'Recherche...',
                ),
              ),
              chatProvider.chats != []?
              SliverList.builder(
                itemCount: chatProvider.chatsToShow != null? chatProvider.chatsToShow!.length : 10,
                itemBuilder: (context, index) {
                  if(chatProvider.chatsToShow != null){
                    return ChatListItem(chat: chatProvider.chatsToShow![index],  );
                  }
                  return const ChatItemShimmer();

                },
              ) :
              SliverList.list(children:[
                Container(
                  height: size.height,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Aucune conversation", style: Theme.of(context).textTheme.titleSmall,),
                      SecondaryButton(
                        onTap: (){},
                        size: Size(size.width/2, 50),
                        child: Text("Créer",  style: Theme.of(context).textTheme.bodySmall,),)
                    ],
                  ),
                )
              ] ),
            ],
          ));}
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

  Widget usersSheet(){
    Size size = MediaQuery.sizeOf(context);
    return Consumer<ChatProvider>(builder:(ctx, chatProvider, child){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.spacingSizeDefault,),

          Row(
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon:const Icon(Iconsax.arrow_left, color: Colors.white,)),
              SizedBox(width: Dimensions.spacingSizeDefault,),
              Text("Texter avec...", style: Theme.of(context).textTheme.titleMedium,),
            ],
          ),
          SizedBox(height: Dimensions.spacingSizeDefault,),
          CustomTextField(
            initialValue: chatProvider.usersKeySearch,
            onChanged: (value) {
              chatProvider.setUsersKeySearch(value);
            },
            hintText: 'Recherche...',
          ),
          SizedBox(height: Dimensions.spacingSizeDefault,),
          Expanded(
            child: ListView.builder(
              itemCount: chatProvider.usersToShow != null? chatProvider.usersToShow!.length : 10,
              itemBuilder: (ctx, i){
                if(chatProvider.usersToShow == null ){
                  return SizedBox(
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Dimensions.iconSizeExtraLarge * 1.2,
                          width: Dimensions.iconSizeExtraLarge * 1.2,
                          margin: EdgeInsets.only(bottom: Dimensions.spacingSizeSmall),
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall)
                          ),
                        ),
                        SizedBox(width: Dimensions.spacingSizeSmall,),
                        Container(
                          width: size.width/2,
                          color: Colors.white12,
                          height: Dimensions.spacingSizeSmall,
                        )
                      ],
                    ),
                  );
                }
                return UserWidget(user: chatProvider.users![i]);
              },

            ),
          ),
        ],
      );
    } );
  }
}
