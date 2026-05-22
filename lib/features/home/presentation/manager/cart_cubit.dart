import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodninga/core/utils/shared_prefs_singleton.dart';
import 'package:foodninga/core/shared/entities/product_entite.dart';
import 'package:foodninga/features/home/data/models/cartmodel.dart';
import 'package:foodninga/features/home/domain/entities/cartentitie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    _loadCartFromStorage();
  }
  List<CartEntitie> cartItems = [];

  void addToCart(ProductEntite product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(CartModel(product: product, quantity: 1));
    }
    _updateCart();
  }

  void removeFromCart(ProductEntite product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex >= 0) {
      if (cartItems[existingIndex].quantity > 1) {
        cartItems[existingIndex].quantity--;
      } else {
        cartItems.removeAt(existingIndex);
      }
      _updateCart();
    }
  }

  void deleteProduct(ProductEntite product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    _updateCart();
  }

  void _saveCartToStorage() {
    List<Map<String, dynamic>> cartJson = cartItems.map((item) {
      return CartModel(product: item.product, quantity: item.quantity).toJson();
    }).toList();

    String jsonString = json.encode(cartJson);
    CacheHelper.saveData(key: 'user_cart', value: jsonString);
  }

  void _loadCartFromStorage() {
    String? storedCart = CacheHelper.getData(key: 'user_cart');
    if (storedCart != null) {
      List<dynamic> decodedData = json.decode(storedCart);

      cartItems = decodedData.map((item) => CartModel.fromJson(item)).toList();
      _updateCart();
    }
  }

  void clearCart() {
    cartItems.clear();
    _updateCart();
  }

  void _updateCart() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.product.price * item.quantity;
    }
    _saveCartToStorage();
    emit(CartUpdated(cartItems: List.from(cartItems), totalPrice: totalPrice));
  }
}
