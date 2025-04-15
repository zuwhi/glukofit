import 'package:dio/dio.dart';
import 'package:glukofit/constants/app_constant.dart';
import 'package:glukofit/models/diagnosa_model.dart';


class DiagnosaService {
  static Future<String?> sendRequest(DiagnosaModel dataDiagnosa) async {
    try {
      Dio dio = Dio();
      String url = AppConstant.urlDiagnose;
      final res = await dio.post('$url/predict', data: dataDiagnosa.toJson());
      return '${res.data["predictions"][0]}';
    } catch (e) {

      return null;
    }
  }
}
