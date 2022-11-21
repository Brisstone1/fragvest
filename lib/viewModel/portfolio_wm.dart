import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/model/buy_order_history_model.dart';
import 'package:fragvest_mobile/model/invest_order_history_model.dart';
import 'package:fragvest_mobile/model/rent_oder_history_model.dart';
import 'package:fragvest_mobile/repository/portfolio_service.dart';
import 'package:fragvest_mobile/utilities/logger_util.dart';
import 'package:fragvest_mobile/viewModel/base_view_model.dart';
import 'package:fragvest_mobile/widget/bottom_nav.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/show_custom_dialog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class PortfolioVm extends BaseViewModel {
  final portfolioService = getIt.get<PortfolioService>();
  RentOderHistoryModel rentOderHistoryModel;
  BuyOrderHistoryModel buyOrderHistoryModel;
  InvestOrderHistoryModel investOrderHistoryModel;

  String rentLoadStatus = 'initial';
  String rentFaildError = '';

  String buyLoadStatus = 'initial';
  String buyFaildError = '';

  String investLoadStatus = 'initial';
  String investFaildError = '';

  String sellPropertyDiscount;
  bool isExeeded = false;

  SellPropertyMap sellPropertyMap;

  double assetPrice = 0.0;

  int fragPercent = 0;
  double fragPercentValue = 0.0;
  int percentIndex = 0;
  List<String> pressedNumber = [];
  bool isPercent = false;

  List<String> renewDuration = [];

  setDiscount(int index) {
    if (index == 0) {
      sellPropertyDiscount = '5';
      isExeeded = false;
      print(sellPropertyDiscount);
      setState();
    } else if (index == 1) {
      sellPropertyDiscount = '10';
      isExeeded = false;
      setState();
      print(sellPropertyDiscount);
    } else if (index == 2) {
      sellPropertyDiscount = '0';
      isExeeded = false;
      setState();
      print(sellPropertyDiscount);
    }
  }

  setCustomDiscount(String discount) {
    sellPropertyDiscount = discount;
    setState();
    // print(sellPropertyDiscount);
  }

  setExeeded(int value) {
    if (value > 100) {
      isExeeded = true;
      setState();
    } else {
      isExeeded = false;
    }
  }

//Values are added in bit in different places
  setPortfolioMap(
      {num id,
      String token,
      String pricePerFrag,
      String investedFrag,
      String assetPrice,
      String pressedValue,
      String renewDuration}) async {
    sellPropertyMap = SellPropertyMap(
        portfolioId: id,
        token: token,
        investedFrag: investedFrag,
        pricePerFrag: pricePerFrag,
        assetPrice: assetPrice,
        pressedValue: pressedValue,
        renewDuration: renewDuration);
    setState();
  }

  setFragPercent(int percent, int index) {
    isPercent = true;
    fragPercent = percent;
    percentIndex = index;
    assetPrice = 0.0;
    fragPercentValue = (fragPercent / 100) *
        double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''));
    assetPrice = ((fragPercent / 100) *
            double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''))) *
        double.tryParse(sellPropertyMap.pricePerFrag.replaceAll(' p.f', ''));

    setState();
  }

  assetCalculator(BuildContext context, String number) {
    isPercent = false;
    fragPercent = 0;
    percentIndex = 0;
    pressedNumber.add(number);
    // fragPercent = int.parse(pressedNumber.join());

    fragPercent = int.parse(number);
    if (fragPercent.toDouble() <=
        double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''))) {
      assetPrice = fragPercent.toDouble() *
          double.tryParse(sellPropertyMap.pricePerFrag.replaceAll(' p.f', ''));
      print(pressedNumber.join());
      setState();
    } else {
      flushbarWidget(
          context,
          'You can only sell maximun of ${sellPropertyMap.investedFrag} frag',
          false);
    }
    setState();
  }

  clearbutton() {
    pressedNumber = [];
    assetPrice = 0.0;
    fragPercentValue = 0.0;
    percentIndex = 0;
    fragPercent = 0;
    setState();
  }

  getRenewDuration(String number) {
    renewDuration.add(number);
    setState();
  }

  clearDurationButton() {
    renewDuration = [];
    setState();
  }

  Future<void> getRentOrder() async {
    final result = await portfolioService.getRentOrder();
    if (result.hasError) {
      rentLoadStatus = 'failed';
      rentFaildError = result.error.toString();
      setState();
      logger.d(result.error.toString());
    } else {
      rentLoadStatus = 'success';
      rentOderHistoryModel = result.data;
      setState();
    }
  }

  Future<void> getBuyOrder() async {
    final result = await portfolioService.getBuyOrder();
    if (result.hasError) {
      buyLoadStatus = 'failed';
      buyFaildError = result.error.toString();
      logger.d(result.error.toString());
    } else {
      buyLoadStatus = 'success';
      buyOrderHistoryModel = result.data;
      setState();
    }
  }

  Future<void> getInvestOrder() async {
    final result = await portfolioService.getInvestOrder();
    if (result.hasError) {
      investLoadStatus = 'failed';
      investFaildError = result.error.toString();
      logger.d(result.error.toString());
    } else {
      investLoadStatus = 'success';
      investOrderHistoryModel = result.data;
      setState();
    }
  }

  Future<void> forfeitProperty(BuildContext context, String portfolioId,
      String pin, Widget message) async {
    EasyLoading.show(status: 'Forfeiting Property...');
    final result = await portfolioService.forfeitProperty(portfolioId, pin);
    EasyLoading.dismiss();
    if (result.hasError) {
      flushbarWidget(context, result.error.toString(), false);
    } else {
      // showCustomDialog(
      //     isDismissed: false,
      //     context: context,
      //     image: imgCheckedCircle,
      //     title: 'Operation Successful',
      //     buttonText: 'Close',
      //     massage: message,
      //     callback: () {
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     },
      //     clearCalback: () {
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     });

      showMaterialModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 134,
                        width: 134,
                        child: Image.asset(
                          imgCheckedCircle,
                          width: 134,
                          height: 134,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text('Operation Successful',
                            style:
                                st535353600Rubik16.copyWith(color: kc0C0932)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: MaterialButton(
                          color: kc07C168,
                          onPressed: () async {
                            await Navigator.of(context).pushNamedAndRemoveUntil(
                                BottomNav.routeName,
                                (Route<dynamic> route) => false);
                          },
                          child: Text('Close',
                              style: st535353600Rubik16.copyWith(
                                  color: kcWhite, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ));
          });
    }
  }

  Future<void> sellProperty(BuildContext context, String portfolioId,
      String discount, String pin, Widget message) async {
    EasyLoading.show(status: 'Selling Property...');
    final result =
        await portfolioService.sellProperty(portfolioId, discount, pin);
    EasyLoading.dismiss();
    if (result.hasError) {
      flushbarWidget(context, result.error.toString(), false);
    } else {
      // showCustomDialog(
      //     isDismissed: false,
      //     context: context,
      //     image: imgCheckedCircle,
      //     title: 'Operation Successful',
      //     buttonText: 'Close',
      //     massage: message,
      //     callback: () {
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     },
      //     clearCalback: () {
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     });

      showMaterialModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 134,
                        width: 134,
                        child: Image.asset(
                          imgCheckedCircle,
                          width: 134,
                          height: 134,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text('Operation Successful',
                            style:
                                st535353600Rubik16.copyWith(color: kc0C0932)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: MaterialButton(
                          color: kc07C168,
                          onPressed: () async {
                            await Navigator.of(context).pushNamedAndRemoveUntil(
                                BottomNav.routeName,
                                (Route<dynamic> route) => false);
                          },
                          child: Text('Close',
                              style: st535353600Rubik16.copyWith(
                                  color: kcWhite, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ));
          });
    }
  }

  Future<void> sellFrag(
      {BuildContext context,
      String portfolioId,
      String frag,
      String pin,
      Widget message}) async {
    EasyLoading.show(status: 'Selling Property...');
    final result = await portfolioService.sellFrag(portfolioId, frag, pin);
    EasyLoading.dismiss();
    if (result.hasError) {
      flushbarWidget(context, result.error.toString(), false);
    } else {
      showMaterialModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 134,
                        width: 134,
                        child: Image.asset(
                          imgCheckedCircle,
                          width: 134,
                          height: 134,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text('Transaction Successf',
                            style:
                                st535353600Rubik16.copyWith(color: kc0C0932)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: MaterialButton(
                          color: kc07C168,
                          onPressed: () async {
                            await Navigator.of(context).pushNamedAndRemoveUntil(
                                BottomNav.routeName,
                                (Route<dynamic> route) => false);
                          },
                          child: Text('Close',
                              style: st535353600Rubik16.copyWith(
                                  color: kcWhite, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ));
          });

      // showCustomDialog(
      //     isDismissed: false,
      //     context: context,
      //     image: imgCheckedCircle,
      //     title: 'Transaction Successful',
      //     buttonText: 'Close',
      //     massage: message,
      //     callback: () {
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     },
      //     clearCalback: () {
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       // Navigator.of(context).pop();
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     });
    }
  }

  Future<void> renewRent(
      {BuildContext context,
      String propertyId,
      String duration,
      String pin,
      Widget message}) async {
    EasyLoading.show(status: 'Just a moment...');
    final result = await portfolioService.renewRent(propertyId, duration, pin);
    EasyLoading.dismiss();
    if (result.hasError) {
      flushbarWidget(context, result.error.toString(), false);
    } else {
      // showCustomDialog(
      //     isDismissed: false,
      //     context: context,
      //     image: imgCheckedCircle,
      //     title: 'Rent Renew Successfully',
      //     buttonText: 'Close',
      //     massage: message,
      //     callback: () {
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     },
      //     clearCalback: () {
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           BottomNav.routeName, (Route<dynamic> route) => false);
      //     });
      showMaterialModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 134,
                        width: 134,
                        child: Image.asset(
                          imgCheckedCircle,
                          width: 134,
                          height: 134,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text('Rent Renew Successfully',
                            style:
                                st535353600Rubik16.copyWith(color: kc0C0932)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: MaterialButton(
                          color: kc07C168,
                          onPressed: () async {
                            await Navigator.of(context).pushNamedAndRemoveUntil(
                                BottomNav.routeName,
                                (Route<dynamic> route) => false);
                          },
                          child: Text('Close',
                              style: st535353600Rubik16.copyWith(
                                  color: kcWhite, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ));
          });
    }
  }
}

class SellPropertyMap {
  final num portfolioId;
  final String token;
  final String investedFrag;
  final String pricePerFrag;
  final String assetPrice;
  final String pressedValue;
  final String renewDuration;

  SellPropertyMap(
      {this.portfolioId,
      this.token,
      this.investedFrag,
      this.pricePerFrag,
      this.assetPrice,
      this.pressedValue,
      this.renewDuration});
}
