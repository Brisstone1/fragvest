import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class PropertyDateDetails extends StatelessWidget {
  final String startDate;
  final String daysLeft;
  final String endDate;
  final String duration;

  PropertyDateDetails(
      this.startDate, this.daysLeft, this.endDate, this.duration);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Container(
        // height: 140,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              _innerLayout('RENT DATE', startDate, 'DURATION',
                  duration.toUpperCase(), kc407BFF)
            ],
          ),
          Column(
            children: [_innerLayout('EPX DATE', endDate, '', '', kc407BFF)],
          ),
          Column(
            children: [
              _innerLayout('DAYS LEFT', '$daysLeft DAYS', '', '', Colors.black)
            ],
          ),
        ]
                // [
                //   _innerLayout('RENT DATE', startDate, 'DAYS LEFT',
                //       '$daysLeft DAYS', Colors.black),
                //   _innerLayout('EPX DATE', endDate, 'DURATION',
                //       duration.toUpperCase(), kc407BFF)
                // ],
                ),
      ),
    );
  }

  Widget _innerLayout(
      String title1, String data1, String title2, String data2, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1, style: st96959500Rubik12),
            Text(data1,
                style: st96959500Rubik12.copyWith(
                    color: Color(0xFF0C0932), fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title2, style: st96959500Rubik12),
            Text(data2,
                style: st96959500Rubik12.copyWith(
                    color: Color(0xFF0C0932), fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
