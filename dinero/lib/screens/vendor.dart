import 'package:dinero/helpers/main.dart';
import 'package:flutter/material.dart';

class Vendor extends StatelessWidget {
  Vendor(
      {this.name,
      this.location,
      this.phone,
      this.photo,
      this.address,
      this.bio});
  final String name, location, phone, photo, address, bio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                width: double.infinity,
                height: 120,
                alignment: Alignment.center,
                child: Container(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(photo),
                  ),
                ),
              ),
              // SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  "$name",
                  style: TextStyle(
                    color: deepGreen,
                    fontWeight: FontWeight.w500,
                    fontSize: massiveText - 4,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Location: $location"),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            color: defaultGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "$bio",
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
                              text: "$address",
                              style: TextStyle(
                                color: deepGreen,
                                fontSize: smallText,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ])),
                        ),
                        SizedBox(height: 10,),
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
                              text: "$phone",
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
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 45,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: deepGreen,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "SEND MESSAGE",
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w400,
                            fontSize: largeText,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
