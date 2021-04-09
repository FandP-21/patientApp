import 'package:dinero/helpers/main.dart';
import 'package:dinero/widgets/infoItems.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60,
        ),
        Container(
          width: double.infinity,
          color: defaultBlack,
          alignment: Alignment.topCenter,
          child: Text(
            "DINERO IMPULSE",
            style: TextStyle(
              color: deepGreen,
              fontSize: massiveText,
              letterSpacing: 1,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          margin: EdgeInsets.only(bottom: 15),
          alignment: Alignment.bottomLeft,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext ctxt, int index) => InfoItems(
                    icon: Icons.info_outline,
                    title: "About company",
                  )),
        )
      ],
    );
  }
}
