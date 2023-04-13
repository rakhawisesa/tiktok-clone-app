import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';

class ForYouVideoScreen extends StatefulWidget {
  const ForYouVideoScreen({super.key});

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "For You Video Screen",
          style: FontFamilyConstant.fontFamilyPrimary,
        ),
      ),
    );
  }
}
