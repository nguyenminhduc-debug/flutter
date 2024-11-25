import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minhduc/components/product_card.dart';
import 'package:minhduc/components/vietnamese_font.dart';
import 'package:minhduc/models/cart.dart';
import 'package:minhduc/pages/cart_page.dart';
import 'package:minhduc/pages/home_page.dart';
import '../app_theme.dart';
import '../models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Product product = Product(image: "", description: "");
  late Future<List<Product>> lstRelativeProduct;
  int activeSlide = 1;

  Future<List<Product>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://673b0a0b339a4ce4451a481b.mockapi.io/myproducts?category=${product.category}'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    product = widget.product;
    lstRelativeProduct = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox(
                  width: size.width,
                  //height: 350,
                  child: CarouselSlider(
                    items: product.listImage
                        ?.map((imageUrl) => Container(
                              color: MyColor.background,
                              //padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.fill,
                                width: size.width,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        onPageChanged: (value, _) {
                          setState(() {
                            activeSlide = value + 1;
                          });
                        },
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        height: 300,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4)),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey)
                              //color: Colors.grey.shade400
                              ),
                          child: IconButton(
                            //iconSize: 50,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomePage())),
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey),
                            //color: Colors.transparent
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=> const CartPage()));

                              },
                              iconSize: 30,
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 5,
                    child: SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.transparent),
                                color: Colors.grey.shade200),
                            child: Text(
                              "$activeSlide/${product.listImage?.length.toString()}",
                              style: TextStyle(
                                  fontSize: 20, color: MyColor.textColor),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.grey)),
                            child: IconButton(
                                onPressed: () {},
                                iconSize: 30,
                                icon: const Icon(Icons.heart_broken)),
                          ),
                        ],
                      ),
                    ))
              ],
            ),

            Container(
              width: size.width,
              color: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "${product.price}.000 VND",
                style: TextStyle(fontSize: 20, color: MyColor.secondary),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                Font().vFont(product.title ?? "No Title"),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyColor.textColor),
              ),
            ),
            SizedBox(
                height: 5,
                child: Container(
                  color: Colors.grey.shade200,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Mô ta san pham",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyColor.textColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                Font().vFont(product.description.toString()),
                style: TextStyle(fontSize: 16, color: MyColor.textColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 5,
              width: size.width,
              color: Colors.grey.shade200,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const Text(
                "Sản Phẩm Liên Quan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.only(left: 10),
                height: 300,
                child: FutureBuilder<List<Product>>(
                  future: lstRelativeProduct,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error:${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Data not found'),
                      );
                    } else {
                      List<Product> lst = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lst.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Product relatedProduct = lst[index];
                          return ProductCard(
                            lst: lst, index: index, width: 200,
                            //height: 400,
                          );
                        },
                      );
                    }
                  },
                )),
            const SizedBox(
              height: 75,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: size.width,
        height: 75,
        color: MyColor.primary,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Cart.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(Font().vFont('${product.title} da duoc them vao gio hang')),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                      color: MyColor.background,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: MyColor.primary,
                      ),
                      Text("Them vao gio",
                          style:
                              TextStyle(color: MyColor.primary, fontSize: 15))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: MyColor.secondary,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MUA NGAY",
                        style: TextStyle(
                            color: MyColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text("Giao hang mien phi",
                          style:
                              TextStyle(color: MyColor.primary, fontSize: 15))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
