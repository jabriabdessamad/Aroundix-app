import 'package:aroundix_task/models/product_model.dart';
import 'package:flutter/material.dart';

class PricesWidget extends StatefulWidget {
  final String color;
  final String size;

  PricesWidget({
    super.key,
    required this.color,
    required this.size,
  });

  @override
  State<PricesWidget> createState() => _PricesWidgetState();
}

class _PricesWidgetState extends State<PricesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductVariant variant = ProductVariant(
        variantAttributes: VariantAttributes(
            variantColor: VariantColor(colorName: widget.color),
            variantSize: widget.size),
        id: '',
        variantPrice: '',
        productId: '');
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 30,
                child: Text('${widget.color}'),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(width: 2, color: Colors.black)),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 30,
                child: Text('${widget.size}'),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(width: 2, color: Colors.black)),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
