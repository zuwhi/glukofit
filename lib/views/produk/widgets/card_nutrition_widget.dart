import 'package:flutter/material.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class CardNutritionWidget extends StatelessWidget {
  const CardNutritionWidget({
    super.key,
    this.nutrition,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;
  final String? nutrition;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColors.primary, width: 1)),
      child: Row(
        children: [
          SizedBox(width: 36, height: 36, child: Image.asset(image)),
          const SizedBox(
            width: 15.0,
          ),
          TextPrimary(
            text: title,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: TextPrimary(
                text: nutrition ?? 0.toString(),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
