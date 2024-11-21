import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_bookly/core/utils/api_services.dart';
import 'package:my_bookly/features/home/data/repos/home_repo_implementaion.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiServices>(
    ApiServices(
      Dio(),
    ),
  );

  getIt.registerSingleton<HomeRepoImplementation>(
    HomeRepoImplementation(
      getIt.get<ApiServices>(),
    ),
  );
}
