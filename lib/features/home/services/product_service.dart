import 'dart:convert';

import 'package:aroundix_task/models/product_model.dart';
import 'package:aroundix_task/providers/productsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  // get all products

  void getAllProducts({
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

      print(Provider.of<ProductsProvider>(context, listen: false)
          .allProducts[0]
          .productOptions
          .productSizes);
    } catch (err) {
      print(err.toString());
    }
  }

  // add product

}
