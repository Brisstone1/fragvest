import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/constants/string_format.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/retry_button.dart';

class OrderBuyTab extends StatelessWidget {
  const OrderBuyTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<PortfolioVm>(
        model: getIt(),
        initState: (init) {
          init.getBuyOrder();
        },
        builder: (pVm, child) {
          return pVm.buyLoadStatus == 'initial'
              ? initialLoader(45)
              : pVm.buyLoadStatus == 'failed'
                  ? RetryButton(
                      orderType: 'buy',
                      title: 'Oops! Could not fetch buy order',
                      voidCallback: () {
                        pVm.getRentOrder();
                        // pVm.setState();
                      })
                  : pVm.buyLoadStatus == 'success' &&
                          pVm.buyOrderHistoryModel != null
                      ? SizedBox(
                          child: pVm.buyOrderHistoryModel.data.isEmpty
                              ? Center(
                                  child: Text('No buy order yet!'),
                                )
                              : ListView.separated(
                                  itemCount:
                                      pVm.buyOrderHistoryModel.data.length,
                                  itemBuilder: (context, index) {
                                    final buyOrder =
                                        pVm.buyOrderHistoryModel.data[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                buyOrder
                                                    .portfolio.property.tokenId,
                                                style: st16161D500Rubik14
                                                    .copyWith(fontSize: 14),
                                              ),
                                              Text(
                                                buyOrder.status.capitalize(),
                                                style:
                                                st33A02C400Rubik9.copyWith(
                                                    color: buyOrder
                                                        .status ==
                                                        'pending'
                                                        ? kcFFC327
                                                        : buyOrder.status ==
                                                        'cancelled'
                                                        ? kcEE1A1A
                                                        : kc33A02C),
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                            Row(
                                              children: [
                                                Text(
                                                  buyOrder.orderType == 'owned'
                                                      ? '₦'
                                                      : '₦',
                                                  style:
                                                  st33A02C400Rubik9.copyWith(
                                                      fontSize: 11,
                                                      fontFamily: "",
                                                      color: Color(0xFF07C168)),
                                                ),
                                                Text(
                                                  buyOrder.orderType == 'owned'
                                                      ? '${addCommaToString.format(num.parse(buyOrder.portfolio.amount))}'
                                                      : '${addCommaToString.format(num.parse(buyOrder.amount))}',
                                                  style:
                                                  st33A02C400Rubik9.copyWith(
                                                      fontSize: 11,
                                                      color: Color(0xFF07C168)),
                                                ),
                                              ],
                                            ),
                                              Row(
                                                children: [
                                                  Text(
                                                    buyOrder.orderType
                                                        .capitalize(),
                                                    style: st33A02C400Rubik9
                                                        .copyWith(
                                                        color:
                                                        buyOrder.orderType ==
                                                            'sell'
                                                            ? kc6C63FF
                                                            : kc00AA57),
                                                  ),
                                                  Text(
                                                    ' * ',
                                                    style: st33A02C400Rubik9
                                                        .copyWith(
                                                        fontSize: 7,
                                                        color: kc535353),
                                                  ),
                                                  Text(
                                                      buyOrder.createdAt.toDate,
                                                      style: st33A02C400Rubik9
                                                          .copyWith(
                                                          color: kc535353)),
                                                  if (buyOrder.orderType ==
                                                      'sell')
                                                    Text(' * ',
                                                        style: st33A02C400Rubik9
                                                            .copyWith(
                                                          color: kc535353,
                                                          fontSize: 7,
                                                        )),
                                                  if (buyOrder.orderType ==
                                                      'sell')
                                                    Text(
                                                        '${buyOrder.discount}%',
                                                        style: st33A02C400Rubik9
                                                            .copyWith(
                                                            color:
                                                            kc535353))
                                                ],
                                              )

                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  }),
                        )
                      : RetryButton(
                          orderType: 'buy',
                          title: 'Oops! Could not fetch buy order',
                          voidCallback: () {
                            pVm.getRentOrder();
                          });
        });
  }
}
