import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone_app/authentication/controller/authentication_controller.dart';
import 'package:tiktok_clone_app/authentication/login_screen.dart';
import 'package:tiktok_clone_app/global.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';
import 'package:tiktok_clone_app/theme_manager/image_icon_manager.dart';
import 'package:tiktok_clone_app/widgets/input_text_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              children: [
                Text(
                  "Sign Up",
                  style: FontFamilyConstant.fontFamilyPrimary.copyWith(
                    fontSize: FontSizeManager.f22,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    // Allow a user to choose image
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: const Color.fromARGB(255, 55, 53, 46),
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  authenticationController
                                      .captureImageWithCamera();
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  authenticationController
                                      .chooseImageFromGallery();
                                },
                                icon: const Icon(
                                  Icons.photo,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        AssetImage("${ImageIconManager.assetPath}avatar.png"),
                    backgroundColor: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InputTextWidget(
                  controller: usernameController,
                  labelString: "Username",
                  isObscure: false,
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 30,
                ),
                InputTextWidget(
                  controller: emailController,
                  labelString: "Email",
                  isObscure: false,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(
                  height: 30,
                ),
                InputTextWidget(
                  controller: passwordController,
                  labelString: "Password",
                  isObscure: true,
                  icon: Icons.lock_outline,
                ),
                const SizedBox(
                  height: 30,
                ),
                showProgressBar == false
                    ? Column(
                        children: [
                          Container(
                            height: 55,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (authenticationController.profileImage !=
                                        null &&
                                    usernameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  setState(() {
                                    showProgressBar = true;
                                  });

                                  // Create account for a new user
                                  authenticationController
                                      .createAccountForNewUser(
                                    usernameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    authenticationController.profileImage!,
                                  );
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: FontFamilyConstant.fontFamilyPrimary
                                      .copyWith(
                                    fontSize: FontSizeManager.f18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: FontFamilyConstant.fontFamilySecondary,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const LoginScreen());
                                },
                                child: Text(
                                  "Sign In",
                                  style: FontFamilyConstant.fontFamilySecondary
                                      .copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : Container(
                        child: const SimpleCircularProgressBar(
                          progressColors: [
                            Colors.white,
                          ],
                          animationDuration: 4,
                          backColor: Colors.white38,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
