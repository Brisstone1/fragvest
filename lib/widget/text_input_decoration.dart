import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

final borderTextInputDecoration = InputDecoration(
  // focusedBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(5)),
  //   borderSide: BorderSide(width: 1, color: Colors.grey),
  // ),
  // contentPadding: EdgeInsets.all(12),
  // enabledBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(5)),
  //   borderSide: BorderSide(width: 1, color: kcD6D6D6),
  // ),
  // border: OutlineInputBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(5)),
  //     borderSide: BorderSide(width: 1, color: Colors.grey)),
  // hintStyle: TextStyle(fontSize: 16, color: kcB3B1B1),

  // hintText: "example@quickr.com",
  hintStyle: TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
  filled: true, //<-- SEE HERE
  fillColor: Color(0xFFF5F5F8),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 5, color: Color(0xFFF5F5F8)),
    borderRadius: BorderRadius.circular(5.0),
    //<-- SEE HERE
  ),
);

final colapseDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
  filled: true, //<-- SEE HERE
  fillColor: Color(0xFFF5F5F8),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 5, color: Color(0xFFF5F5F8)),
    borderRadius: BorderRadius.circular(5.0),
    //<-- SEE HERE
  ),
);

final noBorderDecoration = borderTextInputDecoration.copyWith(
  border: InputBorder.none,
);

InputDecoration creditCard(String labelText, String hintText) {
  return borderTextInputDecoration.copyWith(
      labelStyle: textfieldStyle,
      hintStyle: textfieldStyle,
      labelText: labelText,
      hintText: hintText);
}

InputDecoration supportDecoration = InputDecoration(
  border: InputBorder.none,
  filled: true,
  fillColor: kcF2F2F2,
  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
  focusedBorder: OutlineInputBorder(
    // borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(5.0),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kcF2F2F2),
    borderRadius: BorderRadius.circular(5.0),
  ),
);
