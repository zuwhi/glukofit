// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:glukofit/constants/app_colors.dart';

class CustomChoiceChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomChoiceChipWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!selected),
      child: Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: selected
              ? selectedColor ?? AppColors.primary
              : unselectedColor ?? Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          border: Border.all(
            color:
                selected ? (selectedColor ?? AppColors.primary) : Colors.grey,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: selected
                  ? selectedTextStyle ??
                      const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                  : unselectedTextStyle ?? const TextStyle(color: Colors.black),
            ),
            if (selected)
              const Icon(
                Icons.check,
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
