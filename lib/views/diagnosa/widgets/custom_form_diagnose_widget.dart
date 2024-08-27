import 'package:flutter/material.dart';

class CustomFormDiagnoseWidget extends StatelessWidget {
  const CustomFormDiagnoseWidget(
      {super.key,
      this.keyboardType,
      required this.ageController,
      required this.onChanged,
      this.suffixIcon,
      required this.hintText});

  final TextEditingController ageController;
  final void Function(String)? onChanged;
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        border: Border.all(
          width: 0.4,
          color: Colors.grey[400]!,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: ageController,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.all(10),
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 50,
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(96, 79, 79, 79),
                    fontWeight: FontWeight.w400),
                hintText: hintText,
                hoverColor: Colors.transparent,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
