import 'package:flutter/cupertino.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

Widget conainerButton(BuildContext context, String text, IconData icon,
    double width, Color color, VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      width: MediaQuery.of(context).size.width * width,
      height: 40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kcWhite,
          ),
          SizedBox(width: 4),
          Text(text, style: stFFFFFF400Rubik12.copyWith(color: kcWhite, fontSize: 10))
        ],
      ),
    ),
  );
}
