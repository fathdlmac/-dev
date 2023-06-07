import '../main.dart';
import '../models/cart_item.dart';
import 'package:collection/collection.dart';

class Cart {
  List<CartItem> items = [];

  void addItem(CartItem item) async {
  final flower = item.flower;

  // Veritabanına çiçek ekleyin
  await DatabaseHelper.instance.insertFlower(flower.name, flower.price, flower.imageUrl);

  items.add(item);
}


  void removeItem(CartItem item) {
    items.remove(item);
  }

  double get totalAmount {
    var total = 0.0;
    items.forEach((item) {
      total += item.flower.price * item.quantity;
    });
    return total;
  }

  int get itemCount {
    return items.length;
  }
}