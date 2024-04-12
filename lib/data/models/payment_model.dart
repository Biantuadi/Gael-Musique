import 'app/payment_mean.dart';

class PaymentModel{
  late String? id;
  late bool isCard;
  late String? cvsCode;
  late String? cardNumber;
  late String? nameOnCard;
  late String? phoneNumber;
  late PaymentMean? paymentMean;

  PaymentModel({
    this.id,
    this.isCard = true,
    this.cvsCode,
    this.cardNumber,
    this.nameOnCard,
    this.phoneNumber,
    this.paymentMean,

  });
  PaymentModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    isCard = json["isCard"];
    cvsCode = json["cvsCode"];
    cardNumber = json["cardNumber"];
    nameOnCard = json["nameOnCard"];
    phoneNumber = json["phoneNumber"];
    paymentMean = PaymentMean.fromJson(json["phoneNumber"]);

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["isCard"] = isCard;
    json["cvsCode"] = cvsCode;
    json["cardNumber"] = cardNumber;
    json["nameOnCard"] = nameOnCard;
    json["phoneNumber"] = phoneNumber;
    json["paymentMean"] = paymentMean?.toJson();
    return json;
  }

}