import 'package:foodninga/features/home/domain/entities/cartentitie.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartEntitie> cartItems;
  final double totalPrice;

  CartUpdated({required this.cartItems, required this.totalPrice});
}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
