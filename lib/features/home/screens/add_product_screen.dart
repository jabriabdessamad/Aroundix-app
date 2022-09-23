import 'dart:io';
import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/constants/utils.dart';
import 'package:aroundix_task/models/product_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:aroundix_task/shared/widgets/costum_text_form_field.dart';

import 'package:aroundix_task/features/home/widgets/prices_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _colorNameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  Map<ProductVariant, TextEditingController> pricesContollers = {};
  List<Widget> colorsWidgets = [];
  List<String> colors = [];
  List<String> sizes = [];
  List<File> images = [];
  bool imagesEmpty = true;
  List<ProductVariant> variants = [];
  List<String> prices = [];
  List<Widget> productPrices = [];

  Product? newProduct = Product(
      productOptions:
          ProductOptions(productSizes: [], productColors: <ProductColor>[]),
      id: "",
      productName: '',
      productVariants: <ProductVariant>[]);

  void _setProduct(
    Product product,
  ) {
    setState(() {
      newProduct = product;
    });
  }

  List<Widget> ImagesWidgets(List<File> images) {
    List<Widget> list = [];
    if (images.isNotEmpty) {
      for (var i = 0; i < images.length; i++) {
        list.add(
          Container(
            height: 50,
            width: 50,
            child: Image(image: FileImage(images[i])),
          ),
        );
      }
    }
    return list;
  }

  Widget ColorWidget(String colorName, List<File> images) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: GlobalVariables.secondaryColor),
      ),
      child: Row(children: [
        Container(
          width: 80,
          alignment: Alignment.center,
          child: Text(
            colorName,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        SizedBox(
          width: 2,
          child: Container(color: Colors.black),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 5,
                ),
                Row(children: ImagesWidgets(images))
              ],
            )),
      ]),
    );
  }

  void selectImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
            title: const Text(
              'Add Product',
              style: TextStyle(color: Colors.white),
            )),
        body: SingleChildScrollView(
            child: Form(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: CustomTextField(
                        controller: _productNameController,
                        hintText: "Product Name",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Colors :',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: colorsWidgets,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Column(
                      children: [
                        Container(
                          width: 160,
                          alignment: Alignment.center,
                          height: 40,
                          child: TextFormField(
                            controller: _colorNameController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'Enter Color ',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectImages();
                          },
                          child: DottedBorder(
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: 120,
                                height: 120,
                                child: (images.isNotEmpty)
                                    ? Center(
                                        child: Text(
                                          '${images.length} Images',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                            Icon(
                                              Icons.folder_open,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text('Select images')
                                          ]),
                              )),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            color: GlobalVariables.secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextButton(
                            child: const Text(
                              'Add Color',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_colorNameController.text.isNotEmpty &&
                                  images.isNotEmpty) {
                                setState(() {
                                  // newProduct!.productOptions.productColors.add(
                                  //     ProductColor(
                                  //         colorImages: images
                                  //             .map((e) => e.path)
                                  //             .toList(),
                                  //         colorName: _colorNameController.text,
                                  //         id: ''));
                                  print(_colorNameController.text);
                                  print(images);

                                  colors.add(_colorNameController.text);
                                  colorsWidgets.add(ColorWidget(
                                      _colorNameController.text, images));

                                  if (sizes.isNotEmpty) {
                                    for (var size in sizes) {
                                      var variant = ProductVariant(
                                          variantAttributes: VariantAttributes(
                                              variantColor: VariantColor(
                                                  colorName:
                                                      _colorNameController
                                                          .text),
                                              variantSize: size),
                                          id: '',
                                          variantPrice: '',
                                          productId: '');
                                      variants.add(variant);

                                      pricesContollers[variant] =
                                          TextEditingController();
                                      print(colorsWidgets.length);
                                      images = [];
                                      _colorNameController.text = "";
                                    }
                                  } else {
                                    setState(() {
                                      images = [];
                                      _colorNameController.text = "";
                                    });
                                  }
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Sizes :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sizes.length,
                                    itemBuilder: (context, item) => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                              border: Border.all(
                                                  width: 1.5,
                                                  color: Colors.black)),
                                          height: 25,
                                          child: Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(sizes[item]),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        variants.removeWhere(
                                                            (element) =>
                                                                element
                                                                    .variantAttributes
                                                                    .variantSize ==
                                                                sizes[item]);
                                                        sizes.remove(
                                                            sizes[item]);
                                                      });
                                                    },
                                                    child: Container(
                                                        child: Icon(Icons
                                                            .delete_sharp)),
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  )
                                                ]),
                                          ),
                                        )))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          width: 160,
                          alignment: Alignment.center,
                          height: 40,
                          child: TextFormField(
                            controller: _sizeController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'Enter Size ',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            color: GlobalVariables.secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextButton(
                            child: const Text(
                              'Add Size',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_sizeController.text.isNotEmpty) {
                                  sizes.add(_sizeController.text);
                                  if (colors.isNotEmpty) {
                                    for (var color in colors) {
                                      var variant = ProductVariant(
                                          variantAttributes: VariantAttributes(
                                              variantColor: VariantColor(
                                                  colorName: color),
                                              variantSize:
                                                  _sizeController.text),
                                          id: '',
                                          variantPrice: '',
                                          productId: '');
                                      variants.add(variant);
                                      pricesContollers[variant] =
                                          TextEditingController();
                                      print(colorsWidgets.length);
                                    }

                                    _sizeController.text = "";
                                  }
                                }
                              });
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Prices :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: variants.length * 50,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: variants.length,
                              itemBuilder: (context, index) => Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        PricesWidget(
                                            color: variants[index]
                                                .variantAttributes
                                                .variantColor
                                                .colorName,
                                            size: variants[index]
                                                .variantAttributes
                                                .variantSize),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black)),
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: pricesContollers[
                                                variants[index]],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                        ),
                        // Column(
                        //   children: productPrices,
                        // ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              print(pricesContollers[variants[1]]!.text);
                            },
                            child: const Text(
                              'Add Product',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    )),
                  ])),
        )));
  }
}
