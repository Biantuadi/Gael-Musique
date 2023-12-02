import 'dart:math';

import 'package:Gael/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui show ImageFilter;

class CustomNavbarBottom extends StatelessWidget {
  const CustomNavbarBottom({
    Key? key,
    this.isHome = false,
    this.isChat = false,
    this.isRadio = false,
    this.isFavorite = false,
    this.isProfile = false,
  }) : super(key: key);

  final bool isHome;
  final bool isChat;
  final bool isRadio;
  final bool isFavorite;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavbarItem(
                  context,
                  icon: "home.svg",
                  route: Routes.homeScreen,
                  isActive: isHome,
                ),
                _buildNavbarItem(
                  context,
                  icon: "message-text.svg",
                  route: Routes.chatScreen,
                  isActive: isChat,
                ),
                _buildNavbarItem(
                  context,
                  icon: "radio.svg",
                  route: Routes.radioScreen,
                  isActive: isRadio,
                ),
                _buildNavbarItem(
                  context,
                  icon: "Heart.svg",
                  route: Routes.favoritesScreen,
                  isActive: isFavorite,
                ),
                _buildNavbarItem(
                  context,
                  icon: "user.svg",
                  route: Routes.profileScreen,
                  isActive: isProfile,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavbarItem(
    BuildContext context, {
    required String icon,
    required String route,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          // animate to route que ça fasse comme un slide de droite à gauche
          // Navigator.pushNamed(context, route);
          // page builder
          Navigator.pushNamed(context, route);
        
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 24),
        width: 70,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isActive ? AppTheme.primaryColor : AppTheme.iconInactive,
              width: 1,
            ),
          ),
        ),
        child: SvgPicture.asset(
          'assets/icons/$icon',
          color: isActive ? AppTheme.primaryColor : AppTheme.iconInactive,
          height: 30,
        ),
      ),
    );
  }
}
