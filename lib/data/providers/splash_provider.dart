import 'package:Gael/data/repositories/splash_repository.dart';
import 'package:flutter/material.dart';


class SplashProvider with ChangeNotifier{
  SplashRepository splashRepository;
  SplashProvider({required this.splashRepository});
  //CONFIG
  bool success = false;
  bool isLoading_ = false;
  // STYLE

  double captionFontSize = 14;
  double titleFontSize = 14;
  bool isFirstTime_ = true;
  // AUTH BASE INFOS
  String? userToken_;
  String? userName_;
  String? userProfileUrl_;
  String? userFirstName_;
  String? userEmail_;
  String? userPhone_;


  // GETTERS

  String? get userToken => userToken_;
  String? get userName => userName_;
  String? get userPhone => userPhone_;
  String? get userEmail => userEmail_;
  String? get userFirstName => userFirstName_;
  String? get userProfileUrl => userProfileUrl_;
  bool get  isFirstTime =>  isFirstTime_;
  bool get  isLoading =>  isLoading_;

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
    userToken_ = await splashRepository.getUserToken() ;
    userProfileUrl_ = await splashRepository.getUserProfileUrl();
    userName_ = await splashRepository.getUserName();
    userFirstName_ = await splashRepository.getUserFirstName();

    // ICI, FAIRE LES APPELS API DE TOUTES LES INFOS IMPORTANTES
    // S'IL Y A SUCCES, ALORS ON VA VERS LA MAIN SCREEN SINON, ON AFFICHE UNE SNACK BAR OU UN ECRAN QUI DIT QU'IL Y A ERREUR
    success = true;
    isLoading_ = false;
    notifyListeners();
    if(success){
      successCallback();
    }else{
      errorCallback();
    }


  }

}