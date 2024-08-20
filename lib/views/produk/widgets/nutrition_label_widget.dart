import 'package:flutter/widgets.dart';
import 'package:glukofit/models/nutrisi_model.dart';
import 'package:glukofit/views/produk/nutrisi_produk_view.dart';
import 'package:glukofit/views/produk/widgets/card_nutrition_widget.dart';

class NutritionLabelWidget extends StatelessWidget {
  const NutritionLabelWidget({
    super.key,
    required this.nutrisi,
  });

  final NutrisiScrapModel nutrisi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardNutritionWidget(
          title: "Energi :",
          image: 'assets/images/energi.png',
          nutrition: nutrisi.energi,
        ),
        const SizedBox(
          height: 15.0,
        ),
        CardNutritionWidget(
          title: "Karbo :",
          image: 'assets/images/karbo.png',
          nutrition: nutrisi.karbohidratTotal,
        ),
        const SizedBox(
          height: 15.0,
        ),
        CardNutritionWidget(
          title: "protein :",
          image: 'assets/images/protein.png',
          nutrition: nutrisi.protein,
        ),
        const SizedBox(
          height: 15.0,
        ),
        CardNutritionWidget(
          title: "lemak :",
          image: 'assets/images/lemak.png',
          nutrition: nutrisi.lemakTotal,
        ),
        const SizedBox(
          height: 15.0,
        ),
        CardNutritionWidget(
          title: "natrium :",
          image: 'assets/images/natrium.png',
          nutrition: nutrisi.natrium,
        ),
      ],
    );
  }
}
