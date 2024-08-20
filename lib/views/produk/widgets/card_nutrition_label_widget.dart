import 'package:flutter/material.dart';
import 'package:glukofit/models/fatsecret_nutrition_model.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:google_fonts/google_fonts.dart';

class CardNutritionLabelWidget extends StatelessWidget {
  const CardNutritionLabelWidget({
    super.key,
    required this.nutrisi,
  });

  final FatsecretNutrisiScrapModel nutrisi;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height / 1.2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF050505).withOpacity(0.24),
            offset: const Offset(3, 4),
            blurRadius: 3,
            spreadRadius: -2,
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informasi Nilai Gizi",
                  style: GoogleFonts.alfaSlabOne(
                    fontWeight: FontWeight.w500,
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.3,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPrimary(
                      text: "Ukuran Porsi :",
                      fontSize: 18.0,
                    ),
                    TextPrimary(
                      text: nutrisi.servingSize ?? '',
                      fontSize: 18.0,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPrimary(
                      text: "Karbohidrat :",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    TextPrimary(
                      text: nutrisi.carbs ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPrimary(
                      text: "Gula :",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    TextPrimary(
                      text: nutrisi.sugars ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPrimary(
                      text: "Energi :",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    TextPrimary(
                      text: nutrisi.energyKj ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextPrimary(
                      text: nutrisi.energyKcal ?? '',
                      fontSize: 18.0,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPrimary(
                      text: "Lemak :",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    TextPrimary(
                      text: nutrisi.fat ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPrimary(
                      text: "Protein :",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    TextPrimary(
                      text: nutrisi.protein ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextPrimary(
                      text: "Sodium :",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    TextPrimary(
                      text: nutrisi.sodium ?? '',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
