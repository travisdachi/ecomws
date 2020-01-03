import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //TODO navigate to cart page
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          //TODO call api
          //TODO create product widget
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
          Placeholder(fallbackHeight: 100),
        ],
      ),
    );
  }
}
