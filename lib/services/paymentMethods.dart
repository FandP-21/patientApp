import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';
import 'package:thcMobile/provider/user.dart';
import 'dart:convert';

class PaymentMethods {
  paystack(BuildContext context, String cardNumber, String cvv, int expiryMonth,
      int expiryYear, double price, Function(String a) onSuccess) async {
    Charge charge = Charge();
    charge.card = _getCardFromUI(cardNumber, cvv, expiryMonth, expiryYear);
    charge
      ..amount = price.toInt()
      ..reference = _getReference()
      ..transactionCharge = 10
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = jsonDecode(
              Provider.of<UserModel>(context, listen: false).patient)['user']
          ['email'];
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
      hideAmount: false,
      hideEmail: false,
      logo: Container(
          height: 80, width: 80, child: Image.asset("assets/images/thc.png")),
    );
    onSuccess(response.message);
  }

  PaymentCard _getCardFromUI(
      String cardNumber, String cvv, int expiryMonth, int expiryYear) {
    // Using just the must-required parameters.
    return PaymentCard(
      number: cardNumber,
      cvc: cvv,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    // Fluttertoast.showToast(msg: response.message.toString());
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
    // Use the response
  }
}
