import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thcMobile/services/paymentMethods.dart';

String backendUrl = 'http://3.21.124.223/';
String paystackPublicKey = 'pk_test_40de5d453203b696cba6bd4f8b5dfb162a4faa27';
const String appName = 'Payment';

class PayStack extends StatefulWidget {
  @override
  _PayStackState createState() => _PayStackState();
}

class _PayStackState extends State<PayStack> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int radioValue = 1;
  CheckoutMethod method = CheckoutMethod.card;
  bool inProgress = false;
  String cvv = "";
  String cardNumber = "";
  int expiryMonth, expiryYear;

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Text(
                      "Payment Methods",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 25),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                              "assets/images/paystack-opengraph.png",
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                      onTap: () => PaymentMethods().paystack(
                          context,
                          cardNumber,
                          cvv,
                          expiryMonth,
                          expiryYear,
                          5,
                          (a) => Fluttertoast.showToast(msg: a)),
                    ),
                  ],
                ),
              )),
        ));
  }
}
