

import 'package:minhduc/models/item.dart';
import 'package:minhduc/models/product.dart';


class Cart {
  static List<Item> cartItems = [];

  static void addToCart(Product product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(Item(product: product, quantity: 1));
    }
  }

  static void removeFromCart(String productID) {
    int index = cartItems.indexWhere((item) => item.product.id == productID);
    if (index != -1) {
      cartItems.remove(cartItems[index]);
    }
  }

  static int getTotalPrice() {
    int total = 0;
    for (var item in cartItems) {
      total +=
          item.product.price * item.quantity;
    }
    return total;
  }
}
