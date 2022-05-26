import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_start/models/movie.dart';
import 'package:project_start/provider/movie_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class DetailPage extends StatelessWidget {
final Movie movie;
DetailPage(this.movie);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        print('hello');
        return true;
      },
      child: Scaffold(
          body: Consumer(
            builder: (context, ref, child) {
              final videoData = ref.watch(videoProvider(movie.id));
              return ListView(
                children: [
                  videoData.when(
              data: (data){
                return  YoutubePlayer(
                  controller:  YoutubePlayerController(
                  initialVideoId: data,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                  ),
                  ),
                  showVideoProgressIndicator: true,

                );
              },
                  error: (err, stack) => Text('$err'),
                  loading: () => Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                  )
              ),

                ],
              );
            }
          )
      ),
    );
  }
}


