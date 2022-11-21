import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/future_error_message_widget.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';

import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';

import '../../model/user_bank_account_model.dart';
import '../../widget/security_pin_widget.dart';
import '../../widget/security_pin_alert.dart';
import 'add_new_account.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WithdrawalScreen extends StatefulWidget {
  static const routeName = '/withdrawal-screen';

  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String _selectedValue;

  final _amountController = TextEditingController();
  int _currentIndex;
  int _bankId;
  String _accountNumber;
  String _accountName;

  String token;

  @override
  void initState() {
    token = Provider.of<UserToken>(context, listen: false).userToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Withdraw Request', true),
      body: FutureBuilder(
          future: GetServices.getUserAccountBank(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return futureErrorMessage(() {}, snapshot.error.toString());
            } else if (!snapshot.hasData) {
              return initialLoader(MediaQuery.of(context).size.height);
            } else {
              UserBankAccountModel userBankAccountModel = snapshot.data;
              final _banks = userBankAccountModel.data;
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Amount",
                          style: TextStyle(
                              color: Color(0xFF969595),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      TextFormField(
                        controller: _amountController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          ThousandsFormatter(allowFraction: true)
                        ],
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'Amount'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Amount is required';
                          }
                          return null;
                        },
                      ),
                      // const SizedBox(height: 30),
                      // Text('Select prefered account details',
                      //     style: st535353700Rubik12),
                      const SizedBox(height: 25),
                      _banks.length == 0
                          ? Center(
                              child: GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushReplacementNamed(
                                        AddNewAccountScreen.routeName),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No account yet.'),
                                    Text(
                                      ' click ',
                                      style: TextStyle(color: kc3DED97),
                                    ),
                                    Text('here to add account')
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 80 * _banks.length.toDouble() + 2,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _banks.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _currentIndex = i;
                                          _bankId = _banks[i].id;
                                          _accountNumber =
                                              _banks[i].accountNumber;
                                          _accountName = _banks[i].bank.name;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(_currentIndex == i
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(_banks[i].bank.name,
                                                  style: st535353500Rubik12
                                                      .copyWith(
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                              Text(_banks[i].accountName,
                                                  style: st535353500Rubik12
                                                      .copyWith(
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                              Text(_banks[i].accountNumber,
                                                  style: st535353500Rubik12
                                                      .copyWith(
                                                    fontWeight: FontWeight.w300,
                                                  ))
                                            ],
                                          ),
                                          // Spacer(),
                                          // Transform.translate(
                                          //     offset: Offset(0, -8),
                                          //     child: Text(
                                          //         _banks[i].accountNumber,
                                          //         style: st535353500Rubik12
                                          //             .copyWith(
                                          //           fontWeight: FontWeight.w300,
                                          //         ))
                                          // ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                      SizedBox(height: 60),
                      _isLoading
                          ? spinKitLoaderWidget()
                          : customButton('Proceed', () {
                              _waithdrawal(_banks.length);
                            }),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  _waithdrawal(int length) async {
    if (_formKey.currentState.validate()) {
      if (_bankId == null) {
        flushbarWidget(context, 'Please select account', false);
      } else {
        if (length == 0) {
          showAccoutRedirection();
        } else {
          showProceedPayment();
        }
      }

      // setState(() => _isLoading = true);

    }
  }

  // showDialog(
  // barrierDismissible: isDismissed ?? true,
  // context: context,
  // builder: (BuildContext context) {
  // return Dialog(
  // shape:
  // RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  // child:

  _showPinMoedal() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            child: SecurityPinWidget(
                operationType: 'withdraw',
                amount: _amountController.text.replaceAll(',', ''),
                id: _bankId),
          );
        });
  }

  showAccoutRedirection() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SecurityPinAlert(
                title: 'Error!',
                message:
                    'There is No bank details attached to this account. Proceed to add a valid bank details.',
                cancel: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                proceed: () => Navigator.of(context)
                    .pushReplacementNamed(AddNewAccountScreen.routeName)),
          );
        });
  }

  showProceedPayment() {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Dialog(
    //         child: SecurityPinAlert(
    //             title: 'Confirm Withdrawal',
    //             message:
    //                 "You are about to withdraw N${_amountController.text}  into $_accountName account number $_accountNumber. Click “Proceed” to confirm your request.",
    //             cancel: () {
    //               Navigator.pop(context);
    //             },
    //             proceed: () {
    //               Navigator.pop(context);
    //               _showPinMoedal();
    //             }),
    //       );
    //     });
    return showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          // return SortByStatus();
          return Container(
            // color: Colors.blue,
            // alignment: Alignment.bottomCenter,
            // margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
            height: 280,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirm Withdrawal',
                    style: TextStyle(
                        color: Color(0xFF0C0932),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24, bottom: 40),
                  alignment: Alignment.center,
                  // color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'You are about to withdraw ₦${_amountController.text}  into $_accountName account number $_accountNumber. Click “Proceed” to confirm your request.',
                    style: TextStyle(
                      color: Color(0xFF535353),
                      fontSize: 14,
                      fontFamily: "",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // Text('', style: TextStyle(
                //   color: Color(0xFF535353),
                //   fontSize: 14,
                //   fontWeight: FontWeight.w400,
                //
                //
                // )
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: MaterialButton(
                    color: Color(0xFF07C168),
                    onPressed: () {
                      Navigator.pop(context);
                      _showPinMoedal();
                    },
                    child: Text(
                      'Withdraw',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
