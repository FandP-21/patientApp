import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/vendor.dart';
import 'package:flutter/material.dart';

class Vendors extends StatelessWidget {
  Vendors(
      {this.name,
      this.location,
      this.phone,
      this.photo,
      this.address,
      this.bio});
  final String name, location, phone, photo, address, bio;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(photo),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.7,
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    style: TextStyle(
                      color: deepGreen,
                      fontWeight: FontWeight.w400,
                      fontSize: largeText,
                    ),
                  ),
                  Text(
                    "$location",
                    style: TextStyle(
                      color: defaultBlack,
                      fontWeight: FontWeight.w300,
                      fontSize: smallText,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Vendor(
                    address: address,
                    name: name,
                    bio: bio,
                    location: location,
                    phone: phone,
                    photo: photo,
                  ))),
    );
  }
}
