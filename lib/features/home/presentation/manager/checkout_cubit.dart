import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodninga/features/home/data/models/cartmodel.dart';
import 'package:foodninga/features/home/domain/repositories/checkout_repo.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepo _checkoutRepo;

  CheckoutCubit({required CheckoutRepo checkoutRepo})
    : _checkoutRepo = checkoutRepo,
      super(CheckoutInitial());

  Future<void> placeOrder({
    required List<CartModel> items,
    required double totalPrice,
    required String address,
    String? alternativePhone,
  }) async {
    emit(CheckoutLoading());

    final result = await _checkoutRepo.placeOrder(
      items: items,
      totalPrice: totalPrice,
      address: address,
      alternativePhone: alternativePhone,
    );

    result.fold(
      (failure) => emit(CheckoutFailure(errorMessage: failure.message)),
      (orderId) => emit(CheckoutSuccess(orderId: orderId)),
    );
  }
}
