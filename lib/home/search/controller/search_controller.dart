import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone_app/authentication/model/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _usersSearchedList = Rx<List<User>>([]);
  List<User> get usersSearchedList => _usersSearchedList.value;

  searchForuser(String textInput) async {
    _usersSearchedList.bindStream(FirebaseFirestore.instance
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: textInput)
        .snapshots()
        .map((QuerySnapshot searchedUsersQuerySnapshot) {
      List<User> searchList = [];

      for (var user in searchedUsersQuerySnapshot.docs) {
        searchList.add(User.fromSnap(user));
      }

      return searchList;
    }));
  }
}
