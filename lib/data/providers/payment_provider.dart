import 'package:Gael/data/models/app/payment_mean.dart';
import 'package:Gael/data/models/payment_model.dart';
import 'package:Gael/data/repositories/payment_repository.dart';
import 'package:countries_info/countries_info.dart';
import 'package:flutter/foundation.dart';

class PaymentProvider with ChangeNotifier{
  PaymentRepository paymentRepository;
  PaymentProvider({required this.paymentRepository});
  List<PaymentMean> paymentMeans = PaymentRepository.paymentMeans;

  PaymentModel paymentModel = PaymentModel();
  String countrySearchKey = "";
  String countryCode = "";
  String countryFlag = "";


  setInitialCountry(){
    Countries allCountries = Countries();
    List<Map<String, dynamic>> countries = allCountries.name(query: "congo");
    countryCode = countries.last["idd"]["root"]??"- ";
    countryCode += countries.last["idd"]["suffixes"] != null? countries.last["idd"]["suffixes"][0] :"-";
    countryFlag = countries.last["flag"];

  }

  setCountrySearchKey(String value){
    countrySearchKey = value;
    notifyListeners();
  }


  setCountryFlagNCode({required String code, required String flag}){
    countryCode = code;
    countryFlag = flag;
    notifyListeners();
  }


  /*
  required this.id,
    this.isCard = true,
    this.cvsCode,
    this.cardNumber,
    this.nameOnCard,
    this.phoneNumber,
   */

  setInitialPaymentMean(){
    paymentModel.paymentMean = PaymentRepository.paymentMeans.first;
  }

  setPaymentMean({required PaymentMean paymentMean}){
    paymentModel.paymentMean = paymentMean;
    if( paymentModel.paymentMean!.isVisa || paymentModel.paymentMean!.isMasterCard){
      paymentModel.isCard = true;
    }
    notifyListeners();
  }
  setIsPaymentIsByPhone(){
    paymentModel.isCard = false;
    notifyListeners();
  }

  setPaymentCardInfo({ required String cardNumber, required String cvsCode, required String nameOnCard}){
    paymentModel.cardNumber = cardNumber;
    paymentModel.nameOnCard = nameOnCard;
    paymentModel.cvsCode = cvsCode;
    notifyListeners();
  }
  setPaymentPhoneInfo({ required String phoneNumber }){
    paymentModel.phoneNumber = phoneNumber;
    notifyListeners();
  }

  nullPaymentInfo(){
    paymentModel = PaymentModel();
    notifyListeners();
  }




}