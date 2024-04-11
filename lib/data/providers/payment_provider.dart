import 'package:Gael/data/models/app/payment_mean.dart';
import 'package:Gael/data/repositories/payment_repository.dart';
import 'package:flutter/foundation.dart';

class PaymentProvider with ChangeNotifier{
  PaymentRepository paymentRepository;
  PaymentProvider({required this.paymentRepository});

  List<PaymentMean> paymentMeans = PaymentRepository.paymentMeans;

}