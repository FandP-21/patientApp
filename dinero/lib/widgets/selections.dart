import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class Selections extends StatelessWidget {
  Selections({this.title, this.route});
  final Widget route;
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
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
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => route)),
    );
  }
}
