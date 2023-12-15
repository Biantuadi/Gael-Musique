import 'package:flutter/material.dart';

class CustomNavBarItem extends StatefulWidget{
  final bool isSelected;
  final IconData iconData;
  final IconData selectedIconData;
  const CustomNavBarItem({super.key, required this.isSelected, required this.iconData, required this.selectedIconData});

  @override
  State<StatefulWidget> createState() {
    return CustomNavBarItemState();
  }

}
class CustomNavBarItemState extends State<CustomNavBarItem>{
  @override
  Widget build(BuildContext context) {
   return SizedBox(
     //height: double.infinity,
     //width: double.infinity,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
             Container(
               //width: double.infinity,
               height:widget.isSelected? 10 : 5,
               color: widget.isSelected? Colors.deepOrangeAccent : Colors.grey,
             ),
              Icon(widget.isSelected? widget.selectedIconData: widget.iconData, color: widget.isSelected? Colors.deepOrangeAccent : Colors.grey,)

       ],
     ),
   );
  }

}