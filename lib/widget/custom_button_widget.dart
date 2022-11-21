import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

Widget customButton(String text, VoidCallback callback,
    {bool isActive = true,
    Color color = kc3DED97,
    double width = double.infinity}) {
  return GestureDetector(
    onTap: isActive ? callback : () {},
    child: Container(
      alignment: Alignment.center,
      height: 48,
      width: width,
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text, style: btnStyle),
    ),
  );
}
