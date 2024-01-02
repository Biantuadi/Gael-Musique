import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'components/home_album_card.dart';
import 'components/home_card.dart';
import 'components/streaming_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  bool showAppBar = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          showAppBar = true;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showAppBar = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    Size size = MediaQuery.sizeOf(context);
    Widget spacing()=>SizedBox(height: Dimensions.spacingSizeDefault,);
    return  Scaffold(
      appBar: (!showAppBar)?AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.black,
        leading: const SizedBox(),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification_1, color: Colors.white,))
        ],
        title: Text("Accueil", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
      ) :null ,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showAppBar?
            const CustomHeader(
              showLogo: true,
              showAvatar: true,
            ) : const SizedBox(height: 0, width: 0,),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spacing(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal :Dimensions.spacingSizeDefault),
                        child: Wrap(
                          spacing: Dimensions.spacingSizeDefault/2,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(bottom:Dimensions.spacingSizeDefault/2),
                              child: HomeCard(onTap: (){}, iconData: Iconsax.share, title: "Tredding & radios", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom:Dimensions.spacingSizeDefault/2),
                              child: HomeCard(onTap: (){}, iconData: Iconsax.book, title: "Enseignements", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom:Dimensions.spacingSizeDefault/2),
                              child: HomeCard(onTap: (){}, iconData: Iconsax.music, title: "Album", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom:Dimensions.spacingSizeDefault/2),
                              child: HomeCard(onTap: (){}, iconData: Iconsax.calendar, title: "Evenements", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
                            ),
                          ],
                        ),
                      ),
                      spacing(),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal:Dimensions.spacingSizeDefault),
                        child: Text("LIBRARY", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ThemeVariables.primaryColor),),
                      ),
                      spacing(),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal:Dimensions.spacingSizeDefault),
                        child: Text("Streaming", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                      ),
                      spacing(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  StreamingCard(title: '20 ans Gael', imagePath: Assets.splashBgJPG, size: (size.width/4) - (Dimensions.spacingSizeDefault * 4/3),),
                                  StreamingCard(title: 'Covers', imagePath: Assets.splashBgJPG, size: (size.width/4) - (Dimensions.spacingSizeDefault * 4/3),),
                                  StreamingCard(title: 'Sanjola 2019', imagePath: Assets.splashBgJPG, size: (size.width/4) - (Dimensions.spacingSizeDefault * 4/3),),
                                  StreamingCard(title: 'Saint-Esprit', imagePath: Assets.splashBgJPG, size: (size.width/4) - (Dimensions.spacingSizeDefault * 4/3),),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: (){},
                                  child: Text("Voir plus", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ThemeVariables.primaryColor),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      spacing(),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal:Dimensions.spacingSizeDefault),
                        child: Text("Albums", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                      ),
                      SizedBox(
                        height: size.height/3,
                        child: ListView.builder(
                          padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return HomeAlbumCard(title: 'SUBLIME', imagePath: Assets.bgWelcomeWEBP, randomSongTitle: 'Parfum qui chante', screenSize: size,);
        
                            }),
                      )
                    ],
                  ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
