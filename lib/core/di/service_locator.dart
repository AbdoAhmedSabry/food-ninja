import 'package:foodninga/features/admin/data/datasources/storegservices.dart';
import 'package:foodninga/features/admin/data/repositoris/storeg_repoimp.dart';
import 'package:foodninga/features/admin/domain/repositoris/storeg_repo.dart';
import 'package:foodninga/features/admin/presentation/manager/admin_cubit.dart';
import 'package:foodninga/features/auth/data/repositories/auth_repoimpl.dart';

import 'package:foodninga/core/services/database_services.dart';
import 'package:foodninga/features/auth/data/datasources/firebaseauthservices.dart';
import 'package:foodninga/features/auth/domain/repositories/auth_repo.dart';
import 'package:foodninga/features/auth/presentation/manager/auth_cubit.dart';
import 'package:foodninga/features/home/domain/repositories/home_repo.dart';
import 'package:foodninga/features/home/data/repositories/home_repoimpl.dart';
import 'package:foodninga/features/home/domain/repositories/checkout_repo.dart';
import 'package:foodninga/features/home/data/repositories/checkout_repoimpl.dart';
import 'package:foodninga/features/home/presentation/manager/cart_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/checkout_cubit.dart';
import 'package:foodninga/features/home/presentation/manager/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // ------------------------------------
  // 1. Services
  // ------------------------------------
  getIt.registerLazySingleton<FirebaseAuthServices>(
    () => FirebaseAuthServices(),
  );
  getIt.registerLazySingleton<DatabaseServices>(() => DatabaseServicesImpl());
  getIt.registerLazySingleton<StorageServices>(() => StorageServices());

  // ------------------------------------
  // 2. Repositories
  // ------------------------------------
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      firebaseAuthServices: getIt<FirebaseAuthServices>(),
      databaseServices: getIt<DatabaseServices>(),
    ),
  );

  getIt.registerLazySingleton<StoregRepo>(
    () => StoregRepoImp(
      storageServices: getIt<StorageServices>(),
      databaseServices: getIt<DatabaseServices>(),
    ),
  );

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(databaseServices: getIt<DatabaseServices>()),
  );

  getIt.registerLazySingleton<CheckoutRepo>(
    () => CheckoutRepoImpl(databaseServices: getIt<DatabaseServices>()),
  );

  // ------------------------------------
  // 3. Cubits
  // ------------------------------------
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));

  getIt.registerFactory<AdminCubit>(
    () => AdminCubit(storegRepo: getIt<StoregRepo>()),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(homeRepo: getIt<HomeRepo>()),
  );

  getIt.registerLazySingleton<CartCubit>(() => CartCubit());

  getIt.registerLazySingleton<CheckoutCubit>(
    () => CheckoutCubit(checkoutRepo: getIt<CheckoutRepo>()),
  );
}
