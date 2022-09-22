// To parse required this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.productOptions,
    required this.id,
    required this.productName,
    required this.productVariants,
  });

  ProductOptions productOptions;
  String id;
  String productName;
  List<ProductVariant> productVariants;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productOptions: ProductOptions.fromJson(json["productOptions"]),
        id: json["_id"],
        productName: json["productName"],
        productVariants: List<ProductVariant>.from(
            json["productVariants"].map((x) => ProductVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productOptions": productOptions.toJson(),
        "_id": id,
        "productName": productName,
        "productVariants":
            List<dynamic>.from(productVariants.map((x) => x.toJson())),
      };
}

class ProductOptions {
  ProductOptions({
    required this.productSizes,
    required this.productColors,
  });

  List<String> productSizes;
  List<ProductColor> productColors;

  factory ProductOptions.fromJson(Map<String, dynamic> json) => ProductOptions(
        productSizes: List<String>.from(json["productSizes"].map((x) => x)),
        productColors: List<ProductColor>.from(
            json["productColors"].map((x) => ProductColor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productSizes": List<dynamic>.from(productSizes.map((x) => x)),
        "productColors":
            List<dynamic>.from(productColors.map((x) => x.toJson())),
      };
}

class ProductColor {
  ProductColor({
    required this.colorImages,
    required this.colorName,
    required this.id,
  });

  List<String> colorImages;
  String colorName;
  String id;

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
        colorImages: List<String>.from(json["colorImages"].map((x) => x)),
        colorName: json["colorName"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "colorImages": List<dynamic>.from(colorImages.map((x) => x)),
        "colorName": colorName,
        "_id": id,
      };
}

class ProductVariant {
  ProductVariant({
    required this.variantAttributes,
    required this.id,
    required this.variantPrice,
    required this.productId,
  });

  VariantAttributes variantAttributes;
  String id;
  String variantPrice;
  String productId;

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        variantAttributes:
            VariantAttributes.fromJson(json["variantAttributes"]),
        id: json["_id"],
        variantPrice: json["variantPrice"],
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "variantAttributes": variantAttributes.toJson(),
        "_id": id,
        "variantPrice": variantPrice,
        "productId": productId,
      };
}

class VariantAttributes {
  VariantAttributes({
    required this.variantColor,
    required this.variantSize,
  });

  VariantColor variantColor;
  String variantSize;

  factory VariantAttributes.fromJson(Map<String, dynamic> json) =>
      VariantAttributes(
        variantColor: VariantColor.fromJson(json["variantColor"]),
        variantSize: json["variantSize"],
      );

  Map<String, dynamic> toJson() => {
        "variantColor": variantColor.toJson(),
        "variantSize": variantSize,
      };
}

class VariantColor {
  VariantColor({
    required this.colorName,
  });

  String colorName;

  factory VariantColor.fromJson(Map<String, dynamic> json) => VariantColor(
        colorName: json["colorName"],
      );

  Map<String, dynamic> toJson() => {
        "colorName": colorName,
      };
}
