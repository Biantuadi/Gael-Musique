import 'package:Gael/data/repositories/splash_repository.dart';
import 'package:flutter/material.dart';


class SplashProvider with ChangeNotifier{
  SplashRepository splashRepository;
  SplashProvider({required this.splashRepository});
  //CONFIG
  bool success = false;
  // STYLE

  double captionFontSize = 14;
  double titleFontSize = 14;
  bool isFirstTime_ = true;


  initConfig(BuildContext context)async{
   // Connectivity  connectivity  = Connectivity();
    isFirstTime_ =  await splashRepository.isFirstTime();
    await splashRepository.setFirstTimeToFalse();
    if(isFirstTime_){
      isFirstTime_ = false;
    }
    success = true;

    notifyListeners();
    return true;
  }
  get isFirstTime =>  isFirstTime_;
}