import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'components/home_album_card.dart';
import 'components/home_card.dart';
import 'components/streaming_card.dart';

class HomeScreen extends StatefulWidget {
  ///VoidCallback voidCallback;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  bool showAppBar = true;
  @override
  void initState() {
    // 
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
      statusBarIconBrightness: Brightness.light,
    ));
    Size size = MediaQuery.sizeOf(context);
    Widget spacing()=>SizedBox(height: Dimensions.spacingSizeDefault,);
    List<Album> albums = Provider.of<SongProvider>(context, listen: false).allAlbums;
    List<Streaming> streamings = Provider.of<StreamingProvider>(context, listen: false).allStreaming;
    if(streamings.length >= 4){
        streamings = streamings.sublist(0, 4);
    }

  //Uint8List bytes = base64Decode(Provider.of<AuthProvider>(context, listen: false).userProfileUrl!);
    return  Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(
              showLogo: true,
              showAvatar: true,
            ) ,

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
                              child: HomeCard(onTap: (){}, iconData: Iconsax.share, title: "Sanjola & lives", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom:Dimensions.spacingSizeDefault/2),
                              child: HomeCard(onTap: (){}, iconData: Iconsax.book, title: "Enseignements", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom:Dimensions.spacingSizeDefault/2),
                              child: HomeCard(onTap: (){
                                Navigator.pushNamed(context, Routes.albumScreen);
                              }, iconData: Iconsax.music, title: "Albums", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom:Dimensions.spacingSizeDefault/2),
                              child: HomeCard(onTap: (){
                                Navigator.pushNamed(context, Routes.eventScreen);
                              }, iconData: Iconsax.calendar, title: "Evenements", width: (size.width/2) - 3* Dimensions.spacingSizeDefault/2, ),
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
                        padding:  EdgeInsets.only(left:Dimensions.spacingSizeDefault),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Streaming", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: (){},
                                child: Text("Voir plus", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ThemeVariables.primaryColor),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      spacing(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault),
                        child: Center(
                          child: Column(
                            children: [
                              Wrap(
                                spacing: Dimensions.spacingSizeSmall,
                                alignment: WrapAlignment.spaceEvenly,
                                children: streamings.map((streaming) => StreamingCard(streaming: streaming, size: (size.width/4) - (Dimensions.spacingSizeDefault * 4/3),)).toList(),
                              ),

                            ],
                          ),
                        ),
                      ),
                      spacing(),
                      Padding(
                        padding:  EdgeInsets.only(left:Dimensions.spacingSizeDefault),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Albums", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, Routes.albumScreen);
                                  print("HELLO WORLD");
                                },
                                child: Text("Voir plus", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ThemeVariables.primaryColor),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height/4,
                        child: ListView.builder(
                          padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                            itemCount: albums.length >= 4? 4 : albums.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                            Album album = albums[index];
                              return HomeAlbumCard(album: album,screenSize: size,);
                            }),
                      ),
                      SizedBox(height: Dimensions.spacingSizeLarge * 3,)

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
