import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/security_pin_widget.dart';

class RenewRentScreen extends StatefulWidget {
  static const routeName = 'renew-rent';
  const RenewRentScreen({Key key}) : super(key: key);

  @override
  State<RenewRentScreen> createState() => _RenewRentScreenState();
}

class _RenewRentScreenState extends State<RenewRentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Renew Rent'),
      body: BaseViewBuilder<PortfolioVm>(
          model: getIt(),
          initState: (init) {
            init.renewDuration = [];
          },
          builder: (pVm, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                SizedBox(height: 20),
                Container(
                    child: Text(
                        'Enter Rent year(s):  ${pVm.renewDuration.join()}')),
                SizedBox(height: 40),
                Container(
                  width: 320,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _keyboardKeys(
                              text: '1',
                              callback: () {
                                pVm.getRenewDuration('1');
                              }),
                          _keyboardKeys(
                              text: '2',
                              callback: () {
                                pVm.getRenewDuration('2');
                              }),
                          _keyboardKeys(
                              text: '3',
                              callback: () {
                                pVm.getRenewDuration('3');
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _keyboardKeys(
                              text: '4',
                              callback: () {
                                pVm.getRenewDuration('4');
                              }),
                          _keyboardKeys(
                              text: '5',
                              callback: () {
                                pVm.getRenewDuration('5');
                              }),
                          _keyboardKeys(
                              text: '6',
                              callback: () {
                                pVm.getRenewDuration('6');
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _keyboardKeys(
                              text: '7',
                              callback: () {
                                pVm.getRenewDuration('7');
                              }),
                          _keyboardKeys(
                              text: '8',
                              callback: () {
                                pVm.getRenewDuration('8');
                              }),
                          _keyboardKeys(
                              text: '9',
                              callback: () {
                                pVm.getRenewDuration('9');
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 90,
                          ),
                          _keyboardKeys(
                              text: '0',
                              callback: () {
                                if (pVm.renewDuration.isNotEmpty) {
                                  pVm.getRenewDuration('0');
                                }
                              }),
                          _clearbutton(() {
                            pVm.clearDurationButton();
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                customButton('Rewnew Rent', () async {
                  if (pVm.renewDuration.isNotEmpty &&
                      int.tryParse(pVm.renewDuration.join()) > 0) {
                    await getIt.get<PortfolioVm>().setPortfolioMap(
                        id: pVm.sellPropertyMap.portfolioId,
                        renewDuration: pVm.renewDuration.join());

                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) {
                    //       return SecurityPinWidget(operationType: 'renewRent');
                    //     });

                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: EdgeInsets.symmetric(horizontal: 16),
                              child: SecurityPinWidget(
                                operationType: 'renewRent',
                              ),
                            );
                          });

                  } else {
                    flushbarWidget(context,
                        'Invalid duration, please enter valid year(s)', false);
                  }
                })
              ]),
            );
          }),
    );
  }

  Widget _keyboardKeys({String text, VoidCallback callback}) {
    return MaterialButton(
      // onPressed: (pressedValu != null && availableFrad != null) &&
      //         pressedValu < availableFrad
      //     ? callback
      //     : null,
      onPressed: callback,
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
}
