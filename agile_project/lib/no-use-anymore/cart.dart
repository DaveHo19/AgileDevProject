import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  final String ISBN_13;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageCoverURL;

  @HiveField(3)
  final double retailPrice;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final int cartQuantity;

  Cart(
      {required this.ISBN_13,
      required this.title,
      required this.imageCoverURL,
      required this.retailPrice,
      required this.quantity,
      required this.cartQuantity});

  Cart copyWith({
    String? ISBN_13,
    String? title,
    String? imageCoverURL,
    double? retailPrice,
    int? quantity,
    int? cartQuantity,
  }) {
    return Cart(
        ISBN_13: ISBN_13 ?? this.ISBN_13,
        title: title ?? this.title,
        imageCoverURL: imageCoverURL ?? this.imageCoverURL,
        retailPrice: retailPrice ?? this.retailPrice,
        quantity: quantity ?? this.quantity,
        cartQuantity: cartQuantity ?? this.cartQuantity);
  }
}
