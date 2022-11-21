import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/constants/string_format.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/model/initiate_fund_model.dart';
import 'package:fragvest_mobile/model/wallet_transaction_history_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/wallet_service.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/base_view_model.dart';
import 'package:fragvest_mobile/widget/bottom_nav.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:fragvest_mobile/widget/show_custom_dialog.dart';
import 'package:provider/provider.dart';

class WalletMv extends BaseViewModel {
  final walletService = getIt.get<WalletService>();
  WalletTransationHistoryModel walletTransationHistoryModel;
  InitiateFundModel initiateFundModel;
  String historyLoadStatus = 'initial';
  int startDate;
  int endDate;
  String transactionType = '';
  List<HistoryData> filterHistoryData = [];
  bool isFilter = false;

  String selectedDateRange;
  Future<void> walletHistory() async {
    final result = await walletService.walletHistory();
    if (result.hasError) {
      historyLoadStatus = 'failed';
      setState();
    } else {
      historyLoadStatus = 'seccess';
      walletTransationHistoryModel = result.data;
      setState();
    }
  }

  Future<void> initiateFund(
      {@required BuildContext context,
      @required String confirmAmount,
      @required String amountPayable}) async {
    EasyLoading.show(status: 'Just a moment...');
    final result = await walletService.initiateFund(confirmAmount);
    EasyLoading.dismiss();
    if (result.hasError) {
      flushbarWidget(context, result.error.toString(), false);
    } else {
      initiateFundModel = result.data;
      setState();
      _handlePaymentInitialization(
          context: context,
          amountPayable: amountPayable,
          confirmAmount: confirmAmount,
          paymentRef: initiateFundModel.ref);
    }
  }

  _handlePaymentInitialization(
      {@required BuildContext context,
      @required String amountPayable,
      @required String confirmAmount,
      @required String paymentRef}) async {
    ServiceProvider serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    final style = FlutterwaveStyle(
        appBarText: "Fragvest Top Up",
        buttonColor: kc3DED97,
        buttonTextStyle: btnStyle,
        appBarColor: kc3DED97,
        dialogCancelTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        dialogContinueTextStyle: TextStyle(
          color: Colors.purpleAccent,
          fontSize: 18,
        ),
        mainBackgroundColor: Colors.white,
        mainTextStyle:
            TextStyle(color: Colors.black, fontSize: 19, letterSpacing: 2),
        dialogBackgroundColor: Colors.white,
        appBarIcon: Icon(Icons.arrow_back, color: Colors.black),
        buttonText: "Make Payment",
        appBarTitleTextStyle: stBlack700Rubik18);

    final Customer customer = Customer(
        name: "${serviceProvider.firstName} ${serviceProvider.lastName}" ?? "",
        phoneNumber: '${serviceProvider.phoneNumber}' ?? "",
        email: "${serviceProvider.email}" ?? "");
    // final paymentRef = 'Fragpay' + Uuid().v1();
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: 'FLWPUBK-307efe48c0282ed47478a9e2a14b527c-X',
        // publicKey: 'FLWPUBK_TEST-c6ea352d34f83bb718e2f195eb7350e8-X',
        currency: 'NGN',
        txRef: paymentRef,
        amount: amountPayable,
        customer: customer,
        // subAccounts: subAccounts,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Fragvest Payment"),
        redirectUrl: 'https://fragvest.com',
        isTestMode: false);
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      if (response.success) {
        _comfirmPayment(context, paymentRef, num.tryParse(confirmAmount));
      }
    } else {
      flushbarWidget(context, 'You cancelled the transaction', false);
    }
  }

  Future<void> _comfirmPayment(
      BuildContext context, String reference, num confirmAmount) async {
    EasyLoading.show(status: 'Completing...');
    final result = await walletService.comfirmPayment(reference, confirmAmount);
    EasyLoading.dismiss();
    if (result.hasError) {
      flushbarWidget(context, result.error.toString(), false);
    } else {
      paymentDialog(
        context: context,
        image: imgCheckedCircle,
        title: 'Transaction successful',
        buttonText: 'Close',
        massage: Text(result.data.message ?? 'Your transaction was successful'),
        callback: () {
          // Navigator.of(context).pop();
          Navigator.of(context).pushNamedAndRemoveUntil(
              BottomNav.routeName, (Route<dynamic> route) => false);
        },
      );
    }
  }

  setSelectedDate({int start, int end, String value}) {
    startDate = start;
    endDate = end;
    selectedDateRange = value;
    setState();
  }

  setTransactionType(String type) {
    transactionType = type;
    setState();
  }

  resetFilterData(bool resetAll) {
    startDate = null;
    endDate = null;
    selectedDateRange = null;
    transactionType = '';
    isFilter = false;
    setState();

    if (resetAll) {
      filterHistoryData = [];
      setState();
    }
  }

  getFilter(
      {List<HistoryData> history,
      String type,
      int beginDate,
      int stopDate,
      bool isDate}) {
    filterHistoryData = [];
    isFilter = true;
    setState();

    for (int i = 0; i < history.length; i++) {
      int date = DateTime.parse(history[i].updatedAt.toDateFormted)
          .difference(DateTime.now())
          .inHours
          .abs();

      if (type.isNotEmpty && isDate) {
        print('object 1');
        if (history[i].type == type &&
            (date >= beginDate && date <= stopDate)) {
          print('object 2');
          filterHistoryData.add(history[i]);
          setState();
        }
      } else {
        print('object 3');
        if (beginDate == null || stopDate == null) {
          print('object 4');
          if (history[i].type == type) {
            print('object 5');
            filterHistoryData.add(history[i]);
            setState();
          }
        } else {
          if (history[i].type == type ||
              (date >= beginDate && date <= stopDate)) {
            print('object 6');
            filterHistoryData.add(history[i]);
            setState();
          }
        }
      }
    }
  }
}
