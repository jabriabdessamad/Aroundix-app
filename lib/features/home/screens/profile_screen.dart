import 'package:aroundix_task/features/auth/services/auth_service.dart';
import 'package:aroundix_task/features/home/services/product_service.dart';
import 'package:aroundix_task/features/home/widgets/info_card.dart';
import 'package:aroundix_task/features/home/widgets/list_product_widget.dart';
import 'package:aroundix_task/models/product_model.dart';
import 'package:aroundix_task/models/user.dart';
import 'package:aroundix_task/providers/productsProvider.dart';
import 'package:aroundix_task/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:aroundix_task/features/home/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    _auth.getUserData(context);
    _productService.getAllProducts(context: context);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).currentUser;
    List<Product> products = Provider.of<ProductsProvider>(context).allProducts;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            Text(
              user.fullName,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico",
              ),
            ),

            SizedBox(
              height: 30,
            ),

            // we will be creating a new widget name info carrd
            InfoCard(
              text: user.email,
              icon: Icons.email,
            ),
            InfoCard(
              text: user.password,
              icon: Icons.lock,
            ),
            InfoCard(
              text: '+212 651890096',
              icon: Icons.phone,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 26,
                ),
                Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: user.products.length * 60,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: user.products.length,
                  itemBuilder: (context, item) => ListProductWidget(
                        productName: products[item].productName,
                        productImage: products[item]
                            .productOptions
                            .productColors[0]
                            .colorImages[0],
                      )),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}
