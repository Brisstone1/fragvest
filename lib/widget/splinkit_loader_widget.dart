import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';

Widget spinKitLoaderWidget() {
  return Container(
      alignment: Alignment.center,
      height: 45.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kc3DED97,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const SpinKitFadingCircle(
        color: kcWhite,
        size: 45.0,
      ));
}
