import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/screens/main/albums/components/album_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
    Provider.of<SongProvider>(context, listen: false).getSongs();
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
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                leading: IconButton(icon: const Icon(Iconsax.arrow_left, ), onPressed: (){
                  Navigator.pop(context);
                },),
                title: Text(widget.album.title,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                pinned: true,
                backgroundColor:ThemeVariables.thirdColorBlack,
              ),
              SliverList.list(children:provider.allAlbums.map((album) => AlbumWidget(album: album,)).toList()),

              SliverPadding(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.spacingSizeDefault, mainAxisSpacing: Dimensions.spacingSizeDefault, childAspectRatio: .8),
                  itemBuilder: (BuildContext ctx, int index){
                    if(provider.albumsToShow == null){
                      return  Container(
                        width: size.width,
                        height: size.width * 2,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
                        ),
                      );
                    }
                    return Container();
                  },
                  itemCount: provider.allAlbums.length,
                ),
              )
            ],
          );
        }
    );
  }
}