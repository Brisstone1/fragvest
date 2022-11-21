import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';

Widget initialLoader(double height) {
  return Container(
      height: height,
      alignment: Alignment.center,
      color: kcWhite,
      child: SpinKitSpinningLines(
        color: kc3DED97,
      ));
}
