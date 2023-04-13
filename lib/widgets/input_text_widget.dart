import "package:flutter/material.dart";
import "package:tiktok_clone_app/theme_manager/font_manager.dart";

class InputTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String labelString;
  final bool isObscure;

  const InputTextWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.labelString,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelString,
        prefixIcon: Icon(icon),
        labelStyle: FontFamilyConstant.fontFamilyPrimary.copyWith(
          fontSize: FontSizeManager.f16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
