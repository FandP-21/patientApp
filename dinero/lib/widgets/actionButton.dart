import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class Actionbutton extends StatelessWidget {
  Actionbutton({this.title, this.onPressed});
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          child: Container(
            height: 50,
            color: Colors.white.withOpacity(0.05),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: bodyText,
                fontWeight: FontWeight.w300,
                color: defaultGreen,
              ),
            ),
          ),
          onTap: onPressed),
    );
  }
}
