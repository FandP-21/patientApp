import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/apply.dart';
import 'package:flutter/material.dart';

class CatalogItems extends StatelessWidget {
  CatalogItems({this.title, this.photo});
  final String title, photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 20, bottom: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 55,
              width: 55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(photo),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.6,
              color: white,
              alignment: Alignment.centerLeft,
              child: Text(
                "$title",
                style: TextStyle(
                    color: deepGreen,
                    fontSize: largeText+2,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: deepGreen,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.exit_to_app,
                color: white,
                size: 22
              ),
            )
          ],
        ),
      ),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Apply(
            address: "Somewhere on earth",
            bio: "Walahi I sabi work!",
            email: "iSabi@walahi.nojokes",
            location: "Lagos, Nigeria.",
            name: "Ebonyi Abakaliki",
            phone: "+449404",
            title: title,
          ))),
    );
  }
}
