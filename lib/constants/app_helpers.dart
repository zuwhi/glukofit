import 'package:flutter/material.dart';
import 'package:glukofit/constants/app_colors.dart';

class AppHelpers {
  static String mapIndexToQuestion(int index) {
    switch (index) {
      case 0:
        return '0. Berapa usia Anda?';
      case 1:
        return '1. Apa jenis kelamin Anda?';
      case 2:
        return '4. Apakah Anda sering buang air kecil?';
      case 3:
        return '5. Apakah Anda sering merasa haus?';
      case 4:
        return '6. Apakah berat badan Anda turun secara tiba-tiba?';
      case 5:
        return '7. Apakah Anda sering merasa lemas?';
      case 6:
        return '8. Apakah Anda sering merasa sangat lapar?';
      case 7:
        return '9. Apakah Anda pernah mengalami infeksi pada area intim?';
      case 8:
        return '10. Apakah Anda mengalami masalah penglihatan?';
      case 9:
        return '11. Apakah kulit Anda sering terasa gatal?';
      case 10:
        return '12. Apakah Anda mudah marah?';
      case 11:
        return '13. Apakah luka Anda sulit sembuh?';
      case 12:
        return '14. Apakah Anda mengalami kelemahan pada sebagian tubuh?';
      case 13:
        return '15. Apakah otot Anda sering terasa kaku?';
      case 14:
        return '16. Apakah rambut Anda sering rontok?';
      case 15:
        return '17. Apakah Anda mengalami kelebihan berat badan (obesitas)?';
      default:
        return 'Pertanyaan tidak tersedia';
    }
  }

  static Color gramCategory(double value) {
    if (value > 0 && value <= 25) {
      return AppColors.primary;
    } else if (value > 25 && value <= 50) {
      return Colors.orange;
    } else if (value > 50) {
      return Colors.red[700] ?? Colors.red;
    }
    return AppColors.primary;
  }
}
