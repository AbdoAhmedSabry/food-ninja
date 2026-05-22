import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/core/utils/shared_prefs_singleton.dart';
import 'package:foodninga/core/services/database_services.dart';
import 'package:foodninga/features/home/data/models/cartmodel.dart';
import 'package:foodninga/features/home/data/models/ordermodel.dart';
import 'package:foodninga/features/home/domain/repositories/checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final DatabaseServices databaseServices;

  CheckoutRepoImpl({required this.databaseServices});

  @override
  Future<Either<Failure, String>> placeOrder({
    required List<CartModel> items,
    required double totalPrice,
    required String address,
    String? alternativePhone,
  }) async {
    try {
      String? userDataJson = CacheHelper.getData(key: 'user_data');

      String userId = 'guest_id';
      String userName = 'Guest';
      String userEmail = 'guest@mail.com';
      String userPhone = '010xxxxxxx';

      if (userDataJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userDataJson);
        userId = userMap['uid'] ?? userMap['id'] ?? 'guest_id';
        userName = userMap['name'] ?? 'Guest';
        userEmail = userMap['email'] ?? 'guest@mail.com';
        userPhone = userMap['phone'] ?? '010xxxxxxx';
      }

      final order = OrderModel(
        orderId: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        userName: userName,
        userEmail: userEmail,
        items: items,
        totalPrice: totalPrice,
        address: address,
        primaryPhone: userPhone,
        alternativePhone: alternativePhone,
        createdAt: DateTime.now(),
      );

      await databaseServices.addData(
        collectionPath: 'orders',
        documentId: order.orderId,
        data: order.toJson(),
      );

      return Right(order.orderId);
    } catch (e) {
      return Left(
        ServerFailure(message: "Error In Sending Order: ${e.toString()}"),
      );
    }
  }
}
