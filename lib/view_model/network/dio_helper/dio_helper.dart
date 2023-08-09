import 'package:dio/dio.dart';
import 'package:movie_films/view_model/network/dio_helper/end_points.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
  }

  static Future <Response> get({required String endPoint}) async{
    try {
   var response = await dio.get(endPoint, queryParameters: {"api_key": EndPoints.apiKey});
   return response;
    } catch (e) {
      print("errrrrrooorrrrr $e");
      rethrow;
    }
  }
}
