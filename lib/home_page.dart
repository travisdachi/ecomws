import 'dart:convert';

import 'package:ecomws/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              padding: EdgeInsets.all(16),
              children: snapshot.data.map((x) => Text(x.name)).toList(),
              //TODO create product widget
            );
          }
        },
      ),
    );
  }
}

Future<List<Product>> getProducts() async {
  final response = await http.get('http://www.mocky.io/v2/5e0f46473400000d002d7fd0').then((x) => x.body);
  final list = jsonDecode(response) as List;
  final products = list.map((x) => Product.fromJson(x)).toList();
  return products;
}
