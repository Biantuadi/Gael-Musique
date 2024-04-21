import 'package:Gael/data/models/app/screen_model.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/screens/main/chat/chat_list_screen.dart';
import 'package:Gael/views/screens/main/notifications/notifications_screen.dart';
import 'package:Gael/views/screens/main/profile/profile_screen.dart';
import 'package:Gael/views/screens/main/streaming/streaming_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'home/home_screen.dart';
import 'package:Gael/utils/dimensions.dart';


class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  MainScreenState createState()=>MainScreenState();
}
class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
 List<ScreenModel> screens = [];
  late PageController pageController;
  late TabController tabController;
  int selectedIndex = 0;
  bool showAppBar = true;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    super.initState();
    screens = [
      ScreenModel(icon: Iconsax.home, activeIcon: Iconsax.home_11, content:const HomeScreen()),
      ScreenModel(icon: Iconsax.radio, activeIcon: Iconsax.radio5, content:  const StreamingScreen()),
      ScreenModel(icon: Iconsax.message, activeIcon: Iconsax.message1, content:  const ChatListScreen()),
      ScreenModel(icon: Iconsax.notification, activeIcon: Iconsax.notification1, content:  const NotificationsScreen()),
      ScreenModel(icon: Iconsax.user, activeIcon: Iconsax.user, content:  const ProfileScreen()),
    ];
    tabController = TabController(length: screens.length, vsync: this);
    tabController.addListener(() {
      setState(() {
        selectedIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
  bool showStreamContainer = false;

 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SocketProvider socketProvider = Provider.of<SocketProvider>(context, listen: true);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SongProvider songProvider = Provider.of<SongProvider>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor : Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness:  Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarContrastEnforced: true,
          systemNavigationBarIconBrightness:Brightness.light,
          systemStatusBarContrastEnforced: false,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: Consumer<StreamingProvider>(builder: (context, provider, child){
          if(provider.streamingController.value.isPlaying && (songProvider.audioPlayer.playing || songProvider.songIsPlaying)){
            songProvider.pauseSong();
          }
          return Scaffold(
            floatingActionButton: IconButton(
              onPressed: (){
                if(songProvider.audioPlayer.playing || songProvider.songIsPlaying){
                  songProvider.pauseSong();
                }else{
                  songProvider.playSong();
                }
              },
              icon: Icon(
                (songProvider.audioPlayer.playing || songProvider.songIsPlaying)?
                CupertinoIcons.pause_solid:
                CupertinoIcons.play_fill,
                color: ThemeVariables.backgroundBlack,
              ),
            ),
              floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
              bottomNavigationBar: BottomAppBar(
                color: Colors.black,
                padding: EdgeInsets.zero,
                elevation: 0.1,
                shadowColor: Colors.grey,
                height: provider.showStreamPlayContainer? size.height * .2 : size.height * .08,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    provider.showStreamPlayContainer?
                        GestureDetector(
                          onTap: (){
                              Navigator.pushNamed(context, Routes.streamingDetailsScreen);
                          },
                          child: Container(
                            width: size.width,
                            height: size.height * .1,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width/3,
                                  height: size.height * .1,
                                  child: YoutubePlayer(
                                      controller: provider.streamingController,
                                      aspectRatio: (size.width/ 3)/ (size.height * .1),
                                      width: size.width/3,
                                    actionsPadding: EdgeInsets.zero,
                                    thumbnail: const SizedBox(height: 0, width: 0,),
                                    bufferIndicator: const SizedBox(height: 0, width: 0,),
                                                                    ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: Dimensions.spacingSizeSmall,
                                      left: Dimensions.spacingSizeSmall,
                                  ),
                                  width: size.width/3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(provider.currentStreaming!.title, style: Theme.of(context).textTheme.titleSmall,overflow: TextOverflow.ellipsis,),
                                      Text(provider.currentStreaming!.description, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  if(provider.streamingController.value.isPlaying){
                                    setState(() {
                                      provider.streamingController.pause();
                                    });
                                  }else{
                                    setState(() {
                                      provider.streamingController.play();
                                    });
                                  }
                                  provider.playStreamVideo();
                                }, icon:  Icon(provider.streamingController.value.isPlaying ? CupertinoIcons.pause_solid:CupertinoIcons.play_arrow_solid)),
                                IconButton(onPressed: (){
                                  provider.disposePlayer();
                                }, icon: const Icon(CupertinoIcons.multiply)),
                              ],
                            ),
                          ),
                        ): const SizedBox(height: 0,),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: size.width,
                          height: 0.2,
                          color: Colors.grey,
                        ),
                        TabBar(
                          dividerHeight: 0,
                          dividerColor: Colors.black,
                          automaticIndicatorColorAdjustment: true,
                          tabAlignment: TabAlignment.fill,
                          indicator: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: ThemeVariables.primaryColor)
                              )
                          ),
                          controller: tabController,
                          onTap: (index){
                            setState(() {
                              tabController.index = index;
                            });
                          },

                          tabs:screens.map((screen) => Tab(
                              child: Container(
                                padding: EdgeInsets.only(top: Dimensions.spacingSizeDefault),
                                child: Icon(
                                  tabController.index == screens.indexOf(screen)? screen.activeIcon : screen.icon,
                                  color: tabController.index == screens.indexOf(screen)? ThemeVariables.primaryColor : ThemeVariables.iconInactive,
                                  size:Dimensions.iconSizeDefault,

                                ),
                              )
                          )).toList() ,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              body: TabBarView(
                controller: tabController,
                children: screens.map((screen) => screen.content).toList(),
              )
          );
        })
   );

  }
}