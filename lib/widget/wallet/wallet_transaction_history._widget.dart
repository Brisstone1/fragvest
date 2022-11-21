import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/wallet_mv.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/retry_button.dart';
import '../../constants/kcolors.dart';

class WalletTransactionHistoryWidget extends StatelessWidget {
  final bool isScrollable;
  final bool isAll;

  const WalletTransactionHistoryWidget({
    Key key,
    this.isScrollable,
    this.isAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<WalletMv>(
      model: getIt(),
      initState: (init) {
        init.walletHistory();
        Future.delayed(Duration.zero, () {
          init.resetFilterData(false);
        });
      },
      builder: (wVm, child) {
        return wVm.historyLoadStatus == 'initial'
            ? initialLoader(45)
            : wVm.historyLoadStatus == 'failed'
                ? RetryButton(
                    orderType: 'rent',
                    title: 'Oops! Could not fetch wallet history',
                    voidCallback: () {
                      wVm.walletHistory();
                    })
                : wVm.historyLoadStatus == 'seccess' &&
                        wVm.walletTransationHistoryModel != null
                    ? SizedBox(
                        child: (isAll &&
                                wVm.isFilter &&
                                wVm.filterHistoryData.isEmpty)
                            ? Center(child: Text('No filter result!'))
                            : wVm.walletTransationHistoryModel.history.isEmpty
                                ? Center(child: Text('No transaction history!'))
                                : ListView.builder(
                                    physics: isScrollable
                                        ? BouncingScrollPhysics()
                                        : NeverScrollableScrollPhysics(),
                                    shrinkWrap: isScrollable,
                                    itemCount: (isAll && wVm.isFilter)
                                        ? wVm.filterHistoryData.length
                                        : (isAll && !wVm.isFilter)
                                            ? wVm.walletTransationHistoryModel
                                                .history.length
                                            : wVm.walletTransationHistoryModel
                                                .history
                                                .take(7)
                                                .length,
                                    // itemCount: ,
                                    itemBuilder: (context, index) {
                                      // final txn = wVm.walletTransationHistoryModel
                                      //     .history[index];
                                      // int month = 0;
                                      final txn = (isAll && wVm.isFilter)
                                          ? wVm.filterHistoryData[index]
                                          : wVm.walletTransationHistoryModel
                                              .history[index];

                                      print(wVm.walletTransationHistoryModel
                                          .history[index]);

                                      print(wVm.walletTransationHistoryModel.history);
                                      print(txn);
                                      print(txn.narration);
                                      print(txn.amount);
                                      print('okoooooooooooooooooooooo');

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                txn.type == 'credit'
                                                    ? imgCreditTxn
                                                    : imgDebit,
                                                height: 30),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "₦",
                                                      style: TextStyle(
                                                          fontFamily: "",
                                                          color: kc0C0932.withOpacity(0.8),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text('${txn.amount}',
                                                        style:  TextStyle(
                                                            // fontFamily: "",
                                                            color: kc0C0932.withOpacity(0.8),
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                Text(txn.status,
                                                    style: st535353400Rubik10
                                                        .copyWith(
                                                            color: txn.status ==
                                                                    'success'
                                                                ? kc3DED97
                                                                : Color(
                                                                    0xFFFFC327)))
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                // Row(
                                                //   children: [
                                                //     Image.asset(imgNaira, color: kc535353, height: 10),
                                                //     Text(txn.amount, style: st535353500Rubuk12),
                                                //   ],
                                                // ),
                                                Text('${txn.date}',
                                                    style:  TextStyle(
                                                        fontFamily: "",
                                                        color: Color(0xFF969595).withOpacity(0.8),
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500),
                                            ),
                                                Row(
                                                  children: [
                                                    Text("${txn.narration}",
                                                      style: st535353400Rubik10),
                                                      SizedBox(width: 20),
                                                    Text(txn.type,
                                                        style: st535353400Rubik10)],
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                      // : SizedBox();
                                    }),
                      )
                    : RetryButton(
                        orderType: 'rent',
                        title: 'Oops! Could not fetch wallet history',
                        voidCallback: () {
                          wVm.walletHistory();
                        });
      },
    );
  }
}
