import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone_app/authentication/controller/authentication_controller.dart';
import 'package:tiktok_clone_app/authentication/registration_screen.dart';
import 'package:tiktok_clone_app/global.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';
import 'package:tiktok_clone_app/widgets/input_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // bool showProgressBar = false;

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
              Image.asset(
                "assets/images/tiktok.png",
                width: 200,
              ),
              Text(
                "TikTok",
                style: FontFamilyConstant.fontFamilyPrimary.copyWith(
                  fontSize: FontSizeManager.f18,
                ),
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
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                setState(() {
                                  showProgressBar = true;
                                });
                                authenticationController.loginUserNow(
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                            child: Center(
                              child: Text(
                                "Sign In",
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
                              "Don't have an account?",
                              style: FontFamilyConstant.fontFamilySecondary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const RegistrationScreen());
                              },
                              child: Text(
                                "Sign Up",
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
    ));
  }
}
