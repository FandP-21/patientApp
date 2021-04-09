import 'package:dinero/helpers/main.dart';
import 'package:dinero/screens/onboarding.dart';
import 'package:dinero/screens/service.dart';
import 'package:dinero/widgets/searchInput.dart';
import 'package:dinero/widgets/services.dart';
import 'package:flutter/material.dart';


class Hire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: deepGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 25),
              padding: EdgeInsets.only(left: 10, right: 20),
              height: 50,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: SearchInput(
                      hint: "Search",
                      controller: TextEditingController(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: white,
                          size: 24,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.power_settings_new,
                            color: white,
                            size: 24,
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Onboarding())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.70,
            width: double.infinity,
            child: GridView.builder(
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext ctxt, int index) => Services(
                      image: "assets/icons/mechanic.png",
                      title: "Mechanic",
                    )),
          ),
        ],
      );
  }
}