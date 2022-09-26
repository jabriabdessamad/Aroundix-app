import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/home/services/product_service.dart';
import 'package:aroundix_task/models/product_model.dart';
import 'package:flutter/material.dart';

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
  Map<String, dynamic> showedImages = {};

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  String getVariantPrice(String color, String size) {
    String price = _product!.productVariants
        .where((element) =>
            (element.variantAttributes.variantColor.colorName == color) &&
            (element.variantAttributes.variantSize == size))
        .toList()[0]
        .variantPrice;
    return price;
  }

  Future<Product?> getProduct() async {
    _product = await _productService.getProductById(id: widget.productId);
    if (_product != null && variant == null) {
      variant = _product!.productVariants[0];
    }
    return _product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Icon(Icons.edit),
          SizedBox(
            width: 15,
          )
        ],
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
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(70))),
                        child: Image(
                          image: NetworkImage(_product!
                              .productOptions.productColors[0].colorImages[0]),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 40,
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
                            '${_product!.productName} ${variant!.variantAttributes.variantSize} ${variant!.variantAttributes.variantColor.colorName}',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 66, 66, 66),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Pacifico",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\$  ${getVariantPrice(variant!.variantAttributes.variantColor.colorName, variant!.variantAttributes.variantSize)} .00',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                      height: 10,
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

                                  variant!.variantAttributes.variantSize =
                                      _product!
                                          .productOptions.productSizes[item];
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
