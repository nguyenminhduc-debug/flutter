import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    final response = await http
        .get(Uri.parse('https://6731c05f7aaf2a9aff11dd05.mockapi.io/products'));

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
    'https://img.freepik.com/premium-vector/ho-chi-minh-city-vietnam-skyline-with-panorama-white-background-vector-illustration-business-travel-tourism-concept-with-modern-buildings-image-banner-web-site_596401-63.jpg?w=1060',
    'https://storage.googleapis.com/blogvxr-uploads/2020/10/A%CC%89nh-de%CC%A3p-Vie%CC%A3%CC%82t-Nam.jpg',
    'https://storage.googleapis.com/blogvxr-uploads/2020/10/Ta%CC%81c-pha%CC%82%CC%89m-Su%CC%9Bo%CC%9Bng-So%CC%9B%CC%81m-a%CC%89nh-de%CC%A3p-phong-ca%CC%89nh-Vie%CC%A3%CC%82t-Nam.jpg',
    'https://storage.googleapis.com/blogvxr-uploads/2020/10/Vu%CC%83-co%CC%82ng-tre%CC%82n-bie%CC%82%CC%89n-a%CC%89nh-de%CC%A3p-Vie%CC%A3%CC%82t-Nam.jpg',
    'https://storage.googleapis.com/blogvxr-uploads/2020/10/Do%CC%81n-na%CC%86%CC%81ng-a%CC%89nh-de%CC%A3p-phong-ca%CC%89nh-Vie%CC%A3%CC%82t-Nam.jpg',
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: MyColor.background),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: MyColor.secondary,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: MyColor.primary,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Dang nhap",
                                  style: TextStyle(
                                      color: MyColor.primary,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              "|",
                              style: TextStyle(
                                  color: MyColor.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Dang ky",
                                  style: TextStyle(
                                      color: MyColor.primary,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: MyColor.primary,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: const Text('Trang chu '),
                            leading: const Icon(Icons.home),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: Text('Kiem tra don hang'),
                            leading: Icon(Icons.fact_check_sharp),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
                            // },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: Text('Danh sach yeu thich'),
                            leading: Icon(Icons.heart_broken),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            // },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: Text('Quan ly tai khoan'),
                            leading: Icon(Icons.person),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            // },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: Text('Tri an khach hang'),
                            leading: Icon(Icons.card_giftcard),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            // },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: Text('Hang moi ve'),
                            leading: Icon(Icons.add_reaction_rounded),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            // },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: 'Hotline: ',
                                style: TextStyle(color: MyColor.textColor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '1800 8086',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyColor.background)),
                                ],
                              ),
                            ),
                            leading: const Icon(Icons.phone),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            // },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: Text('Ho tro'),
                            leading: Icon(Icons.question_answer),
                            // onTap: () {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                            // },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: ListTile(
                            title: Text('Dang xuat'),
                            leading: Icon(Icons.logout),
                            //onTap: logout,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Cong ty co phan Minh Duc",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColor.background,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Dia chi: 100 Phan Van Hon, xa Ba Diem, huyen Hoc Mon, tp.HCM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColor.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: FutureBuilder<List<Product>>(
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    //alignment: Alignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                            width: MediaQuery.of(context).size.width,
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
                  const SizedBox(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: Text(
                        "SAN PHAM NOI BAT",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: MyColor.background,
                      ),
                      child: GridView.builder(
                          itemCount: lst.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: MyColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              elevation: 5.0,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Hero(
                                      tag: "${lst[index].id}",
                                      child: GestureDetector(
                                          onTap: () {},
                                          // onTap: () => Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (_) => ProductDetail(
                                          //             product: lst[index]))),
                                          child: Image.network(
                                            lst[index].image.toString(),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      lst[index].title.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      "\$${lst[index].price.toString()}",
                                      style: const TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.shopping_cart),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
