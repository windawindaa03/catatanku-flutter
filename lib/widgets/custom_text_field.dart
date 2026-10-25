import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// CustomTextField menyediakan input teks seragam dengan border melengkung halus,
/// warna latar yang hangat, dan dukungan ikon serta validasi.
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int minLines;
  final int maxLines;
  final bool readOnly;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
    this.readOnly = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          readOnly: readOnly,
          focusNode: focusNode,
          style: const TextStyle(
            fontSize: 15,
            color: AppTheme.textPrimary,
            height: 1.4,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppTheme.textLight,
              fontSize: 14,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppTheme.primaryBlush, size: 20)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppTheme.surfaceWhite,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines > 1 ? 16 : 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.borderLight, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.borderLight, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.primaryBlush, width: 1.8),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.priorityHigh, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.priorityHigh, width: 1.8),
            ),
          ),
        ),
      ],
    );
  }
}
