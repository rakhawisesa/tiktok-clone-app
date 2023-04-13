import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Upload Video Screen",
          style: FontFamilyConstant.fontFamilyPrimary,
        ),
      ),
    );
  }
}
