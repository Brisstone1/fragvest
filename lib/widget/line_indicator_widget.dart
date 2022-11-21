import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:speech_bubble/speech_bubble.dart';

class LineIndicatorWidget extends StatelessWidget {
  // final port.Report report;
  final String sartDate;
  final String currentDate;
  final String currentWorthOfInv;
  final String endDate;
  final double currentNetYieldPercentage;

  const LineIndicatorWidget(this.sartDate, this.currentDate,
      this.currentWorthOfInv, this.endDate, this.currentNetYieldPercentage);

  @override
  Widget build(BuildContext context) {
    double percent = currentNetYieldPercentage.toString() == 'null'
        ? 0
        : currentNetYieldPercentage <= 94
            ? currentNetYieldPercentage
            : 94;
    double bubblePercent = currentNetYieldPercentage.toString() == 'null'
        ? 0
        : currentNetYieldPercentage >= 94
            ? 94
            : currentNetYieldPercentage <= 26
                ? 26
                : currentNetYieldPercentage;
    return Column(
      children: [
        SizedBox(height: 90),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: kcECECEC),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * (percent / 100),
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: kc4CAF50,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: -35,
              child: Container(
                height: 30,
                child: Text(
                  sartDate,
                  style: st535353400Rubik8,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: -75,
              child: Container(
                alignment: Alignment.topRight,
                width:
                    MediaQuery.of(context).size.width * (bubblePercent / 100),
                child: SpeechBubble(
                  color: kcWhite,
                  nipLocation: NipLocation.BOTTOM,
                  width: 110,
                  child: Container(
                    // height: 40,
                    // width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentDate,
                          style: st535353400Rubik10,
                        ),
                        Wrap(
                          spacing: 2,
                          children: [
                            Row(
                              children: [
                                Text('₦', style: TextStyle(
                                    fontFamily: ""
                                ),),
                                Text(
                                  currentWorthOfInv,
                                  style: stNormal13.copyWith(fontSize: 10),
                                ),
                              ],
                            ),
                            Image.asset(
                              imgTriangle,
                              height: 10,
                            ),
                            Text('$currentNetYieldPercentage%')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: -2,
              child: Container(
                alignment: Alignment.topRight,
                width: MediaQuery.of(context).size.width * (percent / 100) + 2,
                child: CircleAvatar(
                  backgroundColor: kc4CAF50,
                  radius: 4,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: -35,
              child: Container(
                height: 30,
                child: Text(
                  endDate,
                  style: st535353400Rubik8,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
