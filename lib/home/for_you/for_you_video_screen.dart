import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/home/for_you/controller/for_you_videos_controller.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';
import 'package:tiktok_clone_app/widgets/custom_video_player.dart';

class ForYouVideoScreen extends StatefulWidget {
  const ForYouVideoScreen({super.key});

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  final ForYouVideosController controllerVideosForYou = Get.put(ForYouVideosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return PageView.builder(
          itemCount: controllerVideosForYou.forYouAllVideosList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            final eachVideoInfo = controllerVideosForYou.forYouAllVideosList[index];

            return Stack(
              children: [
                // Display Video
                CustomVideoPlayer(videoFileUrl: eachVideoInfo.videoUrl.toString(),)
              ],
            );
          },
        );
      })
    );
  }
}
