import 'package:flutter/material.dart';
import 'package:minhduc/components/vietnamese_font.dart';
import 'package:minhduc/models/cart.dart';
import 'package:minhduc/models/item.dart';
import 'package:minhduc/models/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ của bạn'),
      ),
      body: Cart.cartItems.isEmpty
          ? const Center(
              child: Text('Giỏ hàng của bạn trống'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: Cart.cartItems.length,
                    itemBuilder: (context, index) {
                      Item item = Cart.cartItems[index];
                      Product product = item.product;

                      return ListTile(
                        leading: Image.network(
                          product.image!,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(Font().vFont(product.title ?? 'No Title')),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${product.price}.000 VND"),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (item.quantity > 1) {
                                        item.quantity--;
                                      } else {
                                        Cart.removeFromCart(product.id);
                                      }
                                    });
                                  },
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      item.quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              Cart.removeFromCart(product.id);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(Font()
                                    .vFont('${product.title} Đã Xóa Khỏi Giỏ')),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tong cong: ${Cart.getTotalPrice()}.000 VND',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Thanh toán'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
