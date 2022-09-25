import 'dart:io';
import 'dart:ui';
import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/product_details/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  String id;
  String image;
  String productName;
  ProductWidget(
      {super.key,
      required this.image,
      required this.productName,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(productId: id)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                      width: 1.5, color: GlobalVariables.secondaryColor)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.1,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.delete_outline)
                ]),
          )
        ],
      ),
    );
  }
}
