abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final String orderId;

  CheckoutSuccess({required this.orderId});
}

class CheckoutFailure extends CheckoutState {
  final String errorMessage;

  CheckoutFailure({required this.errorMessage});
}
