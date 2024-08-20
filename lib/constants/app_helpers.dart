class AppHelpers {
  static String mapIndexToQuestion(int index) {
    switch (index) {
      case 0:
        return '0. Berapa umur Anda?'; 
      case 1:
        return '1. Apa gender Anda?'; 
      case 2:
        return '4. Apakah Anda sering kencing?'; 
      case 3:
        return '5. Apakah Anda sering mengalami haus?';
      case 4:
        return '6. Apakah Anda mengalami penurunan berat badan mendadak?';
      case 5:
        return '7. Apakah Anda merasa lemah?';
      case 6:
        return '8. Apakah Anda mengalami sering lapar berlebihan?';
      case 7:
        return '9. Apakah Anda mengalami infeksi genital?';
      case 8:
        return '10. Apakah Anda mengalami gangguan penglihatan?';
      case 9:
        return '11. Apakah Anda mengalami gatal?';
      case 10:
        return '12. Apakah Anda merasa mudah marah?';
      case 11:
        return '13. Apakah Anda luka anda tidak cepat sembuh?';
      case 12:
        return '14. Apakah Anda mengalami paresis parsial?';
      case 13:
        return '15. Apakah Anda mengalami kekakuan otot?';
      case 14:
        return '16. Apakah rambut Anda mengalami kerontokan?';
      case 15:
        return '17. Apakah Anda mengalami obesitas?';
      default:
        return 'Pertanyaan tidak tersedia';
    }
  }
}
