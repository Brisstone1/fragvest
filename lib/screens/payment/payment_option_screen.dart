import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';

class PaymentOptionScreen extends StatelessWidget {
  static const routeName = '/payment-option-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Payment', true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _payContainer('Pay from wallet', imgPurse, () {}),
          SizedBox(height: 20),
          _payContainer('Pay via payment gateway', imgCard, () {})
        ],
      ),
    );
  }

  Widget _payContainer(String text, String ico, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.4),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(ico, height: 30),
              SizedBox(width: 20),
              Text(
                text,
                style: st000000400Rubik14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
