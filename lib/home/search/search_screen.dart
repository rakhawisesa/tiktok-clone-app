import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Search Screen",
          style: FontFamilyConstant.fontFamilyPrimary,
        ),
      ),
    );
  }
}
