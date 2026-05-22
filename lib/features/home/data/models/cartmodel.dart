import 'package:foodninga/core/shared/models/productmodel.dart';
import 'package:foodninga/features/home/domain/entities/cartentitie.dart';

class CartModel extends CartEntitie {
  CartModel({required super.product, required super.quantity});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: Productmodel.fromMap(json['product']),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'product': (product as Productmodel).tomap(), 'quantity': quantity};
  }
}
