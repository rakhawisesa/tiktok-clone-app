import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';

class FollowingsVideoScreen extends StatefulWidget {
  const FollowingsVideoScreen({super.key});

  @override
  State<FollowingsVideoScreen> createState() => _FollowingsVideoScreenState();
}

class _FollowingsVideoScreenState extends State<FollowingsVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Followings Video Screen",
          style: FontFamilyConstant.fontFamilyPrimary,
        ),
      ),
    );
  }
}
