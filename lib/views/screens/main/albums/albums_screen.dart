// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'components/album_widget.dart';

class AlbumScreen extends StatefulWidget{
  const AlbumScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlbumScreenState();
  }
}

class AlbumScreenState extends State<AlbumScreen>{
  ScrollController scrollController = ScrollController();

  bool showHeader = true;
  @override
  void initState() {
    super.initState();
    Provider.of<SongProvider>(context, listen: false).getSongsFromApi();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          showHeader = false;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showHeader = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer2<SongProvider, StreamingProvider>(
        builder: (BuildContext context, songProvider,streamingProvider, Widget? child) {
          if(streamingProvider.videoPlayerHasBeenInitialized){
            if(streamingProvider.podPlayerController.isVideoPlaying && (songProvider.audioPlayer.playing || songProvider.songIsPlaying)){
              songProvider.pauseSong();
            }
          }
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
                  Navigator.pop(context);
                },),
                title: Text("Albums",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                pinned: true,
                backgroundColor:ThemeVariables.thirdColorBlack,
                actions: [
                ],
              ),

              SliverPadding(
                padding: EdgeInsets.only(top :Dimensions.spacingSizeDefault),
                sliver:SliverList.list(children: songProvider.allAlbums.map((album) => AlbumWidget(album: album,)).toList()),

              )
            ],
          );
        }
    );
  }
}