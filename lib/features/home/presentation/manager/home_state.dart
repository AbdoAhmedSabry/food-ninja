import 'package:foodninga/core/shared/entities/product_entite.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductEntite> products;
  HomeSuccess(this.products);
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}

class HomeUserDataLoaded extends HomeState {}
