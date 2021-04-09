import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class InfoItems extends StatelessWidget {
  InfoItems({this.icon, this.title, this.route});
  final Widget route;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: deepGreen,
                fontWeight: FontWeight.w400,
                fontSize: largeText,
              ),
            ),
            Icon(icon, color: deepGreen, size: 24,),
          ],
        ),
      ),
    );
  }
}
