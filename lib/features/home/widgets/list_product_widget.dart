import 'package:flutter/material.dart';

class ListProductWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  const ListProductWidget({
    super.key,
    required this.productName,
    required this.productImage,
  });

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          child: Row(children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(widget.productImage))),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.productName,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ]),
        ),
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border:
                  Border.all(width: 2, color: Color.fromARGB(255, 7, 223, 14))),
          child: Text(
            'active',
            style: TextStyle(
                color: Color.fromARGB(255, 10, 197, 16),
                fontWeight: FontWeight.w600),
          ),
        )
      ]),
    );
  }
}
