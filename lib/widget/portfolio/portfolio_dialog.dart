import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/screens/portfolio/sell_property.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';

class PorfolioDialog extends StatelessWidget {
  final String title;
  final String content;
  final String operationType;
  final Color operactionColor;
  final VoidCallback operationCallback;
  const PorfolioDialog(
      {Key key,
      @required this.title,
      @required this.content,
      @required this.operationType,
      @required this.operationCallback,
      this.operactionColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.17,
        // width: 100,
        child: Column(
          children: [
            Text(
              title,
              style: st0000000500Rubik14.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Text(content,
                textAlign: TextAlign.center,
                style: st4CAF50400Roboto11.copyWith(color: kc535353)),
            // const SizedBox(height: 26),
            const Spacer(),
            Row(
              children: [
                customButton('Cancel', () => Navigator.pop(context),
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: kcFE4E4E),
                const Spacer(),
                customButton(operationType, operationCallback,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: operactionColor),
              ],
            )
          ],
        ),
      ),
    );
  }
}
