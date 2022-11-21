import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';

Widget futureErrorMessage(VoidCallback callback, String errorMessage) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          color: kc3DED97,
          onPressed: callback,
          child: Text(errorMessage),
        )
      ],
    ),
  );
}
