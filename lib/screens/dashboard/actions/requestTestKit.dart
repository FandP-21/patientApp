import 'package:flutter/material.dart';
import 'package:thcMobile/components/subText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/buttonBlue.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/helpers/store.dart';
import 'requestTestKitDetails.dart';
import 'requestTestKitSummary.dart';

unKit(String title) {
  var a = title.split(' ');
  a.remove('Kit');
  return a.join(' ');
}

class RequestTestKit extends StatefulWidget {
  RequestTestKit({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RequestTestKitState createState() => _RequestTestKitState();
}

class _RequestTestKitState extends State<RequestTestKit> {
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
                child: Padding(
      padding: EdgeInsets.only(
          top: sizer(false, 50, context),
          left: sizer(true, 20, context),
          bottom: 40,
          right: sizer(true, 20, context)),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BackButtonWhite(
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: sizer(false, 30, context)),
            Text(
              'Order Home Testkit',
              style: TextStyle(
                color: black,
                fontSize: pixel24,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 15),
            SubText(
              title: 'Take a hometest with one of out Home Test kits.',
              isCenter: false,
            ),
            SizedBox(height: 45),
            SubText(
              title: 'Choose test package',
              isCenter: false,
            ),
            SizedBox(height: 18),
            CheckListTile(title: 'Advanced Thyroid Test Kit'),
            CheckListTile(title: 'Advanced Thyroid Test Kit'),
            CheckListTile(title: 'Advanced Thyroid Test Kit'),
            CheckListTile(title: 'Advanced Thyroid Test Kit'),
            CheckListTile(title: 'Advanced Thyroid Test Kit', last: true),
            SizedBox(height: 67),
            ButtonBlue(
              title: 'NEXT',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RequestTestKitSummary(
                        title: unKit('Advanced Thyroid Test Kit'))));
              },
            )
          ]),
    ))));
  }
}

class CheckListTile extends StatefulWidget {
  CheckListTile({@required this.title, this.last, this.iconPresent});
  final String title;
  final bool last, iconPresent;

  @override
  _CheckListTileState createState() => _CheckListTileState();
}

class _CheckListTileState extends State<CheckListTile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
        decoration: BoxDecoration(
            border: Border(
                bottom: widget.last == null
                    ? BorderSide(color: Color(0xffF3F4F8), width: 1.0)
                    : BorderSide.none)),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    if (value == false)
                      setState(() => value = true);
                    else
                      setState(() => value = false);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: value ? blue : Color.fromRGBO(223, 232, 252, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(10),
                    child: Checkbox(
                      onChanged: (val) => {},
                      value: value,
                      activeColor: blue,
                      checkColor: Colors.white,
                    ),
                  )),
              SizedBox(width: sizer(true, 17, context)),
              Text(widget.title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Spacer(),
              SizedBox(width: 82.8),
              widget.iconPresent == null
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => RequestTestKitDetails(
                                title: unKit(widget.title))));
                      },
                      icon: Icon(Icons.info_outline,
                          color: Color(0xff245DE8),
                          size: sizer(true, 22, context)))
                  : SizedBox(
                      height: 22,
                    ),
            ]));
  }
}
