import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile(
      {this.name,
      this.location,
      this.phone,
      this.photo,
      this.address,
      this.bio});
  final String name, location, phone, photo, address, bio;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  alignment: Alignment.center,
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset("assets/icons/plumber.png"),
                    ),
                  ),
                ),
                // SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "Ekiti Ado-Ekiti",
                    style: TextStyle(
                      color: deepGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: massiveText - 4,
                    ),
                  ),
                ),
                Text("Location: Benue, Makurdi"),
              ],
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bio:",
                          style: TextStyle(
                            color: deepGreen,
                            fontSize: largeText + 2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 120,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: defaultGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Bill me small small",
                          style: TextStyle(
                              color: white,
                              fontSize: bodyText,
                              fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Details:",
                          style: TextStyle(
                            color: deepGreen,
                            fontSize: largeText + 2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Address: ",
                            style: TextStyle(
                              color: deepGreen,
                              fontWeight: FontWeight.w400,
                              fontSize: bodyText,
                            ),
                          ),
                          TextSpan(
                            text: "Middle East, Sierra Leone. Afghanistan.",
                            style: TextStyle(
                              color: deepGreen,
                              fontSize: smallText,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ])),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Contact: ",
                            style: TextStyle(
                              color: deepGreen,
                              fontWeight: FontWeight.w400,
                              fontSize: bodyText,
                            ),
                          ),
                          TextSpan(
                            text: "+1 44434",
                            style: TextStyle(
                              color: deepGreen,
                              fontSize: smallText,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ])),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 60,
                      alignment: Alignment.center,
                      width: 60,
                      decoration: BoxDecoration(
                        color: deepGreen,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
