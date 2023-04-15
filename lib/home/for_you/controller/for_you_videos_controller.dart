import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/home/upload_video/model/video.dart';

class ForYouVideosController extends GetxController{
  final Rx<List<Video>> forYouVideosList = Rx<List<Video>>([]);

  /* Code dibawah digunakan untuk melakukan retrieve/memanggil
      "forYouVideosList" dari class manapun.
  */
  List<Video> get forYouAllVideosList => forYouVideosList.value;

  @override
  void onInit() {
    super.onInit();

    forYouVideosList.bindStream(
      FirebaseFirestore.instance
          .collection("videos")
          .orderBy("totalComments", descending: true)
          .snapshots().map((QuerySnapshot snapshotQuery) {
            List<Video> videosList = [];
            for(var eachVideo in snapshotQuery.docs){
              videosList.add(
                Video.fromDocumentSnapshot(eachVideo)
              );
            }
      return videosList;
      })
    );
  }
}