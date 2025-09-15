import 'package:dio/dio.dart';

class ApiService {

  static final _baseUrl = "https://dummyjson.com/";

  ApiService._singleton();

  static final ApiService apiInstance = ApiService._singleton();

  static final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,

    )
  );

}
