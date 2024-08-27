import 'package:flutter/material.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.rounded,
      this.isActive = false});

  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? rounded;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isActive ? backgroundColor ?? Colors.grey[400] : Colors.grey[400],
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded ?? 12),
          ),
        ),
        child: TextPrimary(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }
}
