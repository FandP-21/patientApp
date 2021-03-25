import 'package:flutter/material.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/helpers/store.dart';
import 'package:thcMobile/screens/dashboard/forums/forumChat.dart';

class ForumDetails extends StatefulWidget {
  ForumDetails({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _ForumDetailsState createState() => _ForumDetailsState();
}

class _ForumDetailsState extends State<ForumDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
          Container(
            width: double.infinity,
            height: 258,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/forumBackground.png'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  BackButtonWhite(
                    onPressed: () {},
                  ),
                ])
              ],
            ),
          ),
          SizedBox(height: sizer(false, 30, context)),
          Padding(
              padding: EdgeInsets.only(
                  left: sizer(true, 20, context),
                  right: sizer(true, 20, context)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: black,
                        fontSize: pixel28,
                        fontWeight: bold,
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Date Created',
                              style: TextStyle(
                                  fontSize: sizer(true, 16.0, context),
                                  color: Color(0xff8E919C)),
                            ),
                            Text(
                              '08/10/2019',
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 20, context)),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Member count',
                              style: TextStyle(
                                  fontSize: sizer(true, 16.0, context),
                                  color: Color(0xff8E919C)),
                            ),
                            Text(
                              '200',
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontSize: sizer(true, 20, context)),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Raising say express had chiefly detract demands she. Quiet led own cause three him. Front no party young abode state up. Saved he do fruit woody of to. Met defective are allowance two perceived listening consulted contained. It chicken oh colonel pressed excited suppose to shortly. ',
                      style: TextStyle(
                          color: Color(0xff071232),
                          fontWeight: FontWeight.w300,
                          fontSize: sizer(true, 16.0, context)),
                    ),
                    vertical(10, true, context),
                    ButtonBlue(
                        title: 'JOIN GROUP',
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForumChat(
                                      title: widget.title,
                                    )))),
                  ]))
        ]))));
  }
}
