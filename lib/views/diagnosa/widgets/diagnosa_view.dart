import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/models/diagnosa_model.dart';
import 'package:glukofit/services/diagnosa_service.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:logger/logger.dart';

class DiagnosaView extends StatefulWidget {
  const DiagnosaView({super.key});

  @override
  _DiagnosaViewState createState() => _DiagnosaViewState();
}

class _DiagnosaViewState extends State<DiagnosaView> {
  final _ageController = TextEditingController();
  String mapIndexToQuestion(int index) {
    switch (index - 2) {
      case 0:
        return 'Apakah Anda mengalami sering kencing?';
      case 1:
        return 'Apakah Anda sering mengalami haus?';
      case 2:
        return 'Apakah Anda mengalami penurunan berat badan mendadak?';
      case 3:
        return 'Apakah Anda merasa lemah?';
      case 4:
        return 'Apakah Anda mengalami sering lapar berlebihan?';
      case 5:
        return 'Apakah Anda mengalami infeksi genital?';
      case 6:
        return 'Apakah Anda mengalami gangguan penglihatan?';
      case 7:
        return 'Apakah Anda mengalami gatal?';
      case 8:
        return 'Apakah Anda merasa mudah marah?';
      case 9:
        return 'Apakah Anda mengalami penyembuhan yang tertunda?';
      case 10:
        return 'Apakah Anda mengalami paresis parsial?';
      case 11:
        return 'Apakah Anda mengalami kekakuan otot?';
      case 12:
        return 'Apakah rambut anda mengalami kerontokan?';
      case 13:
        return 'Apakah Anda mengalami obesitas?';
      default:
        return 'Pertanyaan tidak tersedia';
    }
  }

  DiagnosaModel _diagnosaModel = DiagnosaModel(
    age: [],
    gender: [],
    polyuria: [''],
    polydipsia: [''],
    suddenWeightLoss: [''],
    weakness: [''],
    polyphagia: [''],
    genitalThrush: [''],
    visualBlurring: [''],
    itching: [''],
    irritability: [''],
    delayedHealing: [''],
    partialParesis: [''],
    muscleStiffness: [''],
    alopecia: [''],
    obesity: [''],
  );

  void _updateDiagnosisField(String fieldName, String value) {
    setState(() {
      _diagnosaModel = _diagnosaModel.copyWith(
        polyuria: fieldName == 'Polyuria' ? [value] : _diagnosaModel.polyuria,
        polydipsia:
            fieldName == 'Polydipsia' ? [value] : _diagnosaModel.polydipsia,
        suddenWeightLoss: fieldName == 'sudden weight loss'
            ? [value]
            : _diagnosaModel.suddenWeightLoss,
        weakness: fieldName == 'weakness' ? [value] : _diagnosaModel.weakness,
        polyphagia:
            fieldName == 'Polyphagia' ? [value] : _diagnosaModel.polyphagia,
        genitalThrush: fieldName == 'Genital thrush'
            ? [value]
            : _diagnosaModel.genitalThrush,
        visualBlurring: fieldName == 'visual blurring'
            ? [value]
            : _diagnosaModel.visualBlurring,
        itching: fieldName == 'Itching' ? [value] : _diagnosaModel.itching,
        irritability:
            fieldName == 'Irritability' ? [value] : _diagnosaModel.irritability,
        delayedHealing: fieldName == 'delayed healing'
            ? [value]
            : _diagnosaModel.delayedHealing,
        partialParesis: fieldName == 'partial paresis'
            ? [value]
            : _diagnosaModel.partialParesis,
        muscleStiffness: fieldName == 'muscle stiffness'
            ? [value]
            : _diagnosaModel.muscleStiffness,
        alopecia: fieldName == 'Alopecia' ? [value] : _diagnosaModel.alopecia,
        obesity: fieldName == 'Obesity' ? [value] : _diagnosaModel.obesity,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextPrimary(
          text: 'Diagnosa',
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CardOnDiagnose(
                text: "1. Berapakah umur anda saat ini ?",
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.all(16),
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
                        initialValue: null,
                        controller: _ageController,
                        decoration: const InputDecoration.collapsed(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(96, 79, 79, 79),
                              fontWeight: FontWeight.w400),
                          hintText: "Masukkan Umur",
                          hoverColor: Colors.transparent,
                        ),
                        // onChanged: (value) {
                        //   setState(() {
                        //     _diagnosaModel.age = [int.tryParse(value) ?? 0];
                        //   });
                        // },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CardOnDiagnose(text: "2. Apa Jenis Kelamin anda ?"),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomChoiceChip(
                    label: 'male',
                    selected: _diagnosaModel.gender.contains('Male'),
                    onSelected: (selected) {
                      setState(() {
                        _diagnosaModel.gender = selected ? ['Male'] : [];
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomChoiceChip(
                    label: 'Female',
                    selected: _diagnosaModel.gender.contains('Female'),
                    onSelected: (selected) {
                      setState(() {
                        _diagnosaModel.gender = selected ? ['Female'] : [];
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 20),
              ..._diagnosaModel
                  .toJson()
                  .keys
                  .toList()
                  .asMap()
                  .entries
                  .map((entry) {
                final index = entry.key;

                final key = entry.value;
                final question = mapIndexToQuestion(index);
                if (key == 'Age' || key == 'Gender')
                  return const SizedBox.shrink();

                final value = _diagnosaModel.toJson()[key]?.first ?? 'No';
                Logger().d('cek quest =  $question');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardOnDiagnose(
                          text:
                              '${index + 1}. $question'), // Menampilkan indeks di sini
                      const SizedBox(height: 10.0),
                      Column(
                        children: <Widget>[
                          CustomChoiceChip(
                            label: 'Iya',
                            selected: value == 'Yes',
                            onSelected: (selected) {
                              _updateDiagnosisField(
                                  key, selected ? 'Yes' : 'No');
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomChoiceChip(
                            label: 'Tidak',
                            selected: value == 'No',
                            onSelected: (selected) {
                              _updateDiagnosisField(
                                  key, selected ? 'No' : 'Yes');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DiagnosaService.sendRequest(_diagnosaModel);
                  // Handle form submission here
                  // print('Age: ${_ageController.text}');
                  // print('Gender: ${_diagnosaModel.gender}');
                  print('Form Data: ${json.encode(_diagnosaModel.toJson())}');
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomChoiceChip({
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
        padding: padding ?? const EdgeInsets.all(15),
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

class CardOnDiagnose extends StatelessWidget {
  String text;
  CardOnDiagnose({super.key, required this.text});

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
