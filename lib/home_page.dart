import 'package:ecomws/actions.dart';
import 'package:ecomws/app_state.dart';
import 'package:ecomws/cart_page.dart';
import 'package:ecomws/login_page.dart';
import 'package:ecomws/product_card.dart';
import 'package:ecomws/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReduxConsumer<AppState>(
      builder: (context, store, state, dispatch, child) {
        Widget body;
        if (state.availableProducts?.isEmpty == true) {
          body = Center(child: CircularProgressIndicator());
        } else {
          body = ListView(
            padding: EdgeInsets.all(16).copyWith(bottom: MediaQuery.of(context).padding.bottom + 16),
            children: state.availableProducts.map((x) {
              return ProductCard(
                product: x,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: x)));
                },
              );
            }).toList(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Mobile Shop'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                },
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    if (!state.isLoggedIn)
                      PopupMenuItem(
                        child: Text('Login'),
                        value: 'login',
                      ),
                    if (state.isLoggedIn) ...[
                      PopupMenuItem(
                        child: Text('Hello ${state.username}'),
                        enabled: false,
                      ),
                      PopupMenuItem(
                        child: Text('Logout'),
                        value: 'logout',
                      ),
                    ],
                  ];
                },
                onSelected: (menu) {
                  switch (menu) {
                    case 'login':
                      LoginPage.login(context);
                      break;
                    case 'logout':
                      store.dispatch(LogoutAction());
                      break;
                  }
                },
              )
            ],
          ),
          body: body,
        );
      },
    );
  }
}
