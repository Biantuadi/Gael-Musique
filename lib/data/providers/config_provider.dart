import 'package:Gael/data/repositories/config_repository.dart';
import 'package:flutter/material.dart';


class ConfigProvider with ChangeNotifier{
  ConfigRepository splashRepository;
  ConfigProvider({required this.splashRepository});
  //CONFIG
  bool success = false;
  bool isLoading_ = false;
  bool isOfflineMode = false;
  // STYLE

  bool isFirstTime_ = true;
  // AUTH BASE INFOS

  // GETTERS



  bool get  isFirstTime =>  isFirstTime_;

  //
  setIsOfflineMode(bool isOffline){
    splashRepository.setOfflineMode(isOffline);
  }
  initConfig({required VoidCallback successCallback, required VoidCallback errorCallback})async{
    isFirstTime_ =  await splashRepository.isFirstTime();
    isLoading_ = true;
    isOfflineMode = await splashRepository.isOfflineMode();
    notifyListeners();
    await splashRepository.setFirstTimeToFalse();
    if(isFirstTime_){
      isFirstTime_ = false;
    }

    isLoading_ = false;
    notifyListeners();
    if(success){
      successCallback();
    }else{
      errorCallback();
    }


  }


}