import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/home/comments/model/comment.dart';

class CommentsController extends GetxController {
  String currentVideoID = "";
  final Rx<List<Comment>> commentsList = Rx<List<Comment>>([]);
  List<Comment> get listOfComments => commentsList.value;

  updateCurrentVideoID(String videoID) {
    currentVideoID = videoID;
    retrieveComments();
  }

  saveNewCommentToDatabase(String commentTextData) async {
    try {
      String commentID = DateTime.now().microsecondsSinceEpoch.toString();
      DocumentSnapshot snapshotUserDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Comment commentModel = Comment(
        userName: (snapshotUserDocument.data() as dynamic)["name"],
        commentText: commentTextData,
        userID: FirebaseAuth.instance.currentUser!.uid,
        userProfilePicture: (snapshotUserDocument.data() as dynamic)["image"],
        commentID: commentID,
        publishedDateTime: DateTime.now(),
        commentLikesList: [],
      );

      // Save new comment info to database
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(currentVideoID)
          .collection("comments")
          .doc(commentID)
          .set(commentModel.toJson());

      // update comments counter
      DocumentSnapshot currentVideoSnapshotDocument = await FirebaseFirestore
          .instance
          .collection("videos")
          .doc(currentVideoID)
          .get();

      await FirebaseFirestore.instance
          .collection("videos")
          .doc(currentVideoID)
          .update({
        "totalComments":
            (currentVideoSnapshotDocument.data() as dynamic)["totalComments"] +
                1
      });
    } catch (error) {
      Get.snackbar("Error Posting New Comment", "Message : $error");
    }
  }

  retrieveComments() async {
    commentsList.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .doc(currentVideoID)
        .collection("comments")
        .orderBy("publishedDateTime", descending: true)
        .snapshots()
        .map((QuerySnapshot commentsSnapshot) {
      List<Comment> commentsListOfVideo = [];
      for (var eachComment in commentsSnapshot.docs) {
        commentsListOfVideo.add(Comment.fromDocumentSnapshot(eachComment));
      }
      return commentsListOfVideo;
    }));
  }

  likeUnlikeComment(String commentID) async {
    DocumentSnapshot commentDocumentSnapshot = await FirebaseFirestore.instance
        .collection("videos")
        .doc(currentVideoID)
        .collection("comments")
        .doc(commentID)
        .get();

    if ((commentDocumentSnapshot.data() as dynamic)["commentLikesList"]
        .contains(FirebaseAuth.instance.currentUser!.uid)) {
      // Unlike Comment
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(currentVideoID)
          .collection("comments")
          .doc(commentID)
          .update({
        "commentLikesList":
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
      });
    } else {
      // Like comment
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(currentVideoID)
          .collection("comments")
          .doc(commentID)
          .update({
        "commentLikesList":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
      });
    }
  }
}
