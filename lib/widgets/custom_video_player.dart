import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoFileUrl;
  const CustomVideoPlayer({Key? key, required this.videoFileUrl}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {

  VideoPlayerController? videoPlayerController;


  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoFileUrl)
    ..initialize().then((value) {
      videoPlayerController!.play();
      videoPlayerController!.setVolume(2);
      videoPlayerController!.setLooping(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black
      ),
      child: VideoPlayer(
        videoPlayerController!
      ),
    );
  }
}
