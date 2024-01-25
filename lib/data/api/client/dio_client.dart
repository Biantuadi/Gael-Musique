import 'dart:io';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final String baseUrl;
  final SharedPreferences sharedPreferences;

  Dio dio  = Dio();
  String? token;

  DioClient(this.baseUrl,
      Dio dioC, {
        required this.sharedPreferences,

      }) {
    dio = dioC;
    token = sharedPreferences.getString(AppConfig.sharedToken);
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 40000)
      ..options.receiveTimeout = const Duration(milliseconds: 40000)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"

      };

  }

  Future<Response> get(String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> post(String uri, {
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Object? data
  }) async {
    try {
      var response = await dio.post(
        uri,
        options: options,
        cancelToken: cancelToken,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e){
      throw e;
    }
  }


}