import 'package:ceplookup/repositories/dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CustonDio() {
    _dio.options.headers["content-type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4AppInterceptor());
  }
}
