import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minhduc/components/product_card.dart';
import 'package:minhduc/components/my_drawer.dart';
//import 'package:minhduc/components/vietnamese_font.dart';
import 'package:minhduc/models/category.dart';
import 'package:minhduc/pages/cart_page.dart';
import '../app_theme.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> lstProduct;
  TextEditingController searchController = TextEditingController();
  int activePage = 0;
  final PageController pageController = PageController();
  String query = "";

  @override
  void initState() {
    super.initState();
    lstProduct = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
        Uri.parse('https://673b0a0b339a4ce4451a481b.mockapi.io/myproducts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Product> allProduct =
          jsonData.map((item) => Product.fromJson(item)).toList();
      return query.isEmpty ? allProduct : filterProducts(allProduct);
    } else {
      throw Exception('Failed to load products');
    }
  }

  List<Product> filterProducts(List<Product> allProduct) {
    List<Product> filteredList = allProduct.where((char) {
      return char.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
    }).toList();
    return filteredList;
  }

  final List<String> _carouselImages = [
    "https://media.hcdn.vn/hsk/1732186110hometpcn2111.jpg",
    "https://media.hcdn.vn/hsk/1732249624home3cn229230231.jpg",
    "https://media.hcdn.vn/hsk/1732069393web.jpg",
    "https://media.hcdn.vn/hsk/1732330192homenuochoa2311.jpg",
    "https://media.hcdn.vn/hsk/1732270756homewipro2211.jpg"
  ];
  final List<String> _logoBrands = [
    "https://i.pinimg.com/736x/01/df/ad/01dfadb784cdcd91ebb730d30592b481.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQEYtEjw_Ms5I_WIZaPXQgWrVHwzVND_RwIA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyIZ2PLe4s-2tp9sxyusIwggkr8I_Ul5dcZw&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiT1syf4cE-27GkGtvE73-OoZ08ddsViqxgQ&s",
    "https://i.pinimg.com/736x/28/68/1f/28681f27e5ff0ecfc8e61cb43851d34c.jpg"
  ];
  final List<String> _imageBrand = [
    "https://media1.popsugar-assets.com/files/thumbor/6j00zaa_YEZiqwHuy1AnjB6JNb0=/0x0:1456x1456/1456x1456/filters:format_auto():quality(85):extract_cover()/2020/09/23/869/n/1922153/672ce0d25f6ba74f5a4de1.89623226_.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyHLdWAxe5p2_QzkkoUZzkLhDofvXraQmJKQ&s",
    "https://cdn.shopify.com/s/files/1/0464/3861/3141/files/hadalabo_480x480_64bb6d95-60b3-4f27-8e8a-de6c811f3ec1_480x480.jpg?v=1598090855",
    "https://static.independent.co.uk/2022/11/01/18/image.png",
    "https://blogscdn.thehut.net/wp-content/uploads/sites/31/2018/05/22150126/Hydrabio-range-lifestyle.jpg"
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: MyColor.background,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: MyColor.background,
                  height: 45,
                  //decoration: ,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      query = value;
                      setState(() {
                        lstProduct = fetchProducts();
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 5),
                      hintText: 'Tìm kiếm',
                      hintStyle: TextStyle(color: MyColor.textColor),
                      prefixIcon: Icon(
                        Icons.search,
                        color: MyColor.background,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const CartPage()));
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: MyColor.primary,
                  ))
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.menu, color: MyColor.primary),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: size.width,
                      height: 150,
                      child: CarouselSlider(
                        items: _carouselImages
                            .map((imageUrl) => Container(
                                  color: MyColor.background,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.fill,
                                      width: size.width,
                                    ),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            onPageChanged: (value, _) {
                              setState(() {
                                activePage = value;
                              });
                            },
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            height: 150,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 4)),
                      )),
                  Positioned(
                      bottom: 10,
                      child: Container(
                        color: Colors.transparent,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                            _carouselImages.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Container(
                                height: 4,
                                width: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: activePage == index
                                      ? MyColor.secondary
                                      : MyColor.background,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Text(
                    "Danh muc",
                    //textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, color: MyColor.background),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                color: MyColor.primary,
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        print(categories[index].cateTitle);
                      },
                      child: Card(
                        color: Colors.blue.shade50,
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    categories[index].cateImage,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            SizedBox(
                              width: 75,
                              child: Text(
                                categories[index].cateTitle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(color: MyColor.textColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 10,
                color: Colors.grey.shade200,
              ),
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Text(
                    "Thuong hieu",
                    //textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, color: MyColor.background),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                color: MyColor.primary,
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    _imageBrand[index],
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: 75,
                              height: 50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    _logoBrands[index],
                                    fit: BoxFit.fill,
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 10,
                color: Colors.grey.shade200,
              ),
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Text(
                    "Danh cho ban",
                    style: TextStyle(fontSize: 18, color: MyColor.background),
                  ),
                ),
              ),
              FutureBuilder<List<Product>>(
                future: lstProduct,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Don\'t have data'),
                    );
                  } else {
                    List<Product> lst = snapshot.data!;

                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: lst.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(lst: lst, index: index);
                        });
                  }
                },
              ),
            ],
          ),
        ));
  }
}
