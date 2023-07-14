import 'package:dio/dio.dart';
import 'package:gym_manager/feature/models/Services.dart';

class DioHelper {
  static String baseUrl=Services.baseUrl;
  static late Dio dio;

  static void CraeteDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {"Content-Type": "application/json"},
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postMethod({
    required String apiName,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers,
  }) {
    dio.options = BaseOptions(headers: headers);
    return dio.post(DioHelper.baseUrl+apiName,data: body,);

  }



  static Future<Response> getMethod({
    required String apiName,
    required Map<String,dynamic>? headers,
    Map<String,dynamic>? queryParameters,
  }){
    dio.options=BaseOptions(headers: headers);
    return dio.get(DioHelper.baseUrl+apiName,queryParameters:queryParameters );
  }



  static Future<Response> putMethod({
    required String apiName,
    required Map<String,dynamic> data,
    required Map<String,dynamic> headers,
    Map<String,dynamic>? queryParameters,

  }){
    dio.options=BaseOptions(headers:headers);
    return dio.put(DioHelper.baseUrl+apiName,data: data,queryParameters:queryParameters) ;
  }

}
