import 'package:aroundix_task/constants/global_variables.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;

  InfoCard({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                  width: 1.5, color: GlobalVariables.secondaryColor)),
          child: ListTile(
            leading: Icon(
              icon,
              color: GlobalVariables.secondaryColor,
            ),
            title: Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Source Sans Pro"),
            ),
          ),
        ),
      ),
    );
  }
}
