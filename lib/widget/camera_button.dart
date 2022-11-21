import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

Widget cameralButton(VoidCallback voidCallback, BuildContext context,
    String text, IconData icon, double width) {
  return GestureDetector(
    onTap: voidCallback,
    child: Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 3),
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        color: kc3DED97.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kc3DED97,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: st0C0932500Rubik14.copyWith(
              color: Color(0xFF07C168),
            ),
          ),
        ],
      ),
    ),
  );
}
