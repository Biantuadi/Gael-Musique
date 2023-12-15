import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:Gael/views/components/layouts/custom_navbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
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
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: (showAppBar)?AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.black,
        leading: const SizedBox(),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Iconsax.directbox_notif, color: Colors.white,))
        ],
        title: Text("Radio", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
      ) :null ,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              textRadio: true,
            ),
          ],
        ),
      ),
    );
  }
}
