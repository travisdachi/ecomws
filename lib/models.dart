import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

/// run command `flutter packages run build_runner build --delete-conflicting-outputs` to generate implementation
@JsonSerializable()
class Product {
  final String id;
  final String name;
  final String brand;
  final String os;
  final String imageUrl;
  final int price;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  const Product({
    @required this.id,
    @required this.name,
    @required this.brand,
    @required this.os,
    @required this.imageUrl,
    @required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          brand == other.brand &&
          os == other.os &&
          imageUrl == other.imageUrl &&
          price == other.price;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ brand.hashCode ^ os.hashCode ^ imageUrl.hashCode ^ price.hashCode;
}

class CartItem {
  final Product product;
  final int amount;

  const CartItem({
    @required this.product,
    @required this.amount,
  });

  CartItem copyWith({
    Product product,
    int amount,
  }) {
    return CartItem(
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }

  int get total => amount * product.price.toInt();
}
