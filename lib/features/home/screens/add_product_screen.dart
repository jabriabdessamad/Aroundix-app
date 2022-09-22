import 'dart:io';
import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/constants/utils.dart';
import 'package:aroundix_task/models/product_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:aroundix_task/shared/widgets/costum_text_form_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _colorNameController = TextEditingController();

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
                    // ColorWidget(
                    //   images: images,
                    //   colorName: ,
                    // ),
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
                                        child: Text('${images.length} Images'),
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
                                      images: images,
                                      colorName: _colorNameController.text));
                                  print(colorsWidgets.length);

                                  images = [];
                                  _colorNameController.text = "helloo";
                                });

                                //Navigator.pop(context);

                                //print((newProduct!.toJson()));
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
                          children: const [
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizeWidget(
                                size: 'XS',
                                sizes: sizes,
                              ),
                              SizeWidget(size: 'S', sizes: sizes),
                              SizeWidget(size: 'M', sizes: sizes),
                              SizeWidget(size: 'L', sizes: sizes),
                              SizeWidget(size: 'XL', sizes: sizes),
                              SizeWidget(size: 'XLL', sizes: sizes)
                            ],
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
                        PricesWidget(
                          variants: variants,
                          prices: prices,
                          colors: colors,
                          sizes: sizes,
                        ),
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
                            onPressed: () {},
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

class SizeWidget extends StatefulWidget {
  List<String> sizes = [];

  String size;
  SizeWidget({super.key, required this.size, required this.sizes});

  @override
  State<SizeWidget> createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          if (isSelected == true) {
            widget.sizes.add(widget.size);
          } else {
            widget.sizes.remove(widget.size);
          }
        });
        print(widget.sizes);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 20,
        width: 50,
        decoration: BoxDecoration(
          color: !isSelected ? Colors.transparent : Colors.black,
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
            child: Text(
          widget.size,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        )),
      ),
    );
  }
}

class ColorWidget extends StatefulWidget {
  final String colorName;
  final List<File> images;
  const ColorWidget({super.key, required this.images, required this.colorName});

  @override
  State<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
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

  @override
  Widget build(BuildContext context) {
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
            widget.colorName,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        SizedBox(
          width: 2,
          child: Container(color: Colors.black),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 144,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 5,
                ),
                Row(children: ImagesWidgets(widget.images))
              ],
            ))
      ]),
    );
  }
}

class PricesWidget extends StatefulWidget {
  final List<String> colors;
  final List<String> sizes;
  final List<ProductVariant> variants;
  final List<String> prices;
  const PricesWidget(
      {super.key,
      required this.variants,
      required this.prices,
      required this.colors,
      required this.sizes});

  @override
  State<PricesWidget> createState() => _PricesWidgetState();
}

class _PricesWidgetState extends State<PricesWidget> {
  void getVariants() {
    for (var i in widget.colors) {
      for (var j in widget.sizes) {
        widget.variants.add(ProductVariant(
            variantAttributes: VariantAttributes(
                variantColor: VariantColor(colorName: i), variantSize: j),
            id: '',
            variantPrice: '',
            productId: ''));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getVariants();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.colors.isNotEmpty && widget.prices.isNotEmpty)
        ? Column(
            children: [
              for (var i in widget.variants)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 100,
                      height: 20,
                      child: Text('variant'),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextFormField(),
                    )
                  ],
                )
            ],
          )
        : Container();
  }
}
