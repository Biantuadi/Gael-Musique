import 'package:Gael/data/models/app/screen_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/data/utils.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:Gael/views/screens/main/chat/chat_list_screen.dart';
import 'package:Gael/views/screens/main/notifications/notifications_screen.dart';
import 'package:Gael/views/screens/main/profile/profile_screen.dart';
import 'package:Gael/views/screens/main/streaming/streaming_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/config_provider.dart';
import 'home/home_screen.dart';
import 'package:Gael/utils/dimensions.dart';

class MainScreen extends StatefulWidget{
  final int? initialIndex;
  const MainScreen({super.key, required this.initialIndex});

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
  Connectivity connectivity =  Connectivity();
  bool userIsAuthenticated = false;


  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex??0;

    screens.add(ScreenModel(icon: Iconsax.home, activeIcon: Iconsax.home_11, content: HomeScreen(
      voidCallback: (){
        setState(() {
          tabController.index = 2;
        });
      },
    )));
    if(Provider.of<AuthProvider>(context, listen: false).userIsAuthenticated){
      screens.add(ScreenModel(icon: Iconsax.message, activeIcon: Iconsax.message1, content:  const ChatListScreen()));
    }
    screens.add( ScreenModel(icon: Iconsax.radio, activeIcon: Iconsax.radio5, content:  const StreamingScreen()));
    if(Provider.of<AuthProvider>(context, listen: false).userIsAuthenticated){
      screens.add(ScreenModel(icon: Iconsax.notification, activeIcon: Iconsax.notification1, content:  const NotificationsScreen()));
    }
    screens.add(ScreenModel(
        icon:Provider.of<AuthProvider>(context, listen: false).userIsAuthenticated?
        Iconsax.user : Iconsax.setting_2,
        activeIcon: Provider.of<AuthProvider>(context, listen: false).userIsAuthenticated?
        Iconsax.user : Iconsax.setting,
        content:  const ProfileScreen()));

    if(widget.initialIndex != null){
      if(widget.initialIndex! > 4){
        selectedIndex = screens.length - 1;
      }else{
        selectedIndex = 0;
      }
    }

    tabController = TabController(length: screens.length, vsync: this);
    tabController.addListener(() {
      setState(() {
        selectedIndex = tabController.index;
      });
    });
  }


 getData(){
      if(Provider.of<ConfigProvider>(context, listen: false).isOfflineMode){
         noInternetCallBacks(context);
      }else{
        connectivity.checkConnectivity().then((value)async{
          if(value.isNotEmpty){
            if(value.contains(ConnectivityResult.ethernet) || value.contains(ConnectivityResult.mobile) || value.contains(ConnectivityResult.wifi) ){
              await internetCallBacks(context);
            }else{
              await noInternetCallBacks(context);
            }
          }
        });
      }
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
        child: Consumer3<StreamingProvider,SongProvider, SocketProvider>(builder: (context, streamProvider,songProvider,socketProvider, child){
          if(streamProvider.videoPlayerHasBeenInitialized){
            if(streamProvider.podPlayerController.isVideoPlaying && (songProvider.audioPlayer.playing || songProvider.songIsPlaying)){
              songProvider.pauseSong();
            }
          }
          return Scaffold(
            floatingActionButton:songProvider.audioPlayer.playing? GestureDetector(
              onTap: (){
                if(songProvider.audioPlayer.playing || songProvider.songIsPlaying){
                  songProvider.pauseSong();
                }else{
                  songProvider.playSong();
                }
              },
              child: Container(
                padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                decoration: BoxDecoration(
                    color: ThemeVariables.primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall)
                ),
                child: Icon(
                  (songProvider.audioPlayer.playing || songProvider.songIsPlaying)?
                  CupertinoIcons.pause_solid:
                  CupertinoIcons.play_fill,
                  color: ThemeVariables.backgroundBlack,
                ),
              ),
            ): Container(),
              floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
              bottomNavigationBar: BottomAppBar(
                color: Colors.black,
                padding: EdgeInsets.zero,
                elevation: 0.1,
                shadowColor: Colors.grey,
                height: streamProvider.showStreamPlayContainer? size.height * .2 : size.height * .08,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    streamProvider.showStreamPlayContainer?
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
                                  child:
                                 AspectRatio(
                                    aspectRatio: (size.height * .1) /(size.width/3),
                                    child:
                                        streamProvider.podPlayerController.isVideoPlaying && streamProvider.videoIsPlaying?
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, Routes.streamingDetailsScreen);
                                      },
                                      child: PodVideoPlayer(
                                        controller: streamProvider.podPlayerController,
                                        videoAspectRatio: (size.height * .1) /(size.width/3),
                                        matchFrameAspectRatioToVideo: true,
                                        matchVideoAspectRatioToFrame: true,
                                        alwaysShowProgressBar: false,

                                        overlayBuilder: (builder){
                                          return const SizedBox();
                                        },
                                      ),
                                    ) :
                                   SizedBox(
                                     width: size.width/3,
                                     height: size.height * .1,
                                     child: NetWorkImageWidget(
                                       imageUrl: streamProvider.currentStreaming!= null? streamProvider.currentStreaming!.cover :'',
                                       size: Size(size.width/3, size.height * .1), radius: 0,),
                                   ),
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
                                      Text(streamProvider.currentStreaming!.title, style: Theme.of(context).textTheme.titleSmall,overflow: TextOverflow.ellipsis,),
                                      Text(streamProvider.currentStreaming!.description, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  if(streamProvider.podPlayerController.isVideoPlaying){
                                    setState(() {
                                      //streamProvider.podPlayerController.pause();
                                      streamProvider.pauseVideo();
                                      Navigator.pushNamed(context, Routes.streamingDetailsScreen);
                                    });
                                  }else{
                                    setState(() {
                                     // streamProvider.podPlayerController.play();
                                      streamProvider.playVideo();
                                    });
                                  }
                                  streamProvider.playVideo();
                                }, icon:  Icon(streamProvider.podPlayerController.isVideoPlaying ? CupertinoIcons.pause_solid:CupertinoIcons.play_arrow_solid)),
                                IconButton(onPressed: (){
                                  streamProvider.disposePlayer();
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

                            if(tabController.index == screens.length - 1){
                              if(!Provider.of<AuthProvider>(context, listen: false).userIsAuthenticated){
                                Navigator.pushNamed(context, Routes.settingsScreen);
                              }
                            }else{
                              setState(() {
                                tabController.index = index;
                              });
                            }
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