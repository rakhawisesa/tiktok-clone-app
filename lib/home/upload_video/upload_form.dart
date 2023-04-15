import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone_app/global.dart';
import 'package:tiktok_clone_app/home/upload_video/controller/upload_controller.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';
import 'package:tiktok_clone_app/widgets/input_text_widget.dart';
import 'package:video_player/video_player.dart';

class UploadForm extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const UploadForm(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  UploadController uploadController = Get.put(UploadController());
  VideoPlayerController? playerController;
  TextEditingController artistController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    playerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: VideoPlayer(playerController!),
            ),
            const SizedBox(
              height: 30,
            ),
            showProgressBar == true
                ? Container(
                    child: const SimpleCircularProgressBar(
                      progressColors: [
                        Colors.white,
                      ],
                      animationDuration: 20,
                      backColor: Colors.white30,
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: InputTextWidget(
                          controller: artistController,
                          labelString: "Artist - Song",
                          isObscure: false,
                          icon: Icons.music_video_sharp,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: InputTextWidget(
                          controller: descriptionController,
                          labelString: "Description - Tags",
                          isObscure: false,
                          icon: Icons.slideshow_sharp,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 55,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (artistController.text.isNotEmpty &&
                                descriptionController.text.isNotEmpty) {
                              uploadController
                                  .saveVideoInformationToFirestoreDatabase(
                                artistController.text,
                                descriptionController.text,
                                widget.videoPath,
                                context,
                              );
                              setState(() {
                                showProgressBar = true;
                              });
                            }
                          },
                          child: Center(
                            child: Text(
                              "Upload Now",
                              style:
                                  FontFamilyConstant.fontFamilyPrimary.copyWith(
                                fontSize: FontSizeManager.f18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
