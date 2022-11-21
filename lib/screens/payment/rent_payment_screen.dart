import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/wallet_balance_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/wallet/top_up_screen.dart';
import 'package:fragvest_mobile/utilities/add_comma_to_number.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/show_custom_dialog.dart';
import 'package:provider/provider.dart';
import 'payment_option_screen.dart';

class RentingPaymentScreen extends StatefulWidget {
  final String amount;
  final int propertyId;
  final String tokenId;
  final String fragPrice;

  RentingPaymentScreen(
      this.amount, this.propertyId, this.tokenId, this.fragPrice);

  @override
  _RentingPaymentScreenState createState() => _RentingPaymentScreenState();
}

class _RentingPaymentScreenState extends State<RentingPaymentScreen> {
  String _duration;

  double _newAmount = 0.0;
  double _estAmount = 0.0;
  double _brokerCharge = 0.0;
  double _transaction = 0.0;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _token = context.watch<UserToken>().userToken;
    final feeModel = Provider.of<ServiceProvider>(context).feeModel.data.first;

// Your purchase was successful.
// You have purchased a 1yr rent of NML01 for a total of ₦320,000.00.

    Widget _richText() {
      return RichText(
          text: TextSpan(
            text: 'Your purchase was successful. You have purchased a ',
            children: [
              TextSpan(
                  text: '${_duration}yr',
                  style: st535353400Rubik13.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              TextSpan(text: ' rent of '),
              TextSpan(
                  text: widget.tokenId,
                  style: st535353400Rubik13.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              TextSpan(text: ' for a total of'),
              TextSpan(
                text: ' N$_estAmount',
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
            text:
                'Your wallet balance is too low to execute this transaction with token ',
            children: [
              TextSpan(
                  text: widget.tokenId,
                  style: st535353400Rubik13.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              TextSpan(text: ' for'),
              TextSpan(
                text: ' N$_estAmount',
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
        appBar: paymentAppbar('Renting'),
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
                double formatAmount = double.parse(widget.amount
                    .replaceAll(',', '')
                    .replaceAll('p.a', '')
                    .replaceAll(' ', ''));
                // _transaction = (0.5 / 100) * formatAmount;

                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _borderTopContainer(
                              'Amount P.A',
                              'Rent',
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 14, top: 10, bottom: 10),
                                decoration: BoxDecoration(color: kcWhite),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _nairaIcon(),
                                    Text('$formatAmount',
                                        style: st535353400Rubik18),
                                  ],
                                ),
                              )
                              // Container(
                              //   width: MediaQuery.of(context).size.width * 0.,
                              //   child: TextField(
                              //     enabled: false,
                              //     keyboardType: TextInputType.number,
                              // style: st535353700Rubik14,
                              //     decoration: borderTextInputDecoration.copyWith(
                              //         labelText: widget.amount,
                              //         filled: true,
                              //         fillColor: kcWhite,
                              //         border: InputBorder.none,
                              //         prefixIcon: _nairaIcon()),
                              //   ),
                              // ),
                              ),
                          _borderTopContainer(
                            'Duration',
                            'Select Duration',
                            Form(
                              key: _formKey,
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: kcWhite,
                                    borderRadius: BorderRadius.circular(5)),
                                child: DropdownButtonFormField<String>(
                                    // value: _duration,
                                    iconSize: 24,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    hint: Text(
                                      'Duration',
                                      style: textfieldStyle,
                                    ),
                                    style: st535353400Rubik18,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 10)),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _duration = newValue;
                                        _newAmount = double.parse(newValue) *
                                            formatAmount;
                                        double txnFee = (double.tryParse(
                                                    feeModel.transactionFee) /
                                                100) *
                                            _newAmount;

                                        double brkCha = (double.tryParse(
                                                    feeModel.brokerCharge) /
                                                100) *
                                            _newAmount;
                                        if (txnFee >
                                            double.tryParse(
                                                feeModel.transactionFeeCap)) {
                                          _transaction = double.tryParse(
                                              feeModel.transactionFeeCap);
                                        } else {
                                          _transaction = txnFee;
                                        }

                                        if (brkCha >
                                            double.tryParse(
                                                feeModel.transactionFeeCap)) {
                                          _brokerCharge = double.tryParse(
                                              feeModel.transactionFeeCap);
                                        } else {
                                          _brokerCharge = brkCha;
                                        }
                                        _estAmount = _newAmount +
                                            _brokerCharge +
                                            _transaction;
                                      });
                                    },
                                    items: <String>[
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text('${value}yr',
                                            style: st535353700Rubik14),
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        flushbarWidget(context,
                                            'Please select duration', false);
                                        return 'Required';
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
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
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _totleText('AMOUNT'),
                                    _numberText(
                                        '${addCommaToString.format(_newAmount)}')
                                  ],
                                ),
                                Spacer(),
                                Container()
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     _totleText('SERVICE FEE'),
                                //     _numberText('0.00')
                                //   ],
                                // )
                              ],
                            ),
                          ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('Broker charge 10% '),
                                _numberText(
                                    '${addCommaToString.format(_brokerCharge)}')
                              ],
                            ),
                          ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('Transaction Fee '),
                                _numberText(
                                    '${addCommaToString.format(_transaction)}')
                              ],
                            ),
                          ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('Estimated Total'),
                                _numberText(
                                    '${addCommaToString.format(_estAmount)}')
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
                            child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(PaymentOptionScreen.routeName),
                              child: customButton('Proceed to Payment', () {
                                if (_formKey.currentState.validate()) {
                                  _processRent(formatWalletBalance, _estAmount,
                                      _richText(), _insufficientFoundMessage());
                                }
                              }),
                            ),
                          )
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

  _processRent(double balance, double estAmount, RichText richText,
      RichText richText2) async {
    if (balance > estAmount) {
      EasyLoading.show(status: 'Processing...');
      var response = await PostServices.rentProperty(
          context, widget.propertyId, _duration);

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
          });
    }
  }
}
