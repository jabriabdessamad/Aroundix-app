import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/auth/services/auth_service.dart';
import 'package:aroundix_task/features/home/screens/add_product_screen.dart';
import 'package:aroundix_task/features/home/services/product_service.dart';
import 'package:aroundix_task/features/home/widgets/product_widget.dart';
import 'package:aroundix_task/providers/productsProvider.dart';
import 'package:aroundix_task/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    productService.getAllProducts(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = Provider.of<ProductsProvider>(context).allProducts;
    final AuthService _auth = AuthService();

    return (allProducts.isEmpty)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      _auth.logout();
                    },
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ))
              ],
              title: Text(
                'Products',
                style: TextStyle(),
              ),
              backgroundColor: GlobalVariables.secondaryColor,
            ),
            body: Container(
              child: GridView.builder(
                itemCount: allProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final product = allProducts[index];
                  return ProductWidget(
                      id: product.id,
                      image: product
                          .productOptions.productColors[0].colorImages[0],
                      productName: product.productName);
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: GlobalVariables.secondaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductScreen()));
              },
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
