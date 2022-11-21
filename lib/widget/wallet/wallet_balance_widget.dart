import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/wallet_balance_model.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/wallet/top_up_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:shimmer/shimmer.dart';
import '../../screens/wallet/withdrawal_screen.dart';

class WalletBalanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
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
            return _loadingContainer();
          } else {
            WalletBalanceModel walletBalanceModel = snapshot.data;
            return _balanceContainer(
                walletBalanceModel.data.walletBalance, context);
          }
        });
  }

  Widget _loadingContainer() {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kc0C0932, borderRadius: BorderRadius.circular(5)),
      child: Shimmer.fromColors(
        baseColor: kcWhite,
        highlightColor: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wallet Balance', style: stFFFFFF400Rubik16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
              "₦",
              style: TextStyle(
                  fontFamily: "",
                  color: kcWhite,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
                Text('0,000,000.0', style: stWhite700Rubik36),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _balanceContainer(String text, BuildContext context) {
    return Container(
      height: 162,
      width: double.infinity,
      decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/walletbg.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Wallet Balance',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFFFFF))),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(imgNaira),
                Text(
                  "₦",
                  style: TextStyle(
                      fontFamily: "",
                      color: kcWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Text(text, style: stWhite700Rubik36)
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 24),
                  width: 116,
                  height: 45,
                  decoration: BoxDecoration(
                    color: kc3DED97,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: MaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(TopUpScreen.routeName),
                    child: Container(
                        // margin: const EdgeInsets.only(right: 51),
                        child: Text('Fund Wallet', style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: kcWhite

                        ))),
                  ),
                ),
                Container(
                  // margin: const EdgeInsets.only(right: 24),
                  height: 45,
                  width: 116,
                  decoration: BoxDecoration(
                    color: kc3DED97,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: MaterialButton(
                      color: kcWhite,
                      onPressed: () => Navigator.of(context)
                          .pushNamed(WithdrawalScreen.routeName),
                      child: Text('Withdraw', style: stFF07C168500Rubik11)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
