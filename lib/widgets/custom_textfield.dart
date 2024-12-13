import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../configs/theme.dart';

// CustomForm widget
class CustomForm extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  final bool obscureText;
  final bool isPassword;
  final int maxLines;
  final double borderradius;
  final String? hint;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged; // Add the onChanged parameter

  const CustomForm({
    super.key,
    required this.title,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.backgroundColor = neutral50,
    this.obscureText = false,
    this.isPassword = false,
    this.maxLines = 1,
    this.borderradius = 64,
    this.hint,
    this.onTap,
    this.onChanged, // Include onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: mediumTS.copyWith(fontSize: 16, color: neutralBlack)),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          backgroundColor: backgroundColor,
          obscureText: obscureText,
          isPassword: isPassword,
          maxLines: maxLines,
          borderradius: borderradius,
          hint: hint,
          onTap: onTap,
          onChanged: onChanged, // Pass onChanged to CustomTextField
        )
      ],
    );
  }
}

// CustomTextField widget
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  final bool obscureText;
  final bool isPassword;
  final int maxLines;
  final double borderradius;
  final String? hint;
  final VoidCallback? onTap;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged; // Add the onChanged parameter

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.backgroundColor = neutral50,
    this.obscureText = false,
    this.isPassword = false,
    this.maxLines = 1,
    this.borderradius = 64,
    this.hint,
    this.onTap,
    this.prefixIcon,
    this.onChanged, // Include onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: mediumTS.copyWith(fontSize: 14, color: neutralBlack),
      maxLines: maxLines,
      onChanged: onChanged, // Handle onChanged here
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: neutral400) : null,
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: onTap,
                child: !obscureText
                    ? const Icon(IconsaxPlusLinear.eye)
                    : const Icon(IconsaxPlusLinear.eye_slash),
              )
            : null,
        hintText: hint,
        hintStyle: regularTS.copyWith(fontSize: 14, color: neutral400),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius),
          borderSide: const BorderSide(color: neutral100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius),
          borderSide: const BorderSide(color: neutral100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius),
          borderSide: const BorderSide(color: green700, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius),
        ),
      ),
    );
  }
}
