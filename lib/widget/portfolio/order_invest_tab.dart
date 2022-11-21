import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/constants/string_format.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/retry_button.dart';

class OrderInvestTab extends StatelessWidget {
  const OrderInvestTab({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BaseViewBuilder<PortfolioVm>(
        model: getIt(),
        initState: (init) {
          init.getInvestOrder();
        },
        builder: (pVm, child) {
          return pVm.investLoadStatus == 'initial'
              ? initialLoader(45)
              : pVm.investLoadStatus == 'failed'
                  ? RetryButton(
                      orderType: 'invest',
                      title: 'Oops! Could not fetch invest order',
                      voidCallback: () {
                        pVm.getInvestOrder();
                        // pVm.setState();
                      })
                  : pVm.investLoadStatus == 'success' &&
                          pVm.investOrderHistoryModel != null
                      ? SizedBox(
                          child: pVm.investOrderHistoryModel.data.isEmpty
                              ? Center(
                                  child: Text('No co-owned order yet!'),
                                )
                              : ListView.separated(
                                  itemCount:
                                      pVm.investOrderHistoryModel.data.length,
                                  itemBuilder: (context, index) {
                                    final invest =
                                        pVm.investOrderHistoryModel.data[index];
                                    final costPrice = addCommaToString.format(
                                        num.parse(invest
                                            .portfolio.property.costPrice));

                                    print(invest.orderType);
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
                                                invest
                                                    .portfolio.property.tokenId,
                                                style:
                                                    st16161D500Rubik14.copyWith(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    invest.orderType
                                                                 ==
                                                            "invested"
                                                        ? "Frags Bought"
                                                        : invest.orderType
                                                                     ==
                                                                "sell"
                                                            ? "Frags Sold"
                                                            : invest.orderType
                                                                .capitalize(),
                                                    style: st33A02C400Rubik9
                                                        .copyWith(
                                                            color:
                                                                invest.orderType ==
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
                                                  Text(invest.createdAt.toDate,
                                                      style: st33A02C400Rubik9
                                                          .copyWith(
                                                              color: kc535353)),
                                                  Text(' * ',
                                                      style: st33A02C400Rubik9
                                                          .copyWith(
                                                        color: kc535353,
                                                        fontSize: 7,
                                                      )),
                                                  Text(
                                                      invest.orderType == 'sell'
                                                          ? '₦${invest.amount} per frag'
                                                          : '₦${invest.portfolio.amount} per frag',
                                                      style: st33A02C400Rubik9
                                                          .copyWith(
                                                              fontFamily: "",
                                                              color: Color(
                                                                  0xFF07C168)))
                                                ],
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Text(
                                            '$costPrice',
                                            style: st33A02C400Rubik9.copyWith(
                                                fontSize: 11,
                                                color: Color(0xFF07C168)),
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
                          orderType: 'invest',
                          title: 'Oops! Could not fetch invest order',
                          voidCallback: () {
                            pVm.getInvestOrder();
                            // pVm.setState();
                          });
        });
  }
}

//rent
//invest
//sale == buy

//sela frag = only invested

//Paybride icon
//Transaction = arrow => buy inword and sell is upwoard
