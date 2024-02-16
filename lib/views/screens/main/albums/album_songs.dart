import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/buttons/button_gradient.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'components/song_widget.dart';

class AlbumSongsScreen extends StatefulWidget{
  final Album album;
  const AlbumSongsScreen({super.key, required this.album});

  @override
  State<StatefulWidget> createState() {
    return AlbumSongsScreenState();
  }

}
class AlbumSongsScreenState extends State<AlbumSongsScreen>{
  ScrollController scrollController = ScrollController();

  bool showHeader = true;
  double value = 0;
  @override
  void initState() {
    super.initState();
    //Provider.of<SongProvider>(context, listen: false).getSongs();
    Provider.of<SongProvider>(context, listen: false).setCurrentAlbum(widget.album);
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
    return Consumer<SongProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
                        Navigator.pop(context);
                      },),
                      //title: Text(widget.album.title,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                      pinned: true,
                      backgroundColor:Colors.black,
                      actions: [
                        IconButton(onPressed: (){
                          provider.playShuffled();
                        }, icon:  Icon(Iconsax.shuffle, color:provider.playShuffledSong?ThemeVariables.primaryColor:Colors.white,)),
                        IconButton(onPressed: (){}, icon:const  Icon(CupertinoIcons.search, color: Colors.white,)),
                      ],
                    ),

                    SliverList.list(children: [
                      Container(
                        color: Colors.black,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NetWorkImageWidget(size: Size(size.width / 2, size.width * 0.5), imageUrl: widget.album.imgAlbum??"", radius: Dimensions.radiusSizeDefault,),
                                  SizedBox(width: Dimensions.spacingSizeDefault,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.album.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                                      Text(widget.album.artist, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),),
                                      Text("${provider.currentAlbumSongs!.length} singles", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),),
                                      SizedBox(height: Dimensions.spacingSizeDefault,),
                                      GradientButton(onTap: (){
                                          if(provider.currentSong != null){
                                              if(provider.audioPlayer.playing){
                                                provider.pauseSong();
                                              }else{
                                                provider.playSong();
                                              }
                                          }else{
                                            provider.setFirstSong();
                                            if(provider.audioPlayer.playing){
                                              provider.pauseSong();
                                            }else{
                                              provider.playSong();
                                            }
                                          }
                                      }, size: Size(size.width/5, 40), child: Text(provider.audioPlayer.playing?"Pause":"Lire", style: Theme.of(context).textTheme.titleSmall,))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),

                    provider.currentAlbumSongs!.isEmpty?

                    SliverPadding(
                      padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                      sliver:SliverList.list(children: [
                        Center(child: Text("Aucun chant trouvé", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),),
                      ]),
                    ) :SliverPadding(
                        padding: EdgeInsets.only(top : Dimensions.spacingSizeDefault),
                        sliver: SliverList.builder(
                            itemCount:provider.currentAlbumSongs!.length ,
                            itemBuilder: (BuildContext ctx, int i){
                              return SongWidget(song: provider.currentAlbumSongs![i],albumImgUrl: widget.album.imgAlbum??"", isPlaying: provider.thisSongIsCurrent( provider.currentAlbumSongs![i]),);
                            })),
                  ],
                ),
                provider.currentSong != null?
                Container(
                  margin: EdgeInsets.all(Dimensions.spacingSizeDefault),
                  child: Container(
                    width: size.width,
                    padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(provider.currentSong!.title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text("- ${provider.getSongReminder(provider.audioPlayer.duration ?? Duration.zero , provider.audioPlayer.position)}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                          ],
                        ),
                        //SizedBox(height: Dimensions.spacingSizeDefault,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Slider(
                                min: 0,
                                max:provider.audioPlayer.duration !=  null ?provider.audioPlayer.duration!.inSeconds.toDouble() :0,
                                thumbColor: Colors.white,
                                inactiveColor: ThemeVariables.thirdColorBlack,
                                activeColor: Colors.white,
                                value: provider.audioPlayer.position.inSeconds.toDouble() != 0.0?((provider.audioPlayer.position.inSeconds.toDouble() -1)): provider.audioPlayer.position.inSeconds.toDouble() ,
                                onChanged: (double value) {
                                  setState(() {
                                    if(provider.audioPlayer.position.inSeconds.toDouble()  < provider.audioPlayer.duration!.inSeconds.toDouble()){
                                      provider.seekSong(position: Duration(seconds: value.toInt()));
                                    }
                                  });

                                },
                              ),
                            ),
                            IconButton(onPressed: (){
                              if(provider.audioPlayer.playing){
                                provider.pauseSong();
                              }else {
                                provider.playSong();
                              }
                            }, icon: Icon( provider.audioPlayer.playing? Iconsax.pause :Iconsax.play, color: Colors.white,))
                          ],
                        )
                      ],
                    ),
                  ),
                ): const SizedBox(height: 0,)
              ],
            ),
          );
        }
    );
  }
}