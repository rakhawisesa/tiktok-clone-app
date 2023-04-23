import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/home/comments/comments_screen.dart';
import 'package:tiktok_clone_app/home/for_you/controller/for_you_videos_controller.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';
import 'package:tiktok_clone_app/widgets/circular_image_animation.dart';
import 'package:tiktok_clone_app/widgets/custom_video_player.dart';

class ForYouVideoScreen extends StatefulWidget {
  const ForYouVideoScreen({super.key});

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  final ForYouVideosController controllerVideosForYou =
      Get.put(ForYouVideosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return PageView.builder(
        itemCount: controllerVideosForYou.forYouAllVideosList.length,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final eachVideoInfo =
              controllerVideosForYou.forYouAllVideosList[index];

          return Stack(
            children: [
              // Display Video
              CustomVideoPlayer(
                videoFileUrl: eachVideoInfo.videoUrl.toString(),
              ),

              // Panels
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Left Panel
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // USERNAME
                                Text(
                                  "@${eachVideoInfo.userName}",
                                  style: FontFamilyConstant.fontFamilyPrimary
                                      .copyWith(
                                    fontWeight: FontWeightManager.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),

                                // DESCRIPTION TAGS
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    eachVideoInfo.descriptionTags.toString(),
                                    style: FontFamilyConstant
                                        .fontFamilySecondary
                                        .copyWith(
                                      fontWeight: FontWeightManager.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),

                                // ARTIST SONG NAME
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/music-note-white.png",
                                      width: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        eachVideoInfo.artistSongName.toString(),
                                        style: FontFamilyConstant
                                            .fontFamilySecondary
                                            .copyWith(
                                          fontWeight: FontWeightManager.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        // Right Panel
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // PROFILE
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: 62,
                                  height: 62,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 4,
                                        child: Container(
                                          width: 52,
                                          height: 52,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image(
                                              image: NetworkImage(
                                                eachVideoInfo.userProfileImage
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // LIKES BUTTON & TOTAL LIKE
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controllerVideosForYou.likeOrUnlikeVideo(
                                          eachVideoInfo.videoID.toString());
                                    },
                                    icon: Icon(
                                      Icons.favorite_rounded,
                                      size: 40,
                                      color: eachVideoInfo.likesList!.contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      eachVideoInfo.likesList!.length
                                          .toString(),
                                      style: FontFamilyConstant
                                          .fontFamilySecondary
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),

                              // COMMENTS BUTTON & TOTAL COMMENTS
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.to(CommentsScreen(
                                        videoID:
                                            eachVideoInfo.videoID.toString(),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.add_comment,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      eachVideoInfo.totalComments.toString(),
                                      style: FontFamilyConstant
                                          .fontFamilySecondary
                                          .copyWith(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),

                              // SHARE BUTTON & TOTAL SHARES
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.share,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      eachVideoInfo.totalShares.toString(),
                                      style: FontFamilyConstant
                                          .fontFamilySecondary
                                          .copyWith(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),

                              // PROFILE CIRCULAR ANIMATION
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CircularImageAnimation(
                                  widgetAnimation: SizedBox(
                                    width: 62,
                                    height: 62,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.grey,
                                                Colors.white,
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Image(
                                              image: NetworkImage(
                                                eachVideoInfo.userProfileImage
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        },
      );
    }));
  }
}
