import 'package:Gael/data/models/screen_model.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/screens/main/chat/chat_list_screen.dart';
import 'package:Gael/views/screens/main/favorite/favorite_sreen.dart';
import 'package:Gael/views/screens/main/profile/profile_screen.dart';
import 'package:Gael/views/screens/main/radio/radio_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'home/home_screen.dart';

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

  @override
  void initState() {
    super.initState();
    screens = [
      ScreenModel(icon: Iconsax.home, activeIcon: Iconsax.home_11, content:  const HomeScreen()),
      ScreenModel(icon: Iconsax.message, activeIcon: Iconsax.message1, content:  const ChatListScreen()),
      ScreenModel(icon: Iconsax.radio, activeIcon: Iconsax.radio5, content:  const RadioScreen()),
      ScreenModel(icon: Iconsax.heart, activeIcon: Iconsax.heart5, content:  const FavoriteScreen()),
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          padding: EdgeInsets.zero,
          elevation: 0.1,
          shadowColor: Colors.grey,
          child:TabBar(
            dividerHeight: 0,
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
                icon: Icon(
                    tabController.index == screens.indexOf(screen)? screen.activeIcon : screen.icon,
                  color: tabController.index == screens.indexOf(screen)? ThemeVariables.primaryColor : ThemeVariables.iconInactive,

                )
            )).toList() ,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: screens.map((screen) => screen.content).toList(),
        )
    );
  }
  Widget page()=>PageView(
    padEnds: false,
    //physics: const NeverScrollableScrollPhysics(),
    onPageChanged: (value){
      setState(() {
        selectedIndex = value;
        showAppBar = true;
      });
    },
    children: screens.map((screen) => screen.content).toList(),
  );
}