import 'package:foodninga/features/home/data/models/cartmodel.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final String userName;
  final String userEmail;
  final List<CartModel> items;
  final double totalPrice;
  final String address;
  final String primaryPhone;
  final String? alternativePhone;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.items,
    required this.totalPrice,
    required this.address,
    required this.primaryPhone,
    this.alternativePhone,
    this.status = 'pending',
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'address': address,
      'primaryPhone': primaryPhone,
      'alternativePhone': alternativePhone,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
