import 'package:flutter/material.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/models/fatsecret_product_model.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class CardListProductWidget extends StatelessWidget {
  const CardListProductWidget({super.key, required this.product, this.onTap});

  final Function()? onTap;
  final FatsecretProductScrapModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.primary, width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextPrimary(
                      text: "${product.productName ?? ""} ",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    Flexible(
                      child: TextPrimary(
                        text: product.brandName ?? "",
                        fontSize: 18.0,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2.0,
                ),
                TextPrimary(
                  text:
                      "${product.portionInfo} - Karbohidrat: ${product.carbs} | Kalori: ${product.calories} | Lemak: ${product.fat} | Protein: ${product.protein} ",
                  color: Colors.grey[700],
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_circle_right_rounded,
                    color: AppColors.primary,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
