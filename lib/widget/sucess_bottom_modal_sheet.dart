import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'custom_button_widget.dart';

showBottmModelShweet(BuildContext context, String message) {
  showMaterialModalBottomSheet(
    // bounce: true,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset(imgTickSquare, height: 40),
          const SizedBox(height: 30),
          Text(
            // 'Thank you for taking your time to fill out the details required',
            message,
            style: st0C0932500Rubik17,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 70),
          customButton('Back', () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          })
        ],
      ),
    ),
  );
}

showBottmModelSheetThreePop(BuildContext context, String message) {
  showMaterialModalBottomSheet(
    // bounce: true,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset(imgTickSquare, height: 40),
          const SizedBox(height: 30),
          Text(
            // 'Thank you for taking your time to fill out the details required',
            message,
            style: st0C0932500Rubik17,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 70),
          customButton('Back', () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          })
        ],
      ),
    ),
  );
}

showBottmModelSheetCustomNaav(
    BuildContext context, String message, VoidCallback callback) {
  showMaterialModalBottomSheet(
    // bounce: true,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset(imgTickSquare, height: 40),
          const SizedBox(height: 30),
          Text(
            // 'Thank you for taking your time to fill out the details required',
            message,
            style: st0C0932500Rubik17,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 70),
          customButton('Back', callback)
        ],
      ),
    ),
  );
}
