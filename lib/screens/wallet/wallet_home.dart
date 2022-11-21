import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/get_card_model.dart';
import 'package:fragvest_mobile/model/user_bank_account_model.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/wallet/saved_cards.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/wallet/wallet_transaction_history._widget.dart';
import 'package:fragvest_mobile/widget/wallet/wallet_balance_widget.dart';
import 'package:fragvest_mobile/widget/wallet/wallet_bank_detail.dart';
import 'package:fragvest_mobile/widget/wallet/wallet_row_button.dart';

import '../../model/wallet_transaction_history_model.dart';
import 'all_transaction_history_screen.dart';

class WalletHome extends StatefulWidget {
  static const routeName = '/wallet-home';

  @override
  State<WalletHome> createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  Future<List<dynamic>> _getFuture() {
    return Future.wait([
      GetServices.getUserAccountBank(context),
      GetServices.getCard(context),
      // GetServices.getWalletHistory(context),
    ]);
  }

  Future<void> _refreshScreen() {
    return Future.delayed(Duration(seconds: 8), () async {
      await GetServices.getWalletBalance(context);
      await GetServices.getUserAccountBank(context);
      await GetServices.getCard(context);
      setState(() {});
      // await GetServices.getWalletHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getFuture();
    return Scaffold(
      appBar: actionAppBar('My wallet', imgAvater, () {}, false, false),
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              WalletBalanceWidget(),
              SizedBox(height: 20),
              WalletRowButton(),
              SizedBox(height: 20),
              FutureBuilder<List>(
                  future: _getFuture(),
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
                              child: Text(snapshot.error.toString() ==
                                      'Connection closed before full header was received'
                                  ? 'Internet connection failed'
                                  : snapshot.error.toString()),
                            )
                          ],
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Container(
                        height: 40,
                        width: 40,
                        child: SpinKitDancingSquare(
                          color: kc3DED97,
                        ),
                      );
                    } else {
                      UserBankAccountModel userBankAccountModel =
                          snapshot.data[0];
                      GetCardModel getCardModel = snapshot.data[1];
                      // WalletTransationHistoryModel walletTxn = snapshot.data[2];
                      return Column(
                        children: [
                          WalletBankDetail(
                              userBankAccountModel: userBankAccountModel),
                          SavedCardsWidget(getCardModel: getCardModel),
                          SizedBox(height: 10),
                        ],
                      );
                    }
                  }),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(AllTransactionHistoryScreen.routeName),
                child: Row(
                  children: [
                    Text('Transaction history', style: st535353600Rubik16),
                    Spacer(),
                    Text(
                      'view all',
                      style: st535353700Rubik14.copyWith(
                          // decoration: TextDecoration.underline
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              WalletTransactionHistoryWidget(
                isScrollable: true,
                isAll: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
