import 'package:flutter/material.dart';

import '../constants/kcolors.dart';
import '../utilities/styles.dart';

class SecurityPinAlert extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback cancel;
  final VoidCallback proceed;
  const SecurityPinAlert({
    Key key,
    this.title,
    this.message,
    this.cancel,
    this.proceed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      height: 184,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title, style: st0000000500Rubik14),
        SizedBox(height: 12),
        Text(
          message,
          style: st535353700Rubik13.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                child: _buttonWidget('Cancel', kcFE4E4E), onTap: cancel),
            MaterialButton(
                child: _buttonWidget('Proceed', kc3DED97), onPressed: proceed),
          ],
        )
      ]),
    );
  }

  Container _buttonWidget(String txt, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(
        txt,
        style: btnStyle,
      ));
}
