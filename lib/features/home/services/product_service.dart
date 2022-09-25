import 'dart:convert';
import 'dart:io';

import 'package:aroundix_task/models/product_model.dart';
import 'package:aroundix_task/providers/productsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ProductService {
  // get all products

  getAllProducts({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      http.Response res = await http.get(
        Uri.parse(
          'https://aroundix-flutter-test-backend.herokuapp.com/API/get-all-products',
        ),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      var products = jsonDecode(res.body)['products'];

      List<Product> allProducts = [];

      for (var i = 0; i < products.length; i++) {
        allProducts.add(Product.fromJson(jsonDecode(res.body)['products'][i]));
      }

      Provider.of<ProductsProvider>(context, listen: false)
          .setProducts(allProducts);
    } catch (err) {
      print(err.toString());
    }
  }

  // add product

  addProduct({required Product product}) async {
    var dio = Dio();
    Map<String, List<dynamic>> images = {};
    for (var color in product.productOptions.productColors) {
      images[color.colorName] = [];

      for (var image in color.colorImages) {
        String filename = image.split('/').last;
        images[color.colorName]!.add({
          "image": await MultipartFile.fromFile(
            image,
            filename: filename,
            contentType: MediaType('image', 'jpg'),
          ),
          "type": "image/$filename}"
        });
      }
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      Map<String, dynamic> requestBody = {'productName': product.productName};
      for (var i = 0; i < product.productOptions.productColors.length; i++) {
        requestBody['productColors[$i][colorName]'] =
            product.productOptions.productColors[0].colorName;
        requestBody['productColors[$i][colorImages]'] =
            images[product.productOptions.productColors[0].colorName];
      }
      for (var i = 0; i < product.productOptions.productSizes.length; i++) {
        requestBody['productSizes[$i]'] =
            product.productOptions.productSizes[i];
      }
      for (var i = 0; i < product.productVariants.length; i++) {
        requestBody['productVariations[$i][variantPrice]'] =
            product.productVariants[i].variantPrice;
        requestBody[
                'productVariations[$i][variantAttributes][variantColor][colorName]'] =
            product.productVariants[i].variantAttributes.variantColor.colorName;
        requestBody['productVariations[$i][variantAttributes][variantSize]'] =
            product.productVariants[i].variantAttributes.variantSize;
      }

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";
      FormData formData = FormData.fromMap(requestBody);
      var response = await dio.post(
          "https://aroundix-flutter-test-backend.herokuapp.com/API/add-product",
          data: formData);
      print(response);
    } catch (err) {
      print(err.toString());
    }
  }

  // get product by Id
  getProductById({
    required String id,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      http.Response res = await http.get(
        Uri.parse(
            'https://aroundix-flutter-test-backend.herokuapp.com/API/get-product-by-id/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        Product product = Product.fromJson(jsonDecode(res.body)['product']);
        return null;
      } else {
        print(res.body);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
