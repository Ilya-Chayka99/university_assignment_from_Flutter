
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:university_assignment/features/task_5/box.dart';
import 'package:university_assignment/features/task_5/playlist_provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});
  String formatTime(Duration duration){
    String twoDigitsSecond = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:$twoDigitsSecond";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context,value,child) {
        final playlist = value.playlist;
        final currSong = playlist[value.currSongIndex ?? 0];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 29, 28, 22),
             iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
                centerTitle: true,
            title: const Text("Проигрыватель",style:TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w700,
            ),),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(currSong.albumArtImagePath)
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currSong.songName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                                  Text(currSong.artistName,style: const TextStyle(color: Colors.white),),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                         Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formatTime(value.curDuration),style: const TextStyle(color: Colors.white),),
                              const Icon(Icons.shuffle,color: Color.fromARGB(0, 255, 255, 255),),
                              const Icon(Icons.repeat,color: Color.fromARGB(0, 255, 255, 255),),
                              Text(formatTime(value.totalDuration),style: const TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                        Slider(
                          max: value.totalDuration.inSeconds.toDouble(),
                          min: 0,
                          value: value.curDuration.inSeconds.toDouble(), 
                          activeColor: Colors.green,
                          onChanged: (double double){

                        },
                        onChangeEnd: (double double) {
                          value.seek(Duration(seconds: double.toInt()));
                        },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playPreviosSong,
                            child: const Box(
                              child: Icon(Icons.skip_previous,color: Colors.white,)
                            )
                          )
                        ),
                        const SizedBox(width: 25,),
                         Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: Box(
                              child: Icon(value.isPlaying? Icons.pause:Icons.play_arrow,color: Colors.white,)
                            )
                          )
                        ),
                        const SizedBox(width: 25,),
                         Expanded(
                          child: GestureDetector(
                            onTap: value.playNextSong,
                            child: const Box(
                              child: Icon(Icons.skip_next,color: Colors.white,)
                            )
                          )
                        ),
                      ],
                  ),
                  
                  
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}