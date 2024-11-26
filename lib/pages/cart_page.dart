import 'package:flutter/material.dart';
import 'package:minhduc/app_theme.dart';
import 'package:minhduc/components/vietnamese_font.dart';
import 'package:minhduc/models/cart.dart';
import 'package:minhduc/models/item.dart';
import 'package:minhduc/models/product.dart';
import 'package:minhduc/pages/home_page.dart';
import 'package:minhduc/pages/product_detail_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Giỏ hang',
          style: TextStyle(color: MyColor.primary),
        ),
        backgroundColor: MyColor.background,
        foregroundColor: MyColor.primary,
      ),
      body: Cart.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.tag_faces_outlined,
                    size: 120,
                    color: Colors.grey,
                  ),
                  const Text('Giỏ hàng của bạn hien chua co san pham nao'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 10),
                    color: MyColor.secondary,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomePage()));
                        },
                        child: Text(
                          "tiep tuc mua sam".toUpperCase(),
                          style: TextStyle(color: MyColor.primary),
                        )),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: Cart.cartItems.length,
                    itemBuilder: (context, index) {
                      Item item = Cart.cartItems[index];
                      Product product = item.product;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        //margin: EdgeInsets.only(top: 10),
                        color: MyColor.primary,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetail(product: product)));
                          },
                          child: ListTile(
                            leading: Image.network(
                              product.image!,
                              width: 75,
                              height: 75,
                            ),
                            title: Text(
                              Font().vFont(
                                product.title ?? 'No Title',
                              ),
                              style: TextStyle(
                                  color: MyColor.textColor, fontSize: 15),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product.price}.000 VND",
                                  style: TextStyle(
                                      color: MyColor.secondary, fontSize: 18),
                                ),
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
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Text('${item.quantity}')),
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
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                                "Ban muon xoa san pham nay khoi gio hang?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    Cart.removeFromCart(
                                                        product.id);
                                                  });
                                                },
                                                child: Text(
                                                  "Dong y".toUpperCase(),
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: MyColor.textColor),
                                                ),
                                              ),
                                              // const SizedBox(
                                              //   width: 20,
                                              // ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "dong".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: MyColor.textColor),
                                                ),
                                              ),
                                            ]));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tong thanh toan',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${Cart.getTotalPrice()}.000 VND',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColor.secondary),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        margin: const EdgeInsets.only(top: 10, bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.secondary,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Tien hanh dat hang'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
