import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/chat_provider.dart';
import 'package:Gael/data/providers/favorite_provider.dart';
import 'package:Gael/data/providers/notification_provider.dart';
import 'package:Gael/data/repositories/auth_repository.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/data/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/api/client/dio_client.dart';
import 'data/providers/events_provider.dart';
import 'data/providers/payment_provider.dart';
import 'data/providers/socket_provider.dart';
import 'data/providers/song_provider.dart';
import 'data/providers/splash_provider.dart';
import 'data/providers/streaming_provider.dart';
import 'data/repositories/chat_repository.dart';
import 'data/repositories/events_repository.dart';
import 'data/repositories/favorite_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'data/repositories/payment_repository.dart';
import 'data/repositories/socket_repository.dart';
import 'data/repositories/song_repository.dart';
import 'data/repositories/splash_repository.dart';
import 'data/repositories/streaming_repository.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DioClient(AppConfig.BASE_URL, sl(),  sharedPreferences: sl()));

  sl.registerLazySingleton(() => SplashRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => ChatRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => FavoriteRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => NotificationRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => SongRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => StreamingRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => ThemeRepository(sharedPreferences: sl(),));
  sl.registerLazySingleton(() => EventsRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() =>  SocketRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() =>  PaymentRepository(sharedPreferences: sl(), dioClient: sl()));



  sl.registerFactory(() => PaymentProvider(paymentRepository: sl(),));
  sl.registerFactory(() => SplashProvider(splashRepository: sl(),));
  sl.registerFactory(() => ThemeProvider(themeRepository: sl()));
  sl.registerFactory(() => AuthProvider(authRepository: sl()));
  sl.registerFactory(() => ChatProvider(chatRepository: sl()));
  sl.registerFactory(() => FavoriteProvider(favoriteRepository: sl(), socketProvider: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepository: sl()));
  sl.registerFactory(() => SongProvider(songRepository: sl()));
  sl.registerFactory(() => StreamingProvider(streamRepository: sl()));
  sl.registerFactory(() => EventsProvider(eventsRepository: sl(), socketProvider: sl()));

  sl.registerLazySingleton(() => SocketProvider(socketRepository: sl()
  ));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

}