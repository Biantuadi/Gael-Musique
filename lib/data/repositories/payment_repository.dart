import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/models/app/payment_mean.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  PaymentRepository({required this.sharedPreferences, required this.dioClient});

  static List<PaymentMean> paymentMeans = [
    PaymentMean(name: 'Airtel Money', imgUrl: Assets.airtelMoney, isAirtelMoney: true),
    PaymentMean(name: 'Orange Money', imgUrl: Assets.orangeMoney, isOrangeMoney: true),
    PaymentMean(name: 'M-pesa', imgUrl: Assets.mPesa, isMpesa: true),
    PaymentMean(name: 'PayPal', imgUrl: Assets.paypal, isPaypal: true),
    PaymentMean(name: 'Visa', imgUrl: Assets.visaCard, isVisa: true),
    PaymentMean(name: 'MasterCard', imgUrl: Assets.mastercardCard, isMasterCard: true),
  ];

 Future<Response> getStreaming({int? page})async{
    Response response = await dioClient.get(AppConfig.streamingsUrl, queryParameters: {
      "page":page
    });
    return response;
  }

}