import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => CchatDetailScreenState();
}

class CchatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Map<String?, dynamic> data =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print(ModalRoute.of(context)!.settings.arguments);
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: Row(
          children: [
            const NetWorkImageWidget(imageUrl: 'https://picsum.photos/250?image=10', size:  const Size(45, 45),),
            SizedBox(width: Dimensions.spacingSizeDefault,),
            Text("Gael music", style: Theme.of(context).textTheme.titleMedium,)
          ],
        ),
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
