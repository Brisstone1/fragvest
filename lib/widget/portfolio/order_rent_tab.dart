import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/constants/string_format.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/retry_button.dart';

class OrderRentTab extends StatelessWidget {
  const OrderRentTab({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<PortfolioVm>(
        model: getIt(),
        initState: (init) {
          init.getRentOrder();
        },
        builder: (pVm, child) {
          return pVm.rentLoadStatus == 'initial'
              ? initialLoader(45)
              : pVm.rentLoadStatus == 'failed'
                  ? RetryButton(
                      orderType: 'rent',
                      title: 'Oops! Could not fetch rent order',
                      voidCallback: () {
                        pVm.getRentOrder();
                      })
                  : pVm.rentLoadStatus == 'success' &&
                          pVm.rentOderHistoryModel != null
                      ? SizedBox(
                          child: pVm.rentOderHistoryModel.data.isEmpty
                              ? Center(
                                  child: Text('No rent order yet!'),
                                )
                              : ListView.separated(
                                  itemCount:
                                      pVm.rentOderHistoryModel.data.length,
                                  itemBuilder: (context, index) {
                                    final rentOrder =
                                        pVm.rentOderHistoryModel.data[index];
                                    final amount = addCommaToString.format(
                                        num.parse(rentOrder.portfolio.amount));
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  rentOrder.portfolio.property
                                                      .tokenId,
                                                  style: st16161D500Rubik14
                                                      .copyWith(
                                                    fontSize: 14,
                                                    color: Color(0xFF0C0932),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: Text('₦',
                                                        style: st33A02C400Rubik9
                                                            .copyWith(
                                                                fontFamily: "",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFF07C168))),
                                                  ),
                                                  Container(
                                                    child: Text('$amount per annum',
                                                        style: st33A02C400Rubik9
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFF07C168))),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text(
                                                  rentOrder.orderType
                                                      .capitalize(),
                                                  style: st33A02C400Rubik9
                                                      .copyWith(
                                                          color: rentOrder
                                                                      .orderType ==
                                                                  'forfeited'
                                                              ? kc6C63FF
                                                              : rentOrder.orderType ==
                                                                      'expired'
                                                                  ? kcEE1A1A
                                                                  : kcFFC327),
                                                ),
                                              ),
                                              Container(
                                                child: Container(
                                                  child: Text(
                                                      rentOrder
                                                          .createdAt.toDate,
                                                      style: st33A02C400Rubik9
                                                          .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: kc535353)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      // child: Row(
                                      //   children: [
                                      //     Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         // Text(
                                      //         //   rentOrder
                                      //         //       .portfolio.property.tokenId,
                                      //         //   style: st16161D500Rubik14
                                      //         //       .copyWith(fontSize: 12),
                                      //         // ),
                                      //         Container(
                                      //           color: Color(0xFF000000),
                                      //           child: Row(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment
                                      //                     .spaceBetween,
                                      //             children: [
                                      //               // Container(
                                      //               //   child: Text(
                                      //               //     rentOrder.orderType
                                      //               //         .capitalize(),
                                      //               //     style: st33A02C400Rubik9
                                      //               //         .copyWith(
                                      //               //         color: rentOrder
                                      //               //             .orderType ==
                                      //               //             'forfeited'
                                      //               //             ? kc6C63FF
                                      //               //             : rentOrder.orderType ==
                                      //               //             'expired'
                                      //               //             ? kcEE1A1A
                                      //               //             : kcFFC327),
                                      //               //   ),
                                      //               // ),
                                      //               // Container(
                                      //               //   child: Text(
                                      //               //     rentOrder.orderType
                                      //               //         .capitalize(),
                                      //               //     style: st33A02C400Rubik9
                                      //               //         .copyWith(
                                      //               //         color: rentOrder
                                      //               //             .orderType ==
                                      //               //             'forfeited'
                                      //               //             ? kc6C63FF
                                      //               //             : rentOrder.orderType ==
                                      //               //             'expired'
                                      //               //             ? kcEE1A1A
                                      //               //             : kcFFC327),
                                      //               //   ),
                                      //               // ),
                                      //
                                      //               // Container(
                                      //               //   child: Text(
                                      //               //       rentOrder
                                      //               //           .createdAt.toDate,
                                      //               //       style: st33A02C400Rubik9
                                      //               //           .copyWith(
                                      //               //           color:
                                      //               //           kc535353)),
                                      //               // ),
                                      //             ],
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //     const Spacer(),
                                      //     // Text(
                                      //     //   '₦$amount p.a',
                                      //     //   style: st33A02C400Rubik9.copyWith(
                                      //     //       fontSize: 11, color: kc535353),
                                      //     // )
                                      //   ],
                                      // ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  }),
                        )
                      : RetryButton(
                          orderType: 'rent',
                          title: 'Oops! Could not fetch rent order',
                          voidCallback: () {
                            pVm.getRentOrder();
                            // pVm.setState();
                          });
        });
  }
}
