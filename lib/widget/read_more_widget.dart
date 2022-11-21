import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:readmore/readmore.dart';

class ReadMoreWidget extends StatelessWidget {
  final bool isBlack;
  final String describption;
  const ReadMoreWidget(this.isBlack, {Key key, this.describption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      describption,
      trimLines: 2,
      style: st535353400Rubik12,
      colorClickableText: kc2F54C6,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'More',
      trimExpandedText: 'Less',
      moreStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isBlack ? Color(0xFF000000) : kc2F54C6,
          decoration: TextDecoration.underline),
    );
  }
}
