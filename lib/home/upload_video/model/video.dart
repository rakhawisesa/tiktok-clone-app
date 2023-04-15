// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String? userName;
  String? userProfileImage;
  String? userID;
  String? videoID;
  int? totalComments;
  int? totalShares;
  List? likesList;
  String? artistSongName;
  String? descriptionTags;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;

  Video({
    this.userName,
    this.userProfileImage,
    this.userID,
    this.videoID,
    this.totalComments,
    this.totalShares,
    this.likesList,
    this.artistSongName,
    this.descriptionTags,
    this.videoUrl,
    this.thumbnailUrl,
    this.publishedDateTime,
  });

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userProfileImage": userProfileImage,
        "userID": userID,
        "videoID": videoID,
        "totalComments": totalComments,
        "totalShares": totalShares,
        "likesList": likesList,
        "artistSongName": artistSongName,
        "descriptionTags": descriptionTags,
        "videoUrl": videoUrl,
        "thumbnailUrl": thumbnailUrl,
        "publishedDateTime": publishedDateTime,
      };

  static Video fromDocumentSnapshot(DocumentSnapshot snapshot) {
    var docSnapshot = snapshot.data() as Map<String, dynamic>;

    return Video(
      userName: docSnapshot["userName"],
      userProfileImage: docSnapshot["userProfileImage"],
      userID: docSnapshot["userID"],
      videoID: docSnapshot["videoID"],
      totalComments: docSnapshot["totalComments"],
      totalShares: docSnapshot["totalShares"],
      likesList: docSnapshot["likesList"],
      artistSongName: docSnapshot["artistSongName"],
      descriptionTags: docSnapshot["descriptionTags"],
      videoUrl: docSnapshot["videoUrl"],
      thumbnailUrl: docSnapshot["thumbnailUrl"],
      publishedDateTime: docSnapshot["publisedDateTime"],
    );
  }
}
