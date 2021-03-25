import 'package:dinero/helpers/main.dart';
import 'package:dinero/widgets/vendors.dart';
import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  Service({this.service});
  final String service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: deepGreen,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "$service",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w500,
                  fontSize: massiveText-4,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.9,
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (BuildContext ctxt, int index) => Vendors(
                        address: "Somewhere on earth",
                        bio: "Walahi I sabi work!",
                        location: "Lagos, Nigeria",
                        name: "Ebonyi Abakaliki",
                        phone: "+449404",
                        photo: "assets/icons/gardener.png",
                      )),
            )
          ],
        ),
      ),
    );
  }
}
