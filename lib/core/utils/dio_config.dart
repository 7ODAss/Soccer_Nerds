import 'package:dio/dio.dart';
import 'package:football_app/core/utils/api_constant.dart';

class DioConfig{
  DioConfig._();
  static late Dio _dio;
  
  static void init(){
    _dio=Dio(BaseOptions(baseUrl: ApiConstant.baseUrl,headers: ApiConstant.headers));
  }

  static Future<Response<dynamic>> getData({required String path})async{
    return _dio.get(path);
  }
}