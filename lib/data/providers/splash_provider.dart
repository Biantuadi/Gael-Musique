import 'package:Gael/data/repositories/splash_repository.dart';
import 'package:flutter/material.dart';


class SplashProvider with ChangeNotifier{
  SplashRepository splashRepository;
  SplashProvider({required this.splashRepository});
  //CONFIG
  bool success = false;
  bool isLoading_ = false;
  bool tokenIsValid = false;
  // STYLE

  double captionFontSize = 14;
  double titleFontSize = 14;
  bool isFirstTime_ = true;
  // AUTH BASE INFOS
  String? userToken_;

  // GETTERS

  String? get userToken => userToken_;

  bool get  isFirstTime =>  isFirstTime_;

  //

  initConfig({required VoidCallback successCallback, required VoidCallback errorCallback})async{
   // Connectivity  connectivity  = Connectivity();
    isFirstTime_ =  await splashRepository.isFirstTime();

    isLoading_ = true;
    notifyListeners();
    await splashRepository.setFirstTimeToFalse();
    if(isFirstTime_){
      isFirstTime_ = false;
    }
    success = true;
    userToken_ = await splashRepository.getUserToken();
    tokenIsValid = await splashRepository.isTokenValid()??false;
    isLoading_ = false;
    notifyListeners();
    if(success){
      successCallback();
    }else{
      errorCallback();
    }


  }


}