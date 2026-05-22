import 'package:foodninga/core/shared/entities/product_entite.dart';

class CartEntitie {
  final ProductEntite product;
  int quantity;

  CartEntitie({required this.product, this.quantity = 1});
}
