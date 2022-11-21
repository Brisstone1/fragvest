import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/security_pin_widget.dart';
import 'package:provider/provider.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';

class SellAssetsScreen extends StatefulWidget {
  static const routeName = 'sell-property';
  const SellAssetsScreen({Key key}) : super(key: key);

  @override
  State<SellAssetsScreen> createState() => _SellAssetsScreenState();
}

class _SellAssetsScreenState extends State<SellAssetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context: context, title: 'Sell Assets'),
      body: BaseViewBuilder<PortfolioVm>(
          model: getIt(),
          initState: (init) {
            init.clearbutton();
          },
          builder: (pVm, child) {
            print(pVm.sellPropertyMap.investedFrag);
            double availaibleFrag = double.tryParse(
                pVm.sellPropertyMap.investedFrag.replaceAll(',', ''));
            double pressedValue = 0.0;
            if (pVm.isPercent) {
              pressedValue = pVm.fragPercentValue;
            } else {
              if (pVm.pressedNumber.isNotEmpty) {
                pressedValue = pVm.fragPercent.toDouble();
              }
            }
            
            print(pVm);
            print('OKOLI JOOOOOOOOOOO');

            // pVm.pressedNumber.isNotEmpty ? pVm.fragPercent : 0;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                Image.asset(homeIndicator),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sell Assets",
                    style: st07C168600Rubik24.copyWith(color: kc0C0932),
                  ),
                ),
                const SizedBox(height: 18),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       '₦',
                //       style: st000000600Rubik16,
                //     ),
                //     Text(
                //       pVm.assetPrice.toStringAsFixed(2),
                //       style: st000000500Roboto.copyWith(fontSize: 32),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       '$pressedValue',
                //       style: st000000500Roboto,
                //     ),
                //     Text(
                //       ' frag',
                //       style: st000000500Roboto.copyWith(color: kcBBBBBB),
                //     ),
                //   ],
                // ),
                SizedBox(
                  // width: 280,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          percentButton(
                              percent: ' 25',
                              selectedindex: 1,
                              perecentIndex: pVm.percentIndex,
                              callback: () => pVm.setFragPercent(25, 1)),
                          percentButton(
                              percent: ' 50',
                              selectedindex: 2,
                              perecentIndex: pVm.percentIndex,
                              callback: () => pVm.setFragPercent(50, 2)),
                          percentButton(
                              percent: ' 75',
                              selectedindex: 3,
                              perecentIndex: pVm.percentIndex,
                              callback: () => pVm.setFragPercent(75, 3)),
                          percentButton(
                              percent: '100',
                              selectedindex: 4,
                              perecentIndex: pVm.percentIndex,
                              callback: () => pVm.setFragPercent(100, 4)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Enter Frag Amount',
                            style: st0C0932500Rubik14),
                      ),

                      SizedBox(height: 8),
                      SizedBox(
                        height: 44,
                        child: TextFormField(
                          onChanged: (text) {
                            pVm.assetCalculator(context, text);
                            print('First text field: $text');
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          // controller: _emailController,
                          // decoration: borderTextInputDecoration,
                          decoration: InputDecoration(
                            hintText: "Enter Frag Amount",
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: kc0C0932,
                                fontWeight: FontWeight.w500),
                            filled: true, //<-- SEE HERE
                            fillColor: Color(0xFFF5F5F8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 5, color: Color(0xFFF5F5F8)),
                              borderRadius: BorderRadius.circular(5.0),
                              //<-- SEE HERE
                            ),
                          ),
                          validator: (String val) {
                            if (val.trim().isEmpty) {
                              return 'Email required';
                            } else if (!val.trim().contains('@') ||
                                !val.trim().contains('.com')) {
                              return 'Inavlid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // Divider(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available Frag',
                                style: stABABAB500Roboto10,
                              ),
                              Text(
                                pVm.sellPropertyMap.investedFrag,
                                style: st000000400Roboto12.copyWith(
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Price per Frag',
                                style: stABABAB500Roboto10,
                              ),
                              Text(
                                '₦${pVm.sellPropertyMap.pricePerFrag.replaceAll(' p.f', '')}',
                                style: TextStyle(fontFamily: ""),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 20),
                // SizedBox(
                //   height: 40,
                // ),
                // Container(
                //   width: 320,
                //   height: 300,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           _keyboardKeys(
                //               text: '1',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '1');
                //               }),
                //           _keyboardKeys(
                //               text: '2',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '2');
                //               }),
                //           _keyboardKeys(
                //               text: '3',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '3');
                //               })
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           _keyboardKeys(
                //               text: '4',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '4');
                //               }),
                //           _keyboardKeys(
                //               text: '5',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '5');
                //               }),
                //           _keyboardKeys(
                //               text: '6',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '6');
                //               })
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           _keyboardKeys(
                //               text: '7',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '7');
                //               }),
                //           _keyboardKeys(
                //               text: '8',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '8');
                //               }),
                //           _keyboardKeys(
                //               text: '9',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 pVm.assetCalculator(context, '9');
                //               })
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           SizedBox(
                //             width: 90,
                //           ),
                //           _keyboardKeys(
                //               text: '0',
                //               investedFrag: availaibleFrag,
                //               pressedValu: pressedValue,
                //               callback: () {
                //                 if (pVm.pressedNumber.isNotEmpty) {
                //                   pVm.assetCalculator(context, '0');
                //                 }
                //               }),
                //           _clearbutton(() {
                //             pVm.clearbutton();
                //           }),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 27,
                ),
                customButton('Sell Frags',
                        () async {
                  await pVm.setPortfolioMap(
                      id: pVm.sellPropertyMap.portfolioId,
                      pricePerFrag: pVm.sellPropertyMap.pricePerFrag,
                      investedFrag: pVm.sellPropertyMap.investedFrag,
                      assetPrice: pVm.assetPrice.toStringAsFixed(2),
                      pressedValue: '$pressedValue');
                  showTransactionDetail(context);
                },
                    width: MediaQuery.of(context).size.width)
              ]),
            );
          }),
    );
  }

  Widget _keyboardKeys(
      {String text,
      double pressedValu,
      double investedFrag,
      VoidCallback callback}) {
    return MaterialButton(
      onPressed: (pressedValu != null && investedFrag != null) &&
              pressedValu < investedFrag
          ? callback
          : null,
      // onPressed: callback,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kcC4C4C4.withOpacity(0.5))),
        child: Text(text, style: st000000400Roboto36),
      ),
    );
  }

  Widget _clearbutton(VoidCallback callback) {
    return MaterialButton(
      onPressed: callback,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kcC4C4C4.withOpacity(0.5))),
          child: Icon(Icons.backspace_outlined)),
    );
  }

  Widget percentButton(
      {String percent,
      VoidCallback callback,
      int perecentIndex = 0,
      int selectedindex}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          width: 69,
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: perecentIndex == selectedindex
                  ? kc407BFF
                  : kc407BFF.withOpacity(0.22),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kc407BFF)),
          child: Text(
            '$percent%',
            style: st000000500Roboto14.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: perecentIndex == selectedindex ? kcWhite : kc407BFF),
          )),
    );
  }
}

class TransactionDetailAlert extends StatelessWidget {
  const TransactionDetailAlert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context, listen: false)
        .feeModel
        .data
        .first;
    final pVm = getIt.get<PortfolioVm>();
    double transactionFee = 0.0;


    print('ALANBIIIIIIIIII');
    print(pVm.assetPrice);
    print('ALANBIIIIIIIIII');
    print(pVm.sellPropertyMap);

    double txnFee = (double.tryParse(serviceProvider.transactionFee) / 100) *
        double.tryParse(pVm.sellPropertyMap.assetPrice);
    if (txnFee > double.tryParse(serviceProvider.transactionFeeCap)) {
      transactionFee = double.tryParse(serviceProvider.transactionFeeCap);
    } else {
      transactionFee = txnFee;
    }

    double totalFee =
        double.tryParse(pVm.sellPropertyMap.assetPrice) - transactionFee;

    return Container(
      height: 330,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 15,
                  )),
              Text('Transaction Details'),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: kcEE1A1A),
                ),
              ),
            ],
          ),
          _row('Selling', '${pVm.sellPropertyMap.pressedValue} frag'),
          _row('Price', '₦${pVm.assetPrice}'),
          _row('Transaction fee', '₦${transactionFee.toStringAsFixed(2)}'),
          _row('Amount you Will receive', '₦${totalFee.toStringAsFixed(2)}'),
          const SizedBox(height: 50),
          customButton('Sell', () {
            // final pVm = getIt.get<PortfolioVm>();
            final investedFrag =
                pVm.sellPropertyMap.investedFrag.replaceAll(',', '');
            if (double.tryParse(investedFrag) >=
                    double.tryParse(pVm.sellPropertyMap.pressedValue) &&
                pVm.assetPrice > 0.0) {
              _showPinMoedal(context);
            } else {
              flushbarWidget(
                  context,
                  'You can only sell minimum of 1 frag and maximum of ${pVm.sellPropertyMap.investedFrag} frag',
                  false);
            }
          }),
        ],
      ),
    );
  }
}

_showPinMoedal(BuildContext context) {
  // showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SecurityPinWidget(operationType: 'sellAsset');
  //     });
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          child: SecurityPinWidget(
            operationType: 'sellAsset',
          ),
        );
      });
}

Widget _row(String title, String content) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Row(
      children: [
        Text(
          title,
          style: st535353500Rubik14.copyWith(color: kcB5B5B5),
        ),
        const Spacer(),
        Text(content, style: st535353500Rubik14.copyWith(
          color: kc0C0932,
          fontFamily: ""
        )),
      ],
    ),
  );
}

showTransactionDetail(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(30),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TransactionDetailAlert(),
          ),
        );
      });
}
