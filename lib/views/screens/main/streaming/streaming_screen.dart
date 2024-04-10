import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'components/streaming_filter_widget.dart';
import '../../../components/streaming_widget.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen({super.key});

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  ScrollController scrollController = ScrollController();

  bool showHeader = true;
  @override
  void initState() {
    super.initState();
    Provider.of<StreamingProvider>(context, listen: false).getStreaming();

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
  }
  void loadMore(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      Provider.of<StreamingProvider>(context, listen: true).incrementCurrentPage();
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SocketProvider socketProvider = Provider.of<SocketProvider>(context, listen: true);
    return Consumer<StreamingProvider>(
        builder: (BuildContext context, provider, Widget? child) {
        return CustomScrollView(
            controller: scrollController,
            slivers: [
             SliverList.list(children: [ Container(
               color: ThemeVariables.thirdColorBlack,
               padding: EdgeInsets.only(
                    top: Dimensions.spacingSizeDefault * 3,
                    left: Dimensions.spacingSizeDefault
               ),
               // child: Text("Faites votre choix ou passez sur la radio",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),

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

                        StreamingFilter(title: 'Chants', onTap: () {
                          provider.setShowSongs();
                        }, isSelected: provider.showSongs,),
                        StreamingFilter(title: 'Podcast', onTap: () {
                          provider.setShowPodCasts();
                        }, isSelected: provider.showPodCast,),
                        StreamingFilter(title: 'Radios', onTap: () {
                          provider.setShowRadios();
                        }, isSelected: provider.showRadio,),
                        
                        StreamingFilter(title: 'Emissions', onTap: () {
                          provider.setShowEmissions();
                        }, isSelected: provider.showEmission,),

                        StreamingFilter(title: 'Sanjolas', onTap: () {
                          provider.setShowSanjola();
                        }, isSelected: provider.showSanjola,),

                        
                        
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
                    if(provider.streamingToShow == null){
                      return  Container(
                        width: size.width,
                        height: size.width * 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                        ),
                      );
                    }
                    return StreamingWidget(streaming: provider.streamingToShow![index],);
                  },
                  itemCount: provider.streamingToShow!.length,
                ),
              )
            ],
          );
      }
    );
  }
}
