import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

Widget arrowDropDown() {
  return Container(

    child: const Icon(Icons.arrow_drop_down),
  );
}

Widget dropdownhint(String text) {
  return Container(
    // offset: Offset(0, 10),
    child: Text(
      text,
      style: textfieldStyle,
    ),
  );
}

Widget boxContainerWithoutEdit(String text, String email, IconData icon,
    Color color, Color textColor, VoidCallback callback) {

  return GestureDetector(
    onTap: callback,
    child: Container(
        padding: const EdgeInsets.only(left: 30),
        margin: const EdgeInsets.only(bottom: 7),
        alignment: Alignment.centerLeft,
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(

          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(icon != null)
              Icon(icon, color: Color(0xFFFFFFFF),),
            SizedBox(width: 30),
            expandedWithoutEdit(text, email, textColor)
          ],
        )),
  );
}

Widget expandedWithoutEdit(String text, String email, Color textColor) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
            fontSize: 12
        )),
        SizedBox(height: 8),
        Text(
          email,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 12
          ),
        ),
      ],
    ),
  );
}

Widget boxContainerWithEdit(String text, String email, IconData icon,
    Color color, Color textColor, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
        padding: const EdgeInsets.only(left: 30),
        margin: const EdgeInsets.only(bottom: 7),
        alignment: Alignment.centerLeft,
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Icon(icon, color: Color(0xFFFFFFFF),),
            SizedBox(width: 30),
            expandedWithEdit(text, email, textColor)
          ],
        )),
  );
}

Widget expandedWithEdit(String text, String email, Color textColor) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 12,
          fontWeight: FontWeight.w600

        )),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            email,
            style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w600

            ),
          ),
        ),
      ],
    ),
  );
}

Widget displayRightPostion(String text, Color color) {
  return Positioned(
    bottom: 30,
    right: 20,
    child: Container(
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
      child: Text(text, style: st2F54C6400Rubik11.copyWith(color: kc2F54C6)),
    ),
  );
}

Widget appartment(String text, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      decoration: BoxDecoration(
          border: Border.all(color: kc535353),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        style: st535353400Rubik14,
      ),
    ),
  );
}

Widget rooms(String text, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 20),
      height: 36,
      width: 53,
      decoration: BoxDecoration(
          border: Border.all(color: kc535353),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        style: st535353400Rubik14,
      ),
    ),
  );
}
