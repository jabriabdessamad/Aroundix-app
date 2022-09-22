import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/auth/services/auth_service.dart';
import 'package:aroundix_task/features/home/screens/add_product_screen.dart';
import 'package:aroundix_task/features/home/services/product_service.dart';
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
  AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    productService.getAllProducts(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = Provider.of<ProductsProvider>(context).allProducts;

    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('get Product'),
          onPressed: () {
            productService.getAllProducts(context: context);

            // print(Provider.of<ProductsProvider>(context, listen: false)
            //     .allProducts[0]
            //     .productOptions
            //     .productColors[0]
            //     .colorName);

            // print(Provider.of<UserProvider>(context, listen: false)
            //     .currentUser
            //     .products);

            // print(Provider.of<UserProvider>(context, listen: false)
            //     .currentUser
            //     .products[0]);

            // print(Provider.of<UserProvider>(context, listen: false)
            //     .currentUser
            //     .token);
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductScreen()));
        },
        tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
