import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/wallet_mv.dart';
import 'package:fragvest_mobile/widget/wallet/wallet_history_filter.dart';
import 'package:fragvest_mobile/widget/wallet/wallet_transaction_history._widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AllTransactionHistoryScreen extends StatefulWidget {
  static const routeName = '/all-transaction';
  const AllTransactionHistoryScreen({Key key}) : super(key: key);

  @override
  _AllTransactionHistoryScreenState createState() =>
      _AllTransactionHistoryScreenState();
}

class _AllTransactionHistoryScreenState
    extends State<AllTransactionHistoryScreen> {
  // with SingleTickerProviderStateMixin {
  // TabController _tabController;
  // @override
  // void initState() {
  //   _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kcF5f5f5.withOpacity(0.2),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Transaction history', style: stBlack700Rubik18),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              getIt.get<WalletMv>().resetFilterData(false);

              showMaterialModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return WalletHistoryFilter();
                  });
            },
            icon: Container(
              height: 20,
              child: Image.asset(imgFilter),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: WalletTransactionHistoryWidget(isScrollable: true, isAll: true)

          // Column(
          //   children: [
          //     TabBar(
          //       controller: _tabController,
          //       unselectedLabelStyle: st535353400Rubik15,
          //       labelColor: kc535353,
          //       indicatorColor: kc535353,
          //       indicatorSize: TabBarIndicatorSize.label,
          //       tabs: <Widget>[
          //         Tab(
          //           text: 'YEAR',
          //         ),
          //         Tab(
          //           text: 'MONTH',
          //         ),
          //         Tab(
          //           text: 'DAY',
          //         )
          //       ],
          //     ),
          //     SizedBox(height: 20),
          //     Expanded(
          //       child: TabBarView(controller: _tabController, children: [
          //         AllTransactionHistoryWidget('year'),
          //         AllTransactionHistoryWidget('month'),
          //         AllTransactionHistoryWidget('day'),
          //       ]),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
