import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sokoai/app/app_constants.dart';
import 'package:sokoai/data/dataSource/remote_data_source.dart';
import 'package:sokoai/data/network/network_info.dart';
import 'package:sokoai/data/repository/repository.dart';

GetIt getIt = GetIt.instance;

Future<void> initAppModules() async {
  final GenerativeModel model = GenerativeModel(
      model: AppConstants.geminiPro, apiKey: AppConstants.apiKey);
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImple(model));
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  getIt.registerLazySingleton<Repository>(
      () => RepositoryImple(getIt<RemoteDataSource>(), getIt<NetworkInfo>()));
}
