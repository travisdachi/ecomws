import 'dart:async';
import 'dart:convert';

import 'package:async_redux/async_redux.dart';
import 'package:ecomws/app_state.dart';
import 'package:ecomws/models.dart';
import 'package:http/http.dart';

class AddToCartAction extends ReduxAction<AppState> {
  final Product product;

  AddToCartAction(this.product);

  @override
  AppState reduce() {
    final cartItem = CartItem(product: product, amount: (state.cart[product]?.amount ?? 0) + 1);
    state.cart[product] = cartItem;
    return state.copyWith(
      cart: state.cart,
    );
  }
}

class CheckoutAction extends ReduxAction<AppState> {
  @override
  FutureOr<AppState> reduce() async {
    await Future.delayed(Duration(seconds: 1));
    return state.copyWith(
      cart: {},
    );
  }
}

class LoginAction extends ReduxAction<AppState> {
  final String username;
  final String password;

  LoginAction(this.username, this.password);

  @override
  FutureOr<AppState> reduce() async {
    await Future.delayed(Duration(seconds: 1));
    return state.copyWith(
      username: username,
    );
  }
}

class LogoutAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      username: '',
    );
  }
}

class FetchProductAction extends ReduxAction<AppState> {
  @override
  FutureOr<AppState> reduce() async {
    final response = await get('http://www.mocky.io/v2/5e0f46473400000d002d7fd0').then((x) => x.body);
    final list = jsonDecode(response) as List;
    final products = list.map((x) => Product.fromJson(x)).toList();
    return state.copyWith(
      availableProducts: products,
    );
  }
}
