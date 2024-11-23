class Product {
  final String? image, title, description, category, brand;
  final List<dynamic>? listImage;
  final price;

  final id;

  Product(
      {required this.image,
        this.title = "",
        this.brand = "",
        this.category = "",
        this.price = 0.0,
        required this.description,
        this.listImage,
        this.id = 0});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      brand: json['brand'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      listImage: json['list_image']
    );
  }
}