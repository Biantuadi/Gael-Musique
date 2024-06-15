import 'package:Gael/data/providers/chat_provider.dart';
import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/data/providers/podcasts_provider.dart';
import 'package:Gael/data/providers/radio_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/screens/not_internet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Future noInternetCallBacks(BuildContext context)async{
  showCustomBottomSheet(
      context: context,
      content: NoInternetWidget(
        voidCallback: () async{
          await Provider.of<SongProvider>(context, listen: false).getSongsFromDB().then(
                  (value)async{
                await Provider.of<SongProvider>(context, listen: false).getAlbumsFromDB().then((value)async{
                });
              }
          );
          await Provider.of<EventsProvider>(context, listen: false).getEventsFromDB();
          await Provider.of<ChatProvider>(context, listen: false).getUsersFromDB();
          await Provider.of<ChatProvider>(context, listen: false).getUsersFromDB();

        },
      ));
}
Future internetCallBacks(BuildContext context)async{
  Future getSongs()async{
    Provider.of<SongProvider>(context, listen: false).getSongsFromApi().then(
            (value)async{
          Provider.of<SongProvider>(context, listen: false).getAlbums().then((value)async{
          });
        }
    );
  }

  await Future.wait(
    [
      getSongs(),
      Provider.of<EventsProvider>(context, listen: false).getEventsFromAPi(),
      Provider.of<RadiosProvider>(context, listen: false).getRadiosFromAPi(),
      Provider.of<PodcastsProvider>(context, listen: false).getPodcastsFromAPi(),
      Provider.of<ChatProvider>(context, listen: false).getUsersFromApi(),
      Provider.of<StreamingProvider>(context, listen: false).getStreaming(),
      Provider.of<ChatProvider>(context, listen: false).getUsersFromApi()
  ]
  );

}