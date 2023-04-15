import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone_app/home/upload_video/upload_form.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  getVideoFile(ImageSource source) async {
    final videoFile = await ImagePicker().pickVideo(source: source);

    if (videoFile != null) {
      // Video upload form
      Get.to(
        UploadForm(
          videoFile: File(videoFile.path),
          videoPath: videoFile.path,
        ),
      );
    }
  }

  displayDialogBox() {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    getVideoFile(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.image,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8,
                          ),
                          child: Text(
                            "Get Video from Gallery",
                            style: FontFamilyConstant.fontFamilyPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    getVideoFile(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.camera_alt,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8,
                          ),
                          child: Text(
                            "Capture video from Camera",
                            style: FontFamilyConstant.fontFamilyPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.cancel,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          8,
                        ),
                        child: Text(
                          "Cancel",
                          style: FontFamilyConstant.fontFamilyPrimary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/upload.png",
            width: 150,
          ),
          SizedBox(
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              child: ElevatedButton(
                onPressed: () {
                  // Display dialog box
                  displayDialogBox();
                },
                child: Text(
                  "Upload New Videos",
                  style: FontFamilyConstant.fontFamilyPrimary.copyWith(
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
