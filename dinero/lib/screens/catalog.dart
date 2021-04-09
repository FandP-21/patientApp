import 'package:dinero/helpers/main.dart';
import 'package:dinero/widgets/catalogItems.dart';
import 'package:dinero/widgets/searchInput.dart';
import 'package:dinero/widgets/vendors.dart';
import 'package:flutter/material.dart';

class Catalog extends StatelessWidget {
  Catalog({this.service});
  final String service;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: deepGreen,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SearchInput(
                hint: "Search",
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.9,
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (BuildContext ctxt, int index) => CatalogItems(
                        title: "Housemaid",
                        photo: "assets/icons/maid.png",
                      )),
            )
          ],
        ),
    );
  }
}
