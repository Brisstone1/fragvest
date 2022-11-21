import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';

import '../../provider/service_provider.dart';
import '../../utilities/add_comma_to_number.dart';
import 'payment_option_screen.dart';

class SalePaymentScreen extends StatefulWidget {
  final String amount;
  final int propertyId;
  final String tokenId;
  final String fragPrice;
  SalePaymentScreen(this.amount, this.propertyId, this.tokenId, this.fragPrice);

  @override
  State<SalePaymentScreen> createState() => _SalePaymentScreenState();
}

class _SalePaymentScreenState extends State<SalePaymentScreen> {
  double _brokerCharge = 0.0;
  double _estAmount = 0.0;
  double _transaction = 0.0;
  _computerData() {
    final feeModel = Provider.of<ServiceProvider>(context, listen: false)
        .feeModel
        .data
        .first;

    final filterAmount = widget.amount.replaceAll(',', '');
    double bCharge = (double.tryParse(feeModel.brokerCharge) / 100) *
        double.parse(filterAmount);
    if (bCharge > double.tryParse(feeModel.transactionFeeCap)) {
      _brokerCharge = double.tryParse(feeModel.transactionFeeCap);
    } else {
      _brokerCharge = bCharge;
    }

    double txnFee = (double.tryParse(feeModel.transactionFee) / 100) *
        double.parse(filterAmount);

    if (txnFee > double.tryParse(feeModel.transactionFeeCap)) {
      _transaction = double.tryParse(feeModel.transactionFeeCap);
    } else {
      _transaction = txnFee;
    }

    _estAmount = _brokerCharge + double.parse(filterAmount) + _transaction;
  }

  @override
  void initState() {
    _computerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String _token = context.watch<UserToken>().userToken;

    Widget _richText() {
      return RichText(
          text: TextSpan(
            text: 'Your payment for the purchase ',
            children: [
              TextSpan(
                  text: widget.tokenId,
                  style: st535353400Rubik13.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              TextSpan(text: ' for'),
              TextSpan(
                text: ' N${_estAmount.toStringAsFixed(2)}',
                style: st535353400Rubik13.copyWith(
                    color: kc3DED97, fontWeight: FontWeight.w700),
              ),
              TextSpan(text: '  was successful')
            ],
            style: st535353400Rubik13.copyWith(color: kc5E5E5E),
          ),
          textAlign: TextAlign.center);
    }

    Widget _insufficientFoundMessage() {
      return RichText(
          text: TextSpan(
            text:
                'Your wallet balance is too low to execute this transaction of purchase of ',
            children: [
              TextSpan(
                  text: widget.tokenId,
                  style: st535353400Rubik13.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              TextSpan(text: ' for'),
              TextSpan(
                text: ' N${_estAmount.toStringAsFixed(2)}',
                style: st535353400Rubik13.copyWith(
                    color: kc3DED97, fontWeight: FontWeight.w700),
              ),
            ],
            style: st535353400Rubik13.copyWith(color: kc5E5E5E),
          ),
          textAlign: TextAlign.center);
    }

    return Scaffold(
      backgroundColor: kc0C0932,
      appBar: paymentAppbar('Buying'),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          FutureBuilder<Object>(
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
                      child:
                          Center(child: SpinKitFoldingCube(color: kc0C0932)));
                } else {
                  WalletBalanceModel walletBalanceModel = snapshot.data;
                  double formatWalletBalance = double.parse(walletBalanceModel
                      .data.walletBalance
                      .replaceAll(',', ''));
                  double formatAmount =
                      double.parse(widget.amount.replaceAll(',', ''));

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _totleText('AMOUNT'),
                              _numberText('${widget.amount}')
                            ],
                          ),

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
                              _totleText('Broker Charge'),
                              _numberText(
                                  addCommaToString.format(_brokerCharge))
                            ],
                          ),
                        ),
                        _container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _totleText('Transaction Fee'),
                              _numberText(addCommaToString.format(_transaction))
                            ],
                          ),
                        ),
                        _container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _totleText('Estimated Total'),
                              _numberText(addCommaToString.format(_estAmount))
                            ],
                          ),
                        ),
                        _container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _totleText('Wallet Balance'),
                              _numberText(walletBalanceModel.data.walletBalance)
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(PaymentOptionScreen.routeName),
                              child: customButton('Proceed to payment', () {
                                _processBuy(formatWalletBalance, formatAmount,
                                    _richText(), _insufficientFoundMessage());
                              })),
                        )
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }

  Widget _container({Widget child}) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: kc535353))),
        child: child);
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

  _processBuy(double formWallet, double amount, RichText richText,
      RichText richText2) async {
    if (formWallet > amount) {
      EasyLoading.show(status: 'Processing...');
      var response = await PostServices.buyProperty(context, widget.propertyId);

      if (response is LogSucess) {
        EasyLoading.dismiss();
        showCustomDialog(
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
        massage: richText2,
        callback: () {
          Navigator.of(context).pushReplacementNamed(TopUpScreen.routeName);
        },
        clearCalback: () {
          Navigator.of(context).pop();
        },
      );
    }
  }
}
