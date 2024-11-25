//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minhduc/components/vietnamese_font.dart';
import 'package:minhduc/models/product.dart';

import '../app_theme.dart';
import '../pages/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final List<Product> lst;
  final int index;
  final double width;
  final double? height;

  const ProductCard({super.key, required this.lst, required this.index, required this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        clipBehavior: Clip.none,
        color: Colors.amber.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Hero(
                tag: "${lst[index].id}",
                child: GestureDetector(
                    //onTap: () {},
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetail(
                                product: lst[index]))),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child: Image.network(
                        lst[index].image.toString(),
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${lst[index].price}.000 VND",
                    style:
                    TextStyle(color: MyColor.secondary),
                  ),
                  Text(
                      lst[index]
                          .brand!
                          .toUpperCase()
                          .toString(),
                      style: TextStyle(
                          color: MyColor.background, fontWeight: FontWeight.bold)),
                  Text(Font().vFont(lst[index].title!.toString()),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                      style:
                      TextStyle(color: MyColor.textColor))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
