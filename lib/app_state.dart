import 'package:ecomws/models.dart';
import 'package:flutter/foundation.dart' show required;

class AppState {
  final String username;
  final List<Product> availableProducts;
  final Map<Product, CartItem> cart;

  const AppState({
    @required this.username,
    @required this.availableProducts,
    @required this.cart,
  });

  factory AppState.initialState() {
    return AppState(username: null, availableProducts: [], cart: {});
  }

  int get grandTotal => cart.values.toList().where((x) => x.amount > 0).fold(0, (sum, x) => sum + x.total);

  bool get isLoggedIn => username?.isNotEmpty == true;

  AppState copyWith({
    String username,
    List<Product> availableProducts,
    Map<Product, CartItem> cart,
  }) {
    return AppState(
      username: username ?? this.username,
      availableProducts: availableProducts ?? this.availableProducts,
      cart: cart ?? this.cart,
    );
  }
}
