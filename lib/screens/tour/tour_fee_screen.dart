import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:provider/provider.dart';

import '../../model/wallet_balance_model.dart';
import '../../provider/service_provider.dart';
import '../../repository/get_services.dart';
import '../../repository/post_services.dart';
import '../../repository/repo_Validatary.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/flush_bar_widget.dart';

class TourFeeScreen extends StatefulWidget {
  final int prodcutId;
  final String time;
  final String email;
  final String phoneNumber;

  TourFeeScreen(
      {@required this.prodcutId,
      @required this.time,
      @required this.email,
      @required this.phoneNumber});
  @override
  State<TourFeeScreen> createState() => _TourFeeScreenState();
}

class _TourFeeScreenState extends State<TourFeeScreen> {
  double _brokerCharge = 0.0;
  double _estAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    String _token = context.watch<UserToken>().userToken;
    final feeModel = Provider.of<ServiceProvider>(context, listen: false)
        .feeModel
        .data
        .first;
    return Scaffold(
        backgroundColor: kc0C0932,
        appBar: paymentAppbar('Schedule a Tour Fee'),
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
                return ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.98,
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
                                _numberText('${feeModel.agentTourFee}')
                              ],
                            ),
                          ),
                          _container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _totleText('Wallet Balance'),
                                _numberText(
                                    '${walletBalanceModel.data.walletBalance}')
                              ],
                            ),
                          ),
                          SizedBox(height: 70),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: customButton(
                                'Proceed to payment', _scheduleTour),
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

  _scheduleTour() async {
    // _showPinMoedal();
    EasyLoading.show(status: 'Processing...');
    var response = await PostServices.scheduleTour(
        context: context,
        propertyId: widget.prodcutId,
        dateTime: widget.time,
        email: widget.email,
        phone: widget.phoneNumber);
    if (response is LogSucess) {
      EasyLoading.dismiss();
      Navigator.pop(context);
      flushbarWidget(context, response.message, true);
    } else {
      EasyLoading.dismiss();
      flushbarWidget(context, (response as LogFailure).errorMessage, false);
    }
  }
}

// _showPinMoedal() {
//   showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return WithdrawalPinWidget();
//       });
// }
// }
