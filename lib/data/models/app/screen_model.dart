import 'package:flutter/material.dart';

class ScreenModel {
  Widget content;
  IconData icon;
  IconData activeIcon;
  bool? isChatScreen;
  ScreenModel({required this.icon, required this.content,required this.activeIcon, this.isChatScreen});
}