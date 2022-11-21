import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/wallet_balance_model.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/wallet/top_up_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/show_custom_dialog.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';

import '../../provider/service_provider.dart';

class InvestPaymentScreen extends StatefulWidget {
  final String amount;
  final String fragPrice;
  final String tokenId;
  final int propertyId;
  InvestPaymentScreen(
      this.amount, this.fragPrice, this.tokenId, this.propertyId);

  @override
  State<InvestPaymentScreen> createState() => _InvestPaymentScreenState();
}

class _InvestPaymentScreenState extends State<InvestPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  double _newAmount = 0.0;
  String _displayedAmount = '0.0';
  double _frag = 0.0;
  double _estimatatedTotal = 0.0;
  // double _charge = 0.0;
  String formateValue;
  double _transaction = 0.0;

  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget _richText(double frag) {
      return RichText(
          text: TextSpan(
            text:
                'Your purchase was successful. You have purchased a total of ',
            children: [
              TextSpan(
                  text: '${frag.toStringAsFixed(0)}',
                  style: st535353400Rubik13.copyWith(
                      color: kc3DED97, fontWeight: FontWeight.w700)),
              TextSpan(
                  text: 'FRAG',
                  style: st535353400Rubik13.copyWith(
                      color: kc3DED97, fontWeight: FontWeight.w700)),
              TextSpan(text: ' Token of '),
              TextSpan(
                  text: widget.tokenId,
                  style: st535353400Rubik13.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              TextSpan(text: ' for'),
              TextSpan(
                text: ' N$_estimatatedTotal',
                style: st535353400Rubik13.copyWith(
                    color: kc3DED97, fontWeight: FontWeight.w700),
              ),
            ],
            style: st535353400Rubik13.copyWith(color: kc5E5E5E),
          ),
          textAlign: TextAlign.center);
    }

    Widget _insufficientFoundMessage() {
      return RichText(
          text: TextSpan(
            text: 'Your wallet balance is too low to execute this transaction ',
            children: [
              TextSpan(text: ' Token of '),
              TextSpan(
                  text: widget.tokenId,
                  style: st535353400Rubik13.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              TextSpan(text: ' for'),
              TextSpan(
                text: ' N$_estimatatedTotal',
                style: st535353400Rubik13.copyWith(
                    color: kc3DED97, fontWeight: FontWeight.w700),
              ),
            ],
            style: st535353400Rubik13.copyWith(color: kc5E5E5E),
          ),
          textAlign: TextAlign.center);
    }
//

    // String _token = context.watch<UserToken>().userToken;
    final feeModel = Provider.of<ServiceProvider>(context).feeModel.data.first;

    return Scaffold(
        backgroundColor: kc0C0932,
        appBar: paymentAppbar('Buy Frags'),
        body: FutureBuilder<Object>(
            future: GetServices.getWalletBalance(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: kc3DED97,
                        onPressed: () {
                          // setState((){});
                          GetServices.getWalletBalance(context);
                        },
                        child: Text(snapshot.error.toString()),
                      )
                    ],
                  ),
                );
              } else if (!snapshot.hasData) {
                return Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.94,
                    decoration: BoxDecoration(
                      color: kcWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(child: SpinKitFoldingCube(color: kc0C0932)));
              } else {
                WalletBalanceModel walletBalanceModel = snapshot.data;
                double formatWalletBalance = double.parse(
                    walletBalanceModel.data.walletBalance.replaceAll(',', ''));
                double formatAmount =
                    double.parse(widget.amount.replaceAll(',', ''));
               
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _borderTopContainer(
                            'Amount in NGN',
                            'Enter Amount',
                            Form(
                              key: _formKey,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter()
                                  ],
                                  style: st535353700Rubik14,
                                  decoration:
                                      borderTextInputDecoration.copyWith(
                                          filled: true,
                                          fillColor: kcWhite,
                                          border: InputBorder.none,
                                          prefixIcon: _nairaIcon()),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      flushbarWidget(
                                          context,
                                          'Please enter amount in naira ',
                                          false);
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        _displayedAmount = '$value.0';
                                        formateValue =
                                            value.replaceAll(',', '');
                                        _frag = double.parse(formateValue) /
                                            double.parse(
                                              widget.fragPrice
                                                  .replaceAll('p.f', '')
                                                ..replaceAll(' ', '')
                                                ..replaceAll(',', ''),
                                            );
                                        _newAmount = double.parse(formateValue);
                                        // _charge = (0.5 / 100.0) * _newAmount;
                                        double fee = (double.tryParse(
                                                    feeModel.transactionFee) /
                                                100) *
                                            double.parse(formateValue);

                                        if (fee >
                                            double.tryParse(
                                                feeModel.transactionFeeCap)) {
                                          _transaction = double.tryParse(
                                              feeModel.transactionFeeCap);
                                        } else {
                                          _transaction = (double.tryParse(
                                                      feeModel.transactionFee) /
                                                  100) *
                                              double.parse(formateValue);
                                        }

                                        _estimatatedTotal =
                                            double.parse(formateValue) +
                                                _transaction;
                                      });
                                    }
                                    if (value.isEmpty) {
                                      setState(() {
                                        _frag = 0.0;
                                        _displayedAmount = '0.0';
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          _borderTopContainer(
                            '',
                            'Amount in Frag',
                            Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: kcWhite,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text('${_frag.toStringAsFixed(2)}'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      // height: MediaQuery.of(context).size.height * 0.66,
                      decoration: BoxDecoration(
                        color: kcWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _totleText('AMOUNT PER FRAG'),
                              _numberText(
                                  '${widget.fragPrice.replaceAll('p.f', '')}')
                            ],
                          )
                              //  Row(
                              //   children: [
                              //     Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         _totleText('AMOUNT'),
                              //         _numberText('240,000')
                              //       ],
                              //     ),
                              //     Spacer(),
                              //     Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         _totleText('SERVICE FEE'),
                              //         _numberText('0.00')
                              //       ],
                              //     )
                              //   ],
                              // ),
                              ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('AMOUNT'),
                                _numberText(_displayedAmount)
                              ],
                            ),
                          ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('Transaction Fee'),
                                _numberText(
                                    '${_transaction.toStringAsFixed(2)}')
                              ],
                            ),
                          ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('Estimated Total'),
                                _numberText(
                                    '${_estimatatedTotal.toStringAsFixed(2)}')
                              ],
                            ),
                          ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('Wallet Balance'),
                                _numberText(
                                    walletBalanceModel.data.walletBalance)
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: customButton('Proceed to payment', () {
                              if (_formKey.currentState.validate()) {
                                _processInvest(
                                    _estimatatedTotal,
                                    formatWalletBalance,
                                    _richText(_frag),
                                    _insufficientFoundMessage());
                              }
                            }),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }

  Widget _container({Widget child}) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: kc535353))),
        child: child);
  }

  Widget _borderTopContainer(String title, String instruction, Widget widget) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration:
            BoxDecoration(border: Border(top: BorderSide(color: kcWhite))),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: stFFFFFF400Rubik13),
              Text(instruction, style: stFFFFFF700Rubik18)
            ],
          ),
          Spacer(),
          widget
        ]));
  }

  Text _totleText(String text) {
    return Text(text, style: st535353400Rubik13);
  }

  Widget _numberText(String text) {
    return Row(
      children: [
        Image.asset(imgNaira, color: Colors.black),
        SizedBox(width: 2),
        Text(text, style: stBlack700Rubik18),
      ],
    );
  }

  Widget _nairaIcon() {
    return Container(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      width: 40,
      decoration:
          BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
      child: Image.asset(imgNaira, color: Colors.black),
    );
  }

  _processInvest(double estimatedTotal, double balance, RichText richText,
      funMessage) async {
    if (balance > estimatedTotal) {
      EasyLoading.show(status: 'Processing...');
      var response = await PostServices.investProperty(
          context, widget.propertyId, '$formateValue');

      if (response is LogSucess) {
        EasyLoading.dismiss();
        showCustomDialog(
            isDismissed: false,
            context: context,
            image: imgCheckedCircle,
            title: 'Transaction Successful',
            buttonText: 'Close',
            massage: richText,
            callback: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            clearCalback: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
      } else {
        EasyLoading.dismiss();

        flushbarWidget(context, (response as LogFailure).errorMessage, false);
      }
    } else {
      showCustomDialog(
          context: context,
          image: imgError,
          title: 'Transaction error',
          buttonText: 'Fund Wallet',
          massage: funMessage,
          callback: () {
            Navigator.of(context).pushReplacementNamed(TopUpScreen.routeName);
          },
          clearCalback: () {
            Navigator.of(context).pop();
          });
    }
  }
}
