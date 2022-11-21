import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/screens/wallet/top_up_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:provider/provider.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        context.watch<ServiceProvider>().dataDashboardModel.user.balance;

    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: new DecorationImage(
          image: new AssetImage("assets/images/walletbg.png"),
          fit: BoxFit.fill,
        ),
      ),
      height: 165,
      width: double.infinity,
      // decoration: BoxDecoration(
      //   color: kc0C0932,
      //   borderRadius: BorderRadius.circular(5),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Wallet Balance', style: stWhite400Rubik16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   imgNaira,
              //   // height: 100,
              //   // width: 100,
              // ),
              Text(
                "₦",
                style: TextStyle(
                    fontFamily: "",
                    color: kcWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              Text(serviceProvider, style: stWhite700Rubik36),
            ],
          ),
          MaterialButton(
            color: kc3DED97,
            child: Text('Fund Wallet', style: stWhite700Rubik11),
            onPressed: () =>
                Navigator.of(context).pushNamed(TopUpScreen.routeName),
          )
        ],
      ),
    );
  }
}
