import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/home/comments/controller/comments_controller.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsScreen extends StatelessWidget {
  final String videoID;

  CommentsScreen({super.key, required this.videoID});

  final TextEditingController commentController = TextEditingController();
  final CommentsController getCommentsController =
      Get.put(CommentsController());

  @override
  Widget build(BuildContext context) {
    getCommentsController.updateCurrentVideoID(videoID);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // display comments
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: getCommentsController.listOfComments.length,
                    itemBuilder: (context, index) {
                      final eachCommentInfo =
                          getCommentsController.listOfComments[index];

                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 2.0, bottom: 2.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(eachCommentInfo
                                    .userProfilePicture
                                    .toString()),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eachCommentInfo.userName.toString(),
                                    style: FontFamilyConstant
                                        .fontFamilySecondary
                                        .copyWith(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeightManager.bold),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    eachCommentInfo.commentText.toString(),
                                    style: FontFamilyConstant
                                        .fontFamilySecondary
                                        .copyWith(
                                            fontSize: 15,
                                            color: Colors.white70,
                                            fontWeight:
                                                FontWeightManager.regular),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    timeago.format(eachCommentInfo
                                        .publishedDateTime
                                        .toDate()),
                                    style: FontFamilyConstant
                                        .fontFamilySecondary
                                        .copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "${eachCommentInfo.commentLikesList!.length.toString()} Likes",
                                    style: FontFamilyConstant
                                        .fontFamilySecondary
                                        .copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  getCommentsController.likeUnlikeComment(
                                      eachCommentInfo.commentID.toString());
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: eachCommentInfo.commentLikesList!
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              // comment box
              Container(
                color: Colors.white54,
                child: ListTile(
                  title: TextFormField(
                    controller: commentController,
                    style: FontFamilyConstant.fontFamilySecondary
                        .copyWith(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add new comment here",
                      hintStyle: FontFamilyConstant.fontFamilySecondary
                          .copyWith(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        getCommentsController
                            .saveNewCommentToDatabase(commentController.text);

                        commentController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
