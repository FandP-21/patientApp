import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/service.dart';
import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  Services({this.image, this.title});
  final String image, title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 100,
        width: 80,
        color: white,
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: deepGreen,
                fontWeight: FontWeight.w300,
                fontSize: bodyText,
              ),
              overflow: TextOverflow.clip,
              softWrap: true,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Service(
                    service: title,
                  ))),
    );
  }
}
