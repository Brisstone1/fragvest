import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class PropertyDateDetails2 extends StatelessWidget {
  final String fragPrice;
  final String roi;
  final String investors;
  final String estNetYield;
  final String initialCapital;
  final num percent;
  final String currentWorthOfInv;
  final String startDate;
  final String endDate;
  final String availableFrags;


  const PropertyDateDetails2(
      {Key key,
        @required this.fragPrice,
        @required this.roi,
        @required this.investors,
        @required this.estNetYield,
        @required this.initialCapital,
        @required this.percent,
        @required this.currentWorthOfInv,
        @required this.startDate,
        @required this.endDate,
      @required this.availableFrags})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    // final _portfolioData = serviceProvider.portfolioData;

    print('Net yield $estNetYield');
    return Padding(
      padding: const EdgeInsets.all(.5),
      child: Column(
        children: [
          // Card(
          // color: Colors.red,
          Container(
            // color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 10),
            // height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _column('Frag Price', '$fragPrice', true),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('EST. NET YIELD', style: stBFBFBF400Rubik10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '₦',
                                  style: TextStyle(fontFamily: ""),
                                ),
                                Text('$estNetYield',
                                    style: st0C0932600Rubik12),
                              ],
                            ),
                            SizedBox(width: 5),
                            Image.asset(
                              imgTriangle,
                              height: 10,
                            ),
                            SizedBox(width: 3),
                            Text('$percent%', style: st33A02C400Rubik9)
                          ],
                        )
                      ],
                    ),
                    // const SizedBox(height: 20),
                    // _column('INVESTORS', investors, false),
                  ],
                ),
                const Spacer(),
                // column 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ROI', style: stBFBFBF400Rubik10),
                    Text('$roi% per annum',
                        style: st0C0932600Rubik12),
                    const SizedBox(height: 20),
                    _column('Available Frag',availableFrags , false),
                    // const SizedBox(height: 20),
                    // _column('END DATE', endDate, false),
                  ],
                ),
                const Spacer(),
                // 3rd colum
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _column('Co-owners', investors, false),
                  ],
                ),
              ],
            ),
          ),
          // ),
          // SizedBox(height: 20),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Card(
          //         child: Container(
          //             alignment: Alignment.center,
          //             height: 80,
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 SizedBox(height: 10),
          //                 Text('INITIAL CAPITAL', style: stBFBFBF400Rubik10),
          //                 SizedBox(height: 6),
          //                 Expanded(
          //                   child: Text(
          //                     'N$initialCapital',
          //                     style: st0000000500Rubik14.copyWith(fontSize: 18),
          //                     textAlign: TextAlign.center,
          //                   ),
          //                 ),
          //                 // Row(
          //                 //   mainAxisAlignment: MainAxisAlignment.center,
          //                 //   children: [
          //                 //     Text(
          //                 //       '₦',
          //                 //       style: TextStyle(fontSize: 16),
          //                 //     ),
          //                 //     Expanded(
          //                 //       child: Text(
          //                 //         _portfolioData.report.initialCapital,
          //                 //         style: st0000000500Rubik14.copyWith(
          //                 //             fontSize: 18),
          //                 //         textAlign: TextAlign.center,
          //                 //       ),
          //                 //     ),
          //                 //   ],
          //                 // )
          //               ],
          //             )),
          //       ),
          //     ),
          //     SizedBox(width: 8),
          //     Expanded(
          //       child: Card(
          //         child: Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 20),
          //             height: 80,
          //             // width: MediaQuery.of(context).size.width * 0.36,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Text('CURRENT WORTH OF INVESTMENT',
          //                     style: stBFBFBF400Rubik10),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'N$currentWorthOfInv',
          //                       style:
          //                       st0C0932600Rubik12.copyWith(fontSize: 18),
          //                     ),
          //                     Row(
          //                       children: [
          //                         Image.asset(
          //                           imgTriangle,
          //                           height: 10,
          //                         ),
          //                         SizedBox(width: 3),
          //                         Text('$percent%', style: st33A02C400Rubik9),
          //                       ],
          //                     )
          //                   ],
          //                 )
          //               ],
          //             )),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _column(String title, String data, bool isFrag) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: stBFBFBF400Rubik10),
        Row(children: [
          if (isFrag)
            Text(
              "₦",
              style: TextStyle(fontFamily: ""),
            ),
          Text(data, style: st0C0932600Rubik12)
        ])
      ],
    );
  }
}
