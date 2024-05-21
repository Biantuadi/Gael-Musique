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
  Set<DiscoverModelsRelated> dataToShow={};
  Set<DiscoverModelsRelated> songsOnly={};
  Set<DiscoverModelsRelated> streamOnly={};
  Set<DiscoverModelsRelated> radiosOnly={};
  Set<DiscoverModelsRelated> podcastsOnly={};
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
      showOnlyRadios = false;
      showOnlyPodcasts = false;
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
      showOnlyRadios = false;
      showOnlyPodcasts = false;
    });
  }
  setShowStreamingOnly(){
    setState(() {
      showAll = false;
      showOnlyStreaming = true;
      showOnlySongs = false;
      showOnlyRadios = false;
      showOnlyPodcasts = false;
    });
  }

  getData()async{
    await Provider.of<StreamingProvider>(context, listen: false).getStreaming();
      Provider.of<StreamingProvider>(context, listen: false).allStreaming!.forEach((stream) {
        if((!dataToShow.contains(DiscoverModelsRelated(streaming: stream)) && !streamOnly.contains(DiscoverModelsRelated(streaming: stream)))){
          dataToShow.add(DiscoverModelsRelated(streaming: stream));
          streamOnly.add(DiscoverModelsRelated( streaming: stream));
        }

      });
    await Provider.of<SongProvider>(context, listen: false).getSongsFromApi();
      Provider.of<SongProvider>(context, listen: false).allSongs!.forEach((song) {
        if((!dataToShow.contains(DiscoverModelsRelated( song: song)) && !songsOnly.contains(DiscoverModelsRelated( song: song))) ){
          dataToShow.add(DiscoverModelsRelated( song: song));
          songsOnly.add(DiscoverModelsRelated( song: song));
        }
      });

    await Provider.of<PodcastsProvider>(context, listen: false).getPodcastsFromAPi();
      Provider.of<PodcastsProvider>(context, listen: false).podcasts!.forEach((podcast) {
        if((!dataToShow.contains(DiscoverModelsRelated(podcast: podcast)) && !podcastsOnly.contains(DiscoverModelsRelated(podcast: podcast)))){
          dataToShow.add(DiscoverModelsRelated(podcast: podcast));
          podcastsOnly.add(DiscoverModelsRelated( podcast: podcast));
        }
      });

   await Provider.of<RadiosProvider>(context, listen: false).getRadiosFromAPi();
      Provider.of<RadiosProvider>(context, listen: false).radios!.forEach((radio) {

        if((!dataToShow.contains(DiscoverModelsRelated(radio: radio)) && !radiosOnly.contains(DiscoverModelsRelated(radio: radio)))){
          dataToShow.add(DiscoverModelsRelated(radio: radio));
          streamOnly.add(DiscoverModelsRelated( radio: radio));
        }

      });

    dataToShow.toList().sort((a, b)=> a.getCreatedDate()!.microsecondsSinceEpoch.compareTo(b.getCreatedDate()!.microsecondsSinceEpoch));


  }
  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      Provider.of<StreamingProvider>(context, listen: true).incrementCurrentPage();
      Provider.of<SongProvider>(context, listen: true).incrementCurrentPage();
      Provider.of<RadiosProvider>(context, listen: true).incrementCurrentPage();
      Provider.of<PodcastsProvider>(context, listen: true).incrementCurrentPage();
      getData();
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
                leading: Container(),
                leadingWidth: 0,
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
                      return StreamingWidget(streaming: streamOnly.toList()[index].streaming!,);
                    }
                    if(showOnlySongs){
                      return StreamSongWidget(song: songsOnly.toList()[index].song!, provider: songProvider, size: Size(size.width *0.8, size.width *2),);
                    }
                    DiscoverModelsRelated discoverRelated = dataToShow.toList()[index];
                    if(discoverRelated.streamIsNotNull()){
                      return StreamingWidget(streaming: discoverRelated.streaming!,);
                    }
                    if(discoverRelated.songIsNotNull()){
                      return StreamSongWidget(song: dataToShow.toList()[index].song!, provider: songProvider, size: Size(size.width *0.8, size.width *2),);
                    }
                    if(discoverRelated.radioIsNotNull()){
                      return RadioWidget(radio: dataToShow.toList()[index].radio!,);
                    }
                    if(discoverRelated.podcastIsNotNull()){
                      return PodcastWidget(podcast: dataToShow.toList()[index].podcast!,);
                    }
                    return Container(

                    );
                  },
                  itemCount: showAll? dataToShow.length : showOnlySongs? songsOnly.length : showOnlyStreaming? streamOnly.length: showOnlyRadios? radiosOnly.length: showOnlyPodcasts? podcastsOnly.length : 0,
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
                nothingToshowWidget((showAll && dataToShow.isEmpty)),
                nothingToshowWidget((showOnlySongs && songsOnly.isEmpty)),
                nothingToshowWidget((showOnlyStreaming && streamOnly.isEmpty)),
                nothingToshowWidget((showOnlyRadios && radiosOnly.isEmpty)),
                nothingToshowWidget((showOnlyPodcasts && podcastsOnly.isEmpty)),

              ])

            ],
          ),
        );
      }
    );
  }
  Widget nothingToshowWidget(bool condition) {
    return condition ? Center(
      child: Text("Nothing to show", style: Theme
          .of(context)
          .textTheme
          .bodySmall,),
    ) : Container();
  }
}
