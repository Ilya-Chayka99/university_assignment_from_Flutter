
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:university_assignment/features/task_5/song.dart';

class PlayListProvider extends ChangeNotifier{
  final List<Song> _playlist = [
    Song(
      songName: "Лесник", 
      artistName: 'Король и Шут', 
      albumArtImagePath: 'lib/assets/images/488471.jpg', 
      audioPath: 'https://rus.hitmotop.com/get/music/20190305/Korol_i_SHut_-_Lesnik_62571704.mp3'
    ),
    Song(
      songName: "Кукла колдуна", 
      artistName: 'Король и Шут', 
      albumArtImagePath: 'lib/assets/images/488389.jpg', 
      audioPath: 'https://rus.hitmotop.com/get/music/20190305/Korol_i_SHut_-_Kukla_kolduna_62570545.mp3'
    ),
    Song(
      songName: "Снежинки", 
      artistName: 'Finik.Finya, ALEKS ATAMAN', 
      albumArtImagePath: 'lib/assets/images/697897.jpg', 
      audioPath: 'https://rus.hitmotop.com/get/music/20211210/FinikFinya_ALEKS_ATAMAN_-_Snezhinki_73461611.mp3'
    ),
    Song(
      songName: "МАЛИНОВАЯ ЛАДА", 
      artistName: 'GAYAZOV\$ BROTHER\$', 
      albumArtImagePath: 'lib/assets/images/1.jpg', 
      audioPath: 'https://rus.hitmotop.com/get/music/20211024/GAYAZOV_BROTHER_-_MALINOVAYA_LADA_73214200.mp3'
    ),
    Song(
      songName: "Как ты там?", 
      artistName: 'Андрей Леницкий, Nebezao', 
      albumArtImagePath: 'lib/assets/images/2.jpg', 
      audioPath: 'https://rus.hitmotop.com/get/music/20190914/Nebezao_Andrejj_Lenickijj_-_Kak_ty_tam_66566830.mp3'
    ),
    Song(
      songName: "Нефертити", 
      artistName: 'Ицык Цыпер, Игорь цыба', 
      albumArtImagePath: 'lib/assets/images/3.jpg', 
      audioPath: 'https://rus.hitmotop.com/get/music/20240201/Icyk_Cyper_Igor_Cyba_-_Nefertiti_77373131.mp3'
    ),
    Song(
      songName: "Пьяный туман", 
      artistName: 'GAYAZOV\$ BROTHER\$', 
      albumArtImagePath: 'lib/assets/images/4.jpg', 
      audioPath: 'https://rus.hitmotop.com/get/music/20190315/GAYAZOV_BROTHER_-_Pyanyjj_tuman_62788609.mp3'
    ),
  ];

  int? _currSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlayListProvider(){
    listenToDuration();
  }
  bool _isPlaying = false;

  void play()async{
    final String path = _playlist[_currSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause()async{
    await _audioPlayer.pause();
    _isPlaying =false;
    notifyListeners();
  }

  void resume()async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume()async{
    if(_isPlaying){
      pause();
    }else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position)async{
    await _audioPlayer.seek(position);
  }

  void playNextSong(){
    if(_currSongIndex != null){
      if(_currSongIndex! < _playlist.length-1){
        _currSongIndex = _currSongIndex! + 1;
      } else{
        _currSongIndex = 0;
      }
      play();
    }
  }

  void playPreviosSong(){
    if(_currSongIndex != null){
      if(_currDuration.inSeconds > 2){
        _currDuration = Duration.zero;
      } else{
        if(_currSongIndex! > 0){
          _currSongIndex = _currSongIndex! - 1;
        }else{
          _currSongIndex = _playlist.length-1;
        }
      }
      play();
    }
  }

  void listenToDuration(){
    _audioPlayer.onDurationChanged.listen((event) {
      _totalDuration = event;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((event) {
      _currDuration = event;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currSongIndex => _currSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get curDuration => _currDuration;
  Duration get totalDuration => _totalDuration;

  set currSongIndex(int? index){
    _currSongIndex = index;
    if(index !=null){
      play();
    }
    notifyListeners();
  }
}