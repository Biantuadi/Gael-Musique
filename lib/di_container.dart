import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/data/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/api/client/dio_client.dart';
import 'data/providers/splash_provider.dart';
import 'data/repositories/splash_repository.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DioClient(AppConfig.BASE_URL, sl(),  sharedPreferences: sl()));

  sl.registerLazySingleton(() => SplashRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => ThemeRepository(sharedPreferences: sl(),));

  sl.registerFactory(() => SplashProvider(splashRepository: sl(),));
  sl.registerFactory(() => ThemeProvider(themeRepository: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

}