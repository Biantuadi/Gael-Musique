import 'package:Gael/data/models/stream_and_song_related.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'components/song_widget.dart';
import 'components/streaming_filter_widget.dart';
import '../../../components/streaming_widget.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen({super.key});

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  ScrollController scrollController = ScrollController();

  List<Widget> pageContent=[];
  List<SongAndStreamRelated> songAndStreams=[];
  List<SongAndStreamRelated> songsOnly=[];
  List<SongAndStreamRelated> streamOnly=[];
  bool showOnlySongs = false;
  bool showOnlyStreaming = false;
  bool showAll = true;

  bool showHeader = true;
  @override
  void initState() {
    super.initState();
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
    scrollController.addListener(loadMore);
    getData();
  }
  setShowSongsOnly(){
    setState(() {
      showAll = false;
      showOnlyStreaming = false;
      showOnlySongs = true;
    });
  }
  setShowAll(){
    setState(() {
      showAll = true;
      showOnlyStreaming = false;
      showOnlySongs = false;
    });
  }

  setShowStreamingOnly(){
    setState(() {
      showAll = false;
      showOnlyStreaming = true;
      showOnlySongs = false;
    });
  }

  getData(){
    Provider.of<StreamingProvider>(context, listen: false).allStreaming.forEach((stream) {
      songAndStreams.add(SongAndStreamRelated(isValid: true, streaming: stream));
      streamOnly.add(SongAndStreamRelated(isValid: true, streaming: stream));
    });
    Provider.of<SongProvider>(context, listen: true).allSongs.forEach((song) {
      songAndStreams.add(SongAndStreamRelated(isValid: true, song: song));
      songsOnly.add(SongAndStreamRelated(isValid: true, song: song));
    });
    songAndStreams.sort((a, b)=> a.getCreatedDate()!.microsecondsSinceEpoch.compareTo(b.getCreatedDate()!.microsecondsSinceEpoch));

  }
  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      Provider.of<StreamingProvider>(context, listen: true).incrementCurrentPage();
      Provider.of<SongProvider>(context, listen: true).incrementCurrentPage();
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
       return Consumer3<StreamingProvider, SongProvider, SocketProvider>(
        builder: (BuildContext context, streamProvider, songProvider, socketProvider,Widget? child) {
        return Scaffold(
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList.list(children: [ Container(
                color: ThemeVariables.thirdColorBlack,
                padding: EdgeInsets.only(
                    top: Dimensions.spacingSizeDefault * 3,
                    left: Dimensions.spacingSizeDefault
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.spacingSizeDefault
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Voyagez \n',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'avec nos playlists',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )]),
              SliverAppBar(
                flexibleSpace:  Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: Dimensions.spacingSizeDefault),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      children: [
                        SizedBox(width: Dimensions.spacingSizeDefault,),
                        StreamingFilter(title: 'Tous', onTap: () {
                          setShowAll();
                        }, isSelected: streamProvider.setShowAll(),),
                        StreamingFilter(title: 'Chants', onTap: () {
                          setShowSongsOnly();
                        }, isSelected: streamProvider.showSongs,),
                        StreamingFilter(title: 'Streaming', onTap: () {
                          setShowStreamingOnly();
                        }, isSelected: streamProvider.showEmission,),
                        SizedBox(width: Dimensions.spacingSizeDefault,)
                      ],
                    ),
                  ),
                ),
                pinned: true,
                backgroundColor:ThemeVariables.thirdColorBlack,
              ),
              SliverList.list(children: [
                Container(
                  padding: EdgeInsets.only(
                    top : Dimensions.spacingSizeDefault,
                    left : Dimensions.spacingSizeDefault,
                  ),
                  child:Text("Revivez ces moments", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                ),
              ]),
              SliverPadding(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.spacingSizeDefault, mainAxisSpacing: Dimensions.spacingSizeDefault, childAspectRatio: .8),
                  itemBuilder: (BuildContext ctx, int index){
                    if(streamProvider.streamingToShow == null){
                      return  Container(
                        width: size.width,
                        height: size.width * 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                        ),
                      );
                    }
                    if(showOnlyStreaming){
                      return StreamingWidget(streaming: streamOnly[index].streaming!,);
                    }
                    if(showOnlySongs){
                      return StreamSongWidget(song: songsOnly[index].song!, provider: songProvider, size: Size(size.width *0.8, size.width *2),);
                    }
                    SongAndStreamRelated songAndStreamRelated = songAndStreams[index];
                    if(songAndStreamRelated.streamIsNotNull()){
                      return StreamingWidget(streaming: streamOnly[index].streaming!,);
                    }
                    if(songAndStreamRelated.songIsNotNull()){
                      return StreamSongWidget(song: songsOnly[index].song!, provider: songProvider, size: Size(size.width *0.8, size.width *2),);
                    }
                    return Container();
                  },
                  itemCount: showAll? songAndStreams.length : showOnlySongs? songsOnly.length : showOnlyStreaming? streamOnly.length : 0,
                ),
              ),

              SliverList.list(children: [
                (streamProvider.isLoadingData || songProvider.isLoadingData)?
                    CircularProgressIndicator(color: Colors.orange, strokeWidth: 1,):const SizedBox()
              ])

            ],
          ),
        );
      }
    );
  }
}
