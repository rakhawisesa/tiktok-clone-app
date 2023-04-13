// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

/*
  Saving a new user record to the Firestore database and retrieving the
  information from the Firestore database.
*/
class User {
  String? name;
  String? uid;
  String? image;
  String? email;
  String? youtube;
  String? facebook;
  String? twitter;
  String? instagram;

  User({
    this.name,
    this.uid,
    this.image,
    this.email,
    this.youtube,
    this.facebook,
    this.twitter,
    this.instagram,
  });

  /*
    The data will send in JSON format to the Firestore database using
    "toJson" method
  */
  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "image": image,
        "email": email,
        "youtube": youtube,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
      };

  /*
    The data comes from Firestore will be in JSON format, then using this
    method "fromSnap" will convert the data from JSON to the String format.
  */
  static User fromSnap(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return User(
      name: dataSnapshot["name"],
      uid: dataSnapshot["uid"],
      image: dataSnapshot["image"],
      email: dataSnapshot["email"],
      youtube: dataSnapshot["youtube"],
      facebook: dataSnapshot["facebook"],
      twitter: dataSnapshot["twitter"],
      instagram: dataSnapshot["instagram"],
    );
  }
}
