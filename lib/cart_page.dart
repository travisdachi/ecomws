import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomws/actions.dart';
import 'package:ecomws/app_state.dart';
import 'package:ecomws/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Cart')),
      body: ReduxConsumer<AppState>(
        builder: (context, store, state, dispatch, child) {
          final format = MaterialLocalizations.of(context).formatDecimal;
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: state.cart.keys.map((x) {
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: x.imageUrl,
                          height: 40,
                        ),
                        title: Text('${x.brand} ${x.name}'),
                        subtitle: Text('${format(x.price.toInt())}THB x ${state.cart[x].amount}'),
                        trailing: Text('${format(state.cart[x].total)}THB'),
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Grand Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '${format(state.grandTotal)}THB',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (isLoading) Center(child: CircularProgressIndicator()),
                if (!isLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RaisedButton(
                      child: Text('Checkout (${format(state.grandTotal)})'),
                      onPressed: state.cart.isEmpty
                          ? null
                          : () async {
                              if (state.isLoggedIn || await LoginPage.login(context)) {
                                setState(() {
                                  isLoading = true;
                                });
                                await store.dispatchFuture(CheckoutAction());
                                setState(() {
                                  isLoading = false;
                                });
                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Checkout complete!'),
                                ));
                              }
                            },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
