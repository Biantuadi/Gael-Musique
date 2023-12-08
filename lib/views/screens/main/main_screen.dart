import 'package:Gael/data/models/screen_model.dart';
import 'package:Gael/views/screens/main/chat/chat_list_screen.dart';
import 'package:Gael/views/screens/main/favorite/favorite_sreen.dart';
import 'package:Gael/views/screens/main/profile/profile_screen.dart';
import 'package:Gael/views/screens/main/radio/radio_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget{
  @override
  _MainScreenState createState()=>_MainScreenState();
}
class _MainScreenState extends State<MainScreen>{
 List<ScreenModel> screens = [];
  late PageController pageController;
  int selectedIndex = 0;
  ScrollController scrollController = ScrollController();
  bool showAppBar = true;

  @override
  void initState() {
    super.initState();
    screens = [
      ScreenModel(icon: Iconsax.home, activeIcon: Iconsax.home1, content:  HomeScreen()),
      ScreenModel(icon: CupertinoIcons.list_bullet, activeIcon: CupertinoIcons.list_bullet_indent, content:  ChatListScreen()),
      ScreenModel(icon: CupertinoIcons.list_bullet, activeIcon: CupertinoIcons.list_bullet_indent, content:  RadioScreen()),
      ScreenModel(icon: CupertinoIcons.list_bullet, activeIcon: CupertinoIcons.list_bullet_indent, content:  FavoriteScreen()),
      ScreenModel(icon: CupertinoIcons.list_bullet, activeIcon: CupertinoIcons.list_bullet_indent, content:  ProfileScreen()),
    ];
    pageController = PageController(
      initialPage: selectedIndex,
    );
    showAppBar = true;
  }
  jumpToPage(int value){
    setState(() {
      selectedIndex = value;
    });
    pageController.jumpToPage(value);
  }


  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor : Colors.transparent,
          statusBarBrightness: isDark? Brightness.light: Brightness.dark,
          statusBarIconBrightness: isDark? Brightness.light : Brightness.dark,
          systemNavigationBarColor: isDark? Colors.black :  Colors.transparent,
          systemNavigationBarContrastEnforced: true,
          systemNavigationBarIconBrightness:isDark?Brightness.light : Brightness.dark,
          systemStatusBarContrastEnforced: false,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 20000),
              color: Theme.of(context).colorScheme.background,
              curve: Curves.easeInCirc,
              height: showAppBar? null : 0,
              child: BottomNavigationBar(
                selectedItemColor: Colors.deepOrangeAccent,
                unselectedItemColor: Colors.grey,
                currentIndex: selectedIndex,
                elevation: 30,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).colorScheme.background,
                selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                unselectedLabelStyle:Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).primaryColor,
                ) ,
                onTap: (index){
                  jumpToPage(index);
                },
                items: screens.map((screen) => BottomNavigationBarItem(
                  icon: Icon(screen.icon),
                  activeIcon: Icon(screen.activeIcon),

                )).toList(),
              ),
            ),
            body: PageView(
              controller: pageController,
              padEnds: false,
              //physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value){
                setState(() {
                  selectedIndex = value;
                  showAppBar = true;
                });
              },
              children: screens.map((screen) => screen.content).toList(),
            )
        ));
  }
}