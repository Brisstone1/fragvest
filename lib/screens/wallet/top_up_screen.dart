import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/viewModel/wallet_mv.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';
import '../../provider/service_provider.dart';

class TopUpScreen extends StatefulWidget {
  static const routeName = '/top-up-screen';

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  ServiceProvider serviceProvider;
  @override
  void initState() {
    getTransactionFee();
    super.initState();
  }

  getTransactionFee() {
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Add Money to Balance', true),
      body: BaseViewBuilder<WalletMv>(
          model: getIt(),
          builder: (wVm, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 70),
                  SizedBox(
                    height: 44,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _amountController,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'Enter Amount'),
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          ThousandsFormatter()
                        ],
                        validator: (value) {
                          String filterValue = value.replaceAll(',', '');
                          if (filterValue.trim().isEmpty) {
                            return 'Please amount';
                          } else if (int.parse(filterValue) < 1) {
                            return 'Minimum amount is 200';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 52),
                  customButton('Proceed', () {
                    // print(_amountController.text);
                    if (_formKey.currentState.validate()) {
                      String filterAmount;
                      num amountPayable;
                      setState(() {
                        filterAmount =
                            _amountController.text.replaceAll(',', '');
                        double transactionFee = (double.tryParse(serviceProvider
                                    .feeModel.data.first.transactionFee) /
                                100) *
                            num.parse(filterAmount);

                        if (transactionFee >
                            double.tryParse(serviceProvider
                                .feeModel.data.first.transactionFeeCap)) {
                          amountPayable = (double.tryParse(serviceProvider
                                  .feeModel.data.first.transactionFeeCap) +
                              num.parse(filterAmount));
                        } else {
                          amountPayable =
                              transactionFee + num.parse(filterAmount);
                        }
                      });
                      FocusScope.of(context).unfocus();
                      wVm.initiateFund(
                          context: context,
                          amountPayable: amountPayable.toString(),
                          confirmAmount: filterAmount);
                    }
                  })
                ],
              ),
            );
          }),
    );
  }

  // _initiatePayment(String amount, String confirmAmount) async {
  //   EasyLoading.show(status: 'Initiating fund');
  //   var response =
  //       await PostServices.initiatePayment(context, num.parse(amount));

  //   if (response is LogSucess) {
  //    _handlePaymentInitialization(
  //                   amount.toString(), confirmAmount);
  //   } else {
  //     EasyLoading.dismiss();
  //     flushbarWidget(context, (response as LogFailure).errorMessage, false);
  //   }
  // }

  // _comfirmPayment(String amount, String paymentRef) async {
  //   EasyLoading.show(status: 'Just a moment');
  //   var response = await PostServices.comfirmPayment(
  //       context, paymentRef, num.parse(amount));

  //   if (response is LogSucess) {
  //     paymentDialog(
  //       context: context,
  //       image: imgCheckedCircle,
  //       title: 'Transaction successful',
  //       buttonText: 'Close',
  //       massage: Text(response.message ?? 'Your transaction was successful'),
  //       callback: () {
  //         Navigator.of(context).pop();
  //       },
  //     );
  //     EasyLoading.dismiss();
  //   } else {
  //     EasyLoading.dismiss();
  //     flushbarWidget(context, (response as LogFailure).errorMessage, false);
  //   }
  // }
}
