// ignore_for_file: avoid_print, avoid_single_cascade_in_expression_statements, await_only_futures, use_rethrow_when_possible

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
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 20)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      };
    dio..options.validateStatus = (status) => status! < 500;

  }

  Future<Response> get(String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio..options.validateStatus = (status) => status! < 800;
      token = await sharedPreferences.getString(AppConfig.sharedToken);
      dio.options.headers["Authorization"] = "Bearer $token";
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

    ProgressCallback? onReceiveProgress,
    Object? data
  }) async {
    token = await sharedPreferences.getString(AppConfig.sharedToken);
    dio.options.headers["Authorization"] = "Bearer $token";
    dio..options.validateStatus = (status) => status! < 800;
    //dio..options.contentType = Headers.multipartFormDataContentType;
    try {
      var response = await dio.post(
        uri,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e){
      throw e;
    }
  }

  Future<Response> put(String uri, {

    ProgressCallback? onReceiveProgress,
    Object? data
  }) async {
    token = await sharedPreferences.getString(AppConfig.sharedToken);
    print("LA TOKEN: $token ");
    dio.options.headers["Authorization"] = "Bearer $token";
    dio..options.validateStatus = (status) => status! < 800;
    //dio..options.contentType = Headers.multipartFormDataContentType;
    try {
      var response = await dio.put(
        uri,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e){
      throw e;
    }
  }

  Future<Response> delete(String uri, {
    Object? data
  }) async {
    token = await sharedPreferences.getString(AppConfig.sharedToken);
    dio.options.headers["Authorization"] = "Bearer $token";
    dio..options.validateStatus = (status) => status! < 800;
    //dio..options.contentType = Headers.multipartFormDataContentType;
    try {
      var response = await dio.delete(
        uri,
        data: data,
      );
      return response;
    } catch (e){
      throw e;
    }
  }

}