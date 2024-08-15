import 'package:flutter/material.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class CardQuestionWidget extends StatelessWidget {
  String text;
  CardQuestionWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey),
          borderRadius: BorderRadius.circular(13)),
      child: TextPrimary(
          text: text,
          fontSize: 16,
          color: const Color(0xFF4F4F4F),
          fontWeight: FontWeight.w500),
    );
  }
}
