import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/global.dart';
import 'package:tiktok_clone_app/home/profile/controller/profile_controller.dart';
import 'package:tiktok_clone_app/settings/account_settings_screen.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';
import 'package:tiktok_clone_app/theme_manager/image_icon_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  final String? visitUserID;
  const ProfileScreen({super.key, this.visitUserID});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateCurrentUserID(widget.visitUserID.toString());
  }

  Future<void> launchUserSocialProfile(String socialLink) async {
    if (!await launchUrl(Uri.parse("https://$socialLink"))) {
      throw Exception("Could not launch $socialLink");
    }
  }

  handleClickEvent(String choiceClicked) {
    switch (choiceClicked) {
      case "Settings":
        Get.to(const AccountSettingsScreen());
        break;
      case "Logout":
        FirebaseAuth.instance.signOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) {
        if (profileController.userMap.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: Text(
              profileController.userMap["userName"],
              style: FontFamilyConstant.fontFamilyPrimary.copyWith(
                fontWeight: FontWeightManager.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              widget.visitUserID == currentUserID
                  ? PopupMenuButton<String>(
                      onSelected: handleClickEvent,
                      itemBuilder: (BuildContext context) {
                        return {"Settings", "Logout"}
                            .map((String choiceClicked) {
                          return PopupMenuItem(
                            value: choiceClicked,
                            child: Text(choiceClicked),
                          );
                        }).toList();
                      },
                    )
                  : Container(),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // User Profile Image
                  ClipOval(
                    // CircleAvatar() cara lain selain ClipOval()
                    child: Image.network(
                      profileController.userMap["userImage"],
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  // Followers - Following - Likes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Following
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              profileController.userMap["totalFollowings"],
                              style:
                                  FontFamilyConstant.fontFamilyPrimary.copyWith(
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Following",
                              style:
                                  FontFamilyConstant.fontFamilyPrimary.copyWith(
                                fontWeight: FontWeightManager.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black54,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),

                      // Followers
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              profileController.userMap["totalFollowers"],
                              style:
                                  FontFamilyConstant.fontFamilyPrimary.copyWith(
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Followers",
                              style:
                                  FontFamilyConstant.fontFamilyPrimary.copyWith(
                                fontWeight: FontWeightManager.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black54,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),

                      // Likes
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              profileController.userMap["totalLikes"],
                              style:
                                  FontFamilyConstant.fontFamilyPrimary.copyWith(
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Likes",
                              style:
                                  FontFamilyConstant.fontFamilyPrimary.copyWith(
                                fontWeight: FontWeightManager.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // Social Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Facebook
                      GestureDetector(
                        onTap: () {
                          if (profileController.userMap["userFacebook"] == "") {
                            Get.snackbar("Facebook Profile",
                                "This user has not set Facebook link");
                          } else {
                            launchUserSocialProfile(
                                profileController.userMap["userFacebook"]);
                          }
                        },
                        child: Image.asset(
                          "${ImageIconManager.assetPath}facebook.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // Instagram
                      GestureDetector(
                        onTap: () {
                          if (profileController.userMap["userInstagram"] ==
                              "") {
                            Get.snackbar("Instagram Profile",
                                "This user has not set Instagram link");
                          } else {
                            launchUserSocialProfile(
                                profileController.userMap["userInstagram"]);
                          }
                        },
                        child: Image.asset(
                          "${ImageIconManager.assetPath}instagram.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // Twitter
                      GestureDetector(
                        onTap: () {
                          if (profileController.userMap["userTwitter"] == "") {
                            Get.snackbar("Twitter Profile",
                                "This user has not set Twitter link");
                          } else {
                            launchUserSocialProfile(
                                profileController.userMap["userTwitter"]);
                          }
                        },
                        child: Image.asset(
                          "${ImageIconManager.assetPath}twitter.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // Youtube
                      GestureDetector(
                        onTap: () {
                          if (profileController.userMap["userYoutube"] == "") {
                            Get.snackbar("Youtube Profile",
                                "This user has not set Youtube link");
                          } else {
                            launchUserSocialProfile(
                                profileController.userMap["userYoutube"]);
                          }
                        },
                        child: Image.asset(
                          "${ImageIconManager.assetPath}youtube.png",
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
