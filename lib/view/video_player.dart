import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:mindglowequinox/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayer({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId == null) {
      setState(() {
        _isError = true;
      });
    } else {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onVerticalDragDown: (details) => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Appcolor.grey,
        body: Center(
          child: _isError
              ? const Text(
                  'Video not found',
                  style: TextStyle(fontSize: 18, color: Appcolor.red),
                )
              : YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {},
                ),
        ),
      ),
    );
  }
}
