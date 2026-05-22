import 'package:dartz/dartz.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/features/home/data/models/cartmodel.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, String>> placeOrder({
    required List<CartModel> items,
    required double totalPrice,
    required String address,
    String? alternativePhone,
  });
}
