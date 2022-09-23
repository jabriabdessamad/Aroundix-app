import 'package:aroundix_task/features/home/widgets/prices_widget.dart';
import 'package:aroundix_task/models/product_model.dart';
import 'package:flutter/material.dart';

class SizeWidget extends StatefulWidget {
  List<String> colors;
  List<String> sizes;
  List<Widget> productPrices;
  String size;
  List<ProductVariant> variants;

  SizeWidget(
      {super.key,
      required this.colors,
      required this.sizes,
      required this.size,
      required this.productPrices,
      required this.variants});

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
            for (var color in widget.colors) {
              // widget.productPrices
              //     .add(PricesWidget(color: color, size: widget.size));

              widget.variants.add(ProductVariant(
                  variantAttributes: VariantAttributes(
                      variantColor: VariantColor(colorName: color),
                      variantSize: widget.size),
                  id: '',
                  variantPrice: '',
                  productId: ''));
            }
            widget.sizes.add(widget.size);
          } else {
            for (var color in widget.colors) {
              widget.productPrices
                  .remove(PricesWidget(color: color, size: widget.size));
            }
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
