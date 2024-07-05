import 'package:get_it/get_it.dart';
import 'package:kalonga/src/data/local.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> globalModules() async {
  final SharedPreferences sharePref = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<PersistentStorage>(
    () => PersistentStorage(sharedPreferences: sharePref),
  );

  serviceLocator.registerLazySingleton<AppCubit>(
    () => AppCubit(serviceLocator<PersistentStorage>()),
  );
}
