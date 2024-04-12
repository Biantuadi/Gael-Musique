class PaymentMean{
  late String? name;
  late String imgUrl;
  late bool isMpesa;
  late bool isOrangeMoney;
  late bool isAirtelMoney;
  late bool isPaypal;
  late bool isVisa;
  late bool isMasterCard;

  PaymentMean({
    this.name,
    required this.imgUrl,
    this.isAirtelMoney = false,
    this.isOrangeMoney = false,
    this.isVisa = false,
    this.isPaypal = false,
    this.isMasterCard = false,
    this.isMpesa = false,
  });

  void setMean(){
    if(isAirtelMoney){
      isOrangeMoney = false;
      isVisa = false;
      isPaypal = false;
      isMasterCard = false;
      isMpesa = false;
    }
    if(isOrangeMoney){
      isAirtelMoney= false;
      isVisa= false;
      isPaypal= false;
      isMasterCard= false;
      isMpesa= false;
    }
    if(isVisa){
      isAirtelMoney= false;
      isOrangeMoney= false;
      isPaypal= false;
      isMasterCard= false;
      isMpesa= false;
    }
    if( isPaypal){
      isAirtelMoney= false;
      isOrangeMoney= false;
      isVisa= false;
      isMasterCard= false;
      isMpesa= false;
    }
    if(  isMasterCard){
      isAirtelMoney= false;
      isOrangeMoney= false;
      isVisa= false;
      isPaypal= false;
      isMpesa= false;
    }
    if(isMpesa){
      isAirtelMoney= false;
      isOrangeMoney= false;
      isVisa= false;
      isPaypal= false;
      isMasterCard= false;
    }
  }

  PaymentMean.fromJson(Map<String, dynamic> json){
    name = json["name"];
    imgUrl = json["image"];
    isAirtelMoney = json["isAirtelMoney"];
    isOrangeMoney = json["isOrangeMoney"];
    isVisa = json["isVisa"];
    isPaypal = json["isPaypal"];
    isMasterCard = json["isMasterCard"];
    isMpesa = json["isMpesa"];
    setMean();

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    setMean();
    Map<String, dynamic> json = {};
    json["title"]=name;
    json["image"] = imgUrl;
    json["isAirtelMoney"] = isAirtelMoney;
    json["isOrangeMoney"] = isOrangeMoney;
    json["isVisa"] = isVisa;
    json["isPaypal"] = isPaypal;
    json["isMasterCard"] = isMasterCard;
    json["isMpesa"] = isMpesa;

    return json;
  }

}