import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/theme_manager/font_manager.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Account Setting Screen",
          style: FontFamilyConstant.fontFamilyPrimary,
        ),
      ),
    );
  }
}
