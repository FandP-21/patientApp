import 'package:flutter/material.dart';
import 'package:thcMobile/components/headerText.dart';
import 'package:thcMobile/helpers/sizeCalculator.dart';
import 'package:thcMobile/components/plusButton.dart';
import 'package:thcMobile/components/backButtonWhite.dart';
import 'package:thcMobile/screens/dashboard/billing/paystack.dart';
import 'addCard.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class BillingDetails extends StatefulWidget {
  BillingDetails({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BillingDetailsState createState() => _BillingDetailsState();
}

class _BillingDetailsState extends State<BillingDetails> {
  var publicKey = 'pk_test_40de5d453203b696cba6bd4f8b5dfb162a4faa27';

  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: publicKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.only(
                      top: sizer(false, 50, context),
                      left: sizer(true, 20, context),
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
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: 'Billing Details'),
                        SizedBox(height: 28),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Manage Cards',
                              style: TextStyle(
                                  color: Color(0xff8E919C),
                                  fontSize: sizer(true, 20, context)),
                            ),
                            PlusButton(onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => AddCard(title: '')));
                            }),
                          ],
                        ),
                        SizedBox(height: 36),
                        card('Mastercard', '3878'),
                      ]),
                )))));
  }

  Widget card(String type, String lastDigits) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: sizer(false, 10, context)),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xff2254D3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(34, 84, 211, 0.3),
              spreadRadius: 3,
              //   blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/cardIcon.png',
              width: 26,
              height: 16,
            ),
            SizedBox(width: 10),
            Text(type,
                style: TextStyle(
                    color: Colors.white, fontSize: sizer(true, 20, context))),
            SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
            ),
            SizedBox(width: 6),
            Text(lastDigits,
                style: TextStyle(
                    color: Colors.white, fontSize: sizer(true, 20, context))),
            Spacer(),
            Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  // side: BorderSide(color: Colors.red)
                ),
                color: Color(0xff436dda),
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xff436dda),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 16,
                          color: Colors.white,
                        ))))
          ],
        ),
      ),
      onTap: () => {},
    );
  }
}
