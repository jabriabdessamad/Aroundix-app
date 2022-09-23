import 'package:flutter/material.dart';

class PricesWidget extends StatefulWidget {
  final String color;
  final String size;

  PricesWidget({super.key, required this.color, required this.size});

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          height: 20,
          child: Text('${widget.color}/${widget.size}'),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
        ),
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(),
        )
      ],
    );
  }
}
