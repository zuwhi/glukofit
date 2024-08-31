import 'package:flutter/material.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class CardPointNutrition extends StatelessWidget {
  const CardPointNutrition(
      {super.key,
      required this.image,
      required this.title,
      required this.value});
  final String title;
  final String value;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.9),
          borderRadius: BorderRadius.circular(13),
          // border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Image.asset("assets/images/$image"),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextPrimary(
              text: title,
              fontSize: 14.0,
              // color: Colors.grey.shade700,
              color: Colors.white,
            ),
            TextPrimary(
              text: value,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
