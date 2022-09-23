import 'dart:io';
import 'package:aroundix_task/constants/global_variables.dart';
import 'package:flutter/material.dart';

class ColorWidget extends StatefulWidget {
  final String colorName;
  final List<File> images;
  ColorWidget({
    super.key,
    required this.images,
    required this.colorName,
  });

  @override
  State<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
  List<Widget> ImagesWidgets(List<File> images) {
    List<Widget> list = [];
    if (images.isNotEmpty) {
      for (var i = 0; i < images.length; i++) {
        list.add(
          Container(
            height: 50,
            width: 50,
            child: Image(image: FileImage(images[i])),
          ),
        );
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: GlobalVariables.secondaryColor),
      ),
      child: Row(children: [
        Container(
          width: 80,
          alignment: Alignment.center,
          child: Text(
            widget.colorName,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        SizedBox(
          width: 2,
          child: Container(color: Colors.black),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 5,
                ),
                Row(children: ImagesWidgets(widget.images))
              ],
            )),
      ]),
    );
  }
}
