import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone_app/authentication/login_screen.dart';
import 'package:tiktok_clone_app/authentication/model/user.dart' as UserModel;
import 'package:tiktok_clone_app/authentication/registration_screen.dart';
import 'package:tiktok_clone_app/global.dart';
import 'package:tiktok_clone_app/home/home_screen.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController instanceAuth = Get.find();
  late Rx<User?> _currentUser;

  late Rx<File?> _pickedFile;
  File? get profileImage => _pickedFile.value;

  void chooseImageFromGallery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "You have successfully selected your profile image",
      );
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void captureImageWithCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "You have successfully capture your profile image",
      );
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void createAccountForNewUser(String userName, String userEmail,
      String userPassword, File imageFile) async {
    try {
      //1. Create user in the firebase authentication
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);

      //2. Save the user profile image to the firebase storage & get the download url
      String imageDownloadUrl = await uploadImageToStorage(imageFile);

      //3. Save user data to the firestore database
      UserModel.User user = UserModel.User(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        uid: credential.user!.uid,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());
      showProgressBar = false;
    } catch (error) {
      Get.snackbar("Account Creation Unsuccessful",
          "Error Occured While Creating Account. Please Try Again!");
      showProgressBar = false;
      Get.to(const RegistrationScreen());
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrlOfUploadedImage = await taskSnapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedImage;
  }

  void loginUserNow(String userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      showProgressBar = false;
    } catch (error) {
      Get.snackbar("Login Unsuccessful", "Error Occured During Authentication");
      showProgressBar = false;
      Get.to(const LoginScreen());
    }
  }

  /*
    User Traffic Controller, decide whether user landed on the "LoginScreen" or
    "HomeScreen" base on the current state authentication from Firebase.
  */
  goToScreen(User? currentUser) {
    if (currentUser == null) {
      // User is not already logged in
      Get.offAll(const LoginScreen());
    } else {
      // User is already logged in
      Get.offAll(const HomeScreen());
    }
  }

  @override
  void onReady() {
    // This method will automatically called when "authenticationController"
    // called in login_screen/registration_screen
    super.onReady();

    _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);

    /*
      "bindStream" will be bind "_currentUser" to the Firebase Authentication
      status, decide whether "_currentUser" is logged in or not.
    */
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    /*
      "ever" will combine "_currentUser" & "goToScreen" to decide whether
      user landed on the "LoginScreen" or "HomeScreen"
    */
    ever(_currentUser, goToScreen);
  }
}
