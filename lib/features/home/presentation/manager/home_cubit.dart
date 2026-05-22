import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodninga/core/backendpoint.dart';
import 'package:foodninga/core/utils/shared_prefs_singleton.dart';
import 'package:foodninga/features/home/domain/repositories/home_repo.dart';
import 'package:foodninga/features/home/presentation/manager/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit({required HomeRepo homeRepo})
    : _homeRepo = homeRepo,
      super(HomeInitial()) {
    getUserName();
  }

  Future<void> getproducts() async {
    emit(HomeLoading());
    final result = await _homeRepo.getproducts(
      collectionPath: BackendPoint.productsCollection,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (products) => emit(HomeSuccess(products)),
    );
  }

  Future<void> getproductsbycategory(String category) async {
    emit(HomeLoading());
    final result = await _homeRepo.getproducts(
      collectionPath: BackendPoint.productsCollection,
      category: category,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (products) => emit(HomeSuccess(products)),
    );
  }

  String userName = 'Guest';
  void getUserName() {
    String? userDataJson = CacheHelper.getData(key: 'user_data');

    if (userDataJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userDataJson);
      String? name = userMap['name'];

      if (name != null && name.trim().isNotEmpty) {
        userName = name;
      }
    }
  }
}
