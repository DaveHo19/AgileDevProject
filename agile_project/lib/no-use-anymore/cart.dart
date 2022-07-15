import 'package:hive/hive.dart';

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
}
