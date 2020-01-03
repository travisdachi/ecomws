import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomws/models.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final format = MaterialLocalizations.of(context).formatDecimal;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Cart')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Product>[
                  //TODO replace with real data
                  Product(
                    id: 'xx',
                    name: 'mock product',
                    brand: 'no brand',
                    os: 'symbian',
                    imageUrl: 'https://www.siamphone.com/spec/samsung/images/galaxy_a70/samsung_galaxy_a70_1.jpg',
                    price: 555,
                  ),
                ].map((x) {
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: x.imageUrl,
                      height: 40,
                    ),
                    title: Text('${x.brand} ${x.name}'),
                    subtitle: Text('${format(x.price.toInt())}THB x 10'), //TODO replace with real data
                    trailing: Text('${format(5555)}THB'), //TODO replace with real data
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
                '${format(5555)}THB', //TODO replace with real data
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (isLoading) Center(child: CircularProgressIndicator()),
            if (!isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RaisedButton(
                  child: Text('Checkout (${format(5555)})'), //TODO replace with real data
                  onPressed: () async {
                    //TODO check login
                    //TODO checkout
                    scaffoldKey.currentState.showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Checkout complete!'),
                    ));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
