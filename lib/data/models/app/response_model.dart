import 'package:dio/dio.dart';


class ApiResponse{
  Response response;
  ApiResponse({required this.response});

  String getResponseType(){
    String responseType = '';
    if(response.statusCode == 200){
      responseType = "succès";
    }else if(response.statusCode! >= 510){

    }
    return responseType;
  }

}