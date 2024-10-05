import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    String lang = 'ar',
    String? token,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    try {
      final response = await dio.get(
        url,
        queryParameters: query,
        data: data,
      );
      return response;
    } catch (error) {
      throw Exception("Error: $error");
    }
  }

  static Future<Response> postData({
    required String url,
    String lang = 'ar',
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    try {
      final response = await dio.post(
        url,
        queryParameters: query,
        data: data,
      );
      return response;
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
   static Future<Response> putData({
    required String url,
    String lang = 'ar',
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    try {
      final response = await dio.put(
        url,
        queryParameters: query,
        data: data,
      );
      return response;
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
}
