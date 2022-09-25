import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/home/services/product_service.dart';
import 'package:aroundix_task/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductService _productService = ProductService();
  Product? _product;
  ProductVariant? variant;
  int selectedSize = 0;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Future<Product?> getProduct() async {
    _product = await _productService.getProductById(id: widget.productId);
    if (_product != null) {
      variant = _product!.productVariants[0];
    }
    return _product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Product?>(
        future: getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(25)),
                            image: DecorationImage(
                                image: NetworkImage(_product!.productOptions
                                    .productColors[0].colorImages[0]),
                                fit: BoxFit.fill),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            '\$ ${_product!.productVariants[0].variantPrice}.00',
                            style: TextStyle(
                                color: Color.fromARGB(255, 73, 70, 70),
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(7))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _product!.productOptions
                                      .productColors[0].colorImages.length,
                                  itemBuilder: (context, item) => Container(
                                    height: 50,
                                    width: 50,
                                    child: Image(
                                        image: NetworkImage(_product!
                                            .productOptions
                                            .productColors[0]
                                            .colorImages[item])),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          child: Row(children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 28,
                            ),
                            Text('4.5'),
                            SizedBox(
                              width: 20,
                            )
                          ]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 100,
                      decoration: BoxDecoration(
                          color: GlobalVariables.backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(2, 4), // Shadow position
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _product!.productName,
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Pacifico",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${_product!.productName} ${_product!.productOptions.productColors[0].colorName} ${_product!.productOptions.productSizes[0]}',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 66, 66, 66),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Pacifico",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                _product!.productOptions.productColors.length,
                            itemBuilder: (context, item) => Container(
                              height: 50,
                              width: 50,
                              child: Image(
                                  image: NetworkImage(_product!.productOptions
                                      .productColors[item].colorImages[0])),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 25,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                _product!.productOptions.productSizes.length,
                            itemBuilder: (context, item) => InkWell(
                              onTap: () {
                                setState(() {
                                  selectedSize = item;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: (item == selectedSize)
                                        ? Colors.black
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                width: 50,
                                child: Text(
                                  _product!.productOptions.productSizes[item],
                                  style: TextStyle(
                                    color: (item == selectedSize)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
