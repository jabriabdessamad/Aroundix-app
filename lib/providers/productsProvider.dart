import 'package:aroundix_task/models/product_model.dart';
import 'package:aroundix_task/models/user.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get allProducts => _products;

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }
}
