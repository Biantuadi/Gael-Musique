import 'package:Gael/data/models/app/discover_models_related.dart';
import 'package:Gael/data/providers/podcasts_provider.dart';
import 'package:Gael/data/providers/radio_provider.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/screens/main/streaming/components/podcastWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'components/radio_widget.dart';
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
  List<DiscoverModelsRelated> songAndStreams=[];
  List<DiscoverModelsRelated> songsOnly=[];
  List<DiscoverModelsRelated> streamOnly=[];
  List<DiscoverModelsRelated> radiosOnly=[];
  List<DiscoverModelsRelated> podcastsOnly=[];
  bool showOnlySongs = false;
  bool showOnlyStreaming = false;
  bool showOnlyPodcasts = false;
  bool showOnlyRadios = false;
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
  setShowPodcastsOnly(){
    setState(() {
      showAll = false;
      showOnlyStreaming = false;
      showOnlySongs = false;
      showOnlyRadios = false;
      showOnlyPodcasts = true;
    });
  }
  setShowRadiosOnly(){
    setState(() {
      showAll = false;
      showOnlyStreaming = false;
      showOnlySongs = false;
      showOnlyRadios = true;
      showOnlyPodcasts = false;
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
    Provider.of<StreamingProvider>(context, listen: false).allStreaming!.forEach((stream) {
      songAndStreams.add(DiscoverModelsRelated(streaming: stream));
      streamOnly.add(DiscoverModelsRelated( streaming: stream));
    });
    Provider.of<SongProvider>(context, listen: false).allSongs.forEach((song) {
      songAndStreams.add(DiscoverModelsRelated( song: song));
      songsOnly.add(DiscoverModelsRelated( song: song));
    });
    songAndStreams.sort((a, b)=> a.getCreatedDate()!.microsecondsSinceEpoch.compareTo(b.getCreatedDate()!.microsecondsSinceEpoch));

    Provider.of<PodcastsProvider>(context, listen: false).podcasts!.forEach((podcast) {
      songAndStreams.add(DiscoverModelsRelated(podcast: podcast));
      podcastsOnly.add(DiscoverModelsRelated( podcast: podcast));
    });

    Provider.of<RadiosProvider>(context, listen: false).radios!.forEach((radio) {
      songAndStreams.add(DiscoverModelsRelated(radio: radio));
      streamOnly.add(DiscoverModelsRelated( radio: radio));
    });

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
       return Consumer5<StreamingProvider, SongProvider, SocketProvider, PodcastsProvider, RadiosProvider>(
        builder: (BuildContext context, streamProvider, songProvider, socketProvider,podcastsProvider, radiosProvider, Widget? child) {
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
                        }, isSelected: showAll,),
                        StreamingFilter(title: 'Chants', onTap: () {
                          setShowSongsOnly();
                        }, isSelected: showOnlySongs,),
                        StreamingFilter(title: 'Streaming', onTap: () {
                          setShowStreamingOnly();
                        }, isSelected: showOnlyStreaming,),
                        StreamingFilter(title: 'Podcats', onTap: () {
                          setShowPodcastsOnly();
                        }, isSelected: showOnlyPodcasts,),
                        StreamingFilter(title: 'Radios', onTap: () {
                          setShowRadiosOnly();
                        }, isSelected: showOnlyRadios,),
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
                    if(showOnlyStreaming){
                      return StreamingWidget(streaming: streamOnly[index].streaming!,);
                    }
                    if(showOnlySongs){
                      return StreamSongWidget(song: songsOnly[index].song!, provider: songProvider, size: Size(size.width *0.8, size.width *2),);
                    }
                    DiscoverModelsRelated discoverRelated = songAndStreams[index];
                    if(discoverRelated.streamIsNotNull()){
                      return StreamingWidget(streaming: songAndStreams[index].streaming!,);
                    }
                    if(discoverRelated.songIsNotNull()){
                      return StreamSongWidget(song: songAndStreams[index].song!, provider: songProvider, size: Size(size.width *0.8, size.width *2),);
                    }
                    if(discoverRelated.radioIsNotNull()){
                      return RadioWidget(radio: songAndStreams[index].radio!,);
                    }
                    if(discoverRelated.podcastIsNotNull()){
                      return PodcastWidget(podcast: songAndStreams[index].podcast!,);
                    }

                    return Container(

                    );
                  },
                  itemCount: showAll? songAndStreams.length : showOnlySongs? songsOnly.length : showOnlyStreaming? streamOnly.length: showOnlyRadios? radiosOnly.length: showOnlyPodcasts? podcastsOnly.length : 0,
                ),
              ),


              SliverList.list(children: [

                (streamProvider.isLoadingData || songProvider.isLoadingData || radiosProvider.isLoadingData || podcastsProvider.isLoadingData)?
                    Center(
                      child: SizedBox(
                        height: Dimensions.iconSizeDefault,
                        width: Dimensions.iconSizeDefault,
                          child: const CircularProgressIndicator(color: ThemeVariables.primaryColor, strokeWidth: 1,)),
                    ):const SizedBox(),


                (showAll || showOnlySongs ||  showOnlyStreaming || showOnlyRadios|| showOnlyPodcasts)?
                Center(
                  child: Text("Nothing to show", style: Theme.of(context).textTheme.bodySmall,),
                ) : Container()



              ])

            ],
          ),
        );
      }
    );
  }
}
