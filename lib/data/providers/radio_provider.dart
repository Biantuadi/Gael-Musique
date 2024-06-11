import 'package:Gael/data/models/radio_model.dart';
import 'package:Gael/data/repositories/radio_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RadiosProvider with ChangeNotifier{
  RadioRepository radiosRepository;
  RadiosProvider({required this.radiosRepository});

  List<RadioModel>? radios;
  int radioTotalItems =0;
  int radioCurrentPage =0;
  int radioTotalPages =0;

  bool isLoadingData = false;

  incrementCurrentPage(){
    if(radioCurrentPage < radioTotalPages){
      radioCurrentPage++;
      getRadiosFromAPi();
    }
  }
  getRadiosFromAPi()async{
    Response response = await radiosRepository.getRadios();
    if(response.statusCode == 200){
      List data = response.data["items"];
      radios = radios??[];
      radioTotalItems = response.data["totalItems"];
      radioCurrentPage = response.data["currentPage"];
      radioTotalPages = response.data["totalPages"];
      data.forEach((radio)async {
        radios!.add(radio.fromJson(json : radio));
        notifyListeners();
      });
    }
  }



}