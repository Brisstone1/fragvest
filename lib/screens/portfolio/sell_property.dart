import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/list_item.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/portfolio/portfolio_dialog.dart';
import 'package:fragvest_mobile/widget/security_pin_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SellPropertyScreen extends StatefulWidget {
  const SellPropertyScreen({Key key}) : super(key: key);

  @override
  State<SellPropertyScreen> createState() => _SellPropertyScreenState();
}

class _SellPropertyScreenState extends State<SellPropertyScreen> {
  int _currentindex;
  bool _isCustom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(
      //   context: context,
      //   title: 'Sell a Property',
      // ),
      body: BaseViewBuilder<PortfolioVm>(
          model: getIt(),
          initState: (init) {
            init.setCustomDiscount(null);
          },
          builder: (pVm, child) {
            return Container(
              // color: Colors.orange,
              child: Column(
                // padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      homeIndicator,
                      width: 100,
                      height: 4,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      // color: Colors.red,
                      height: 230,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Select a discount',
                                  style: st535353600Rubik16),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              // padding: const EdgeInsets.only(left: 10),
                              itemCount: sellPropertyDiscount.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentindex = index;
                                        if (sellPropertyDiscount[index] ==
                                            'Custom') {
                                          _isCustom = true;
                                          pVm.setCustomDiscount(null);
                                        } else {
                                          _isCustom = false;
                                        }
                                      });

                                      pVm.setDiscount(index);
                                    },
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //   Icons.circle,
                                        //   size: 24,
                                        //   color: _currentindex == index
                                        //       ? kc3DED97
                                        //       : kcDBDBDB,
                                        // ),
                                        Container(
                                          width: 16,
                                          height: 16,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: kcWhite,
                                              border: Border.all(
                                                  width: 1, color: kc0C0932),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: _currentindex == index
                                                    ? kc3DED97
                                                    : kcWhite,
                                                // border: Border.all(width: 1, color: kc0C0932),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          sellPropertyDiscount[index],
                                          style: st000000400Rubik14,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          // if (_isCustom)
                          Container(
                            // margin: const EdgeInsets.only(left: 0),
                            // color: Colors.blue,
                            // margin: const EdgeInsets.only(bottom: 8),
                            // width: 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Custom Discount',
                                    style: TextStyle(
                                        color: kc0C0932,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 5),
                                Container(
                                  height: 44,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Enter Discount",
                                      hintStyle: TextStyle(
                                          color: kc0C0932,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                      filled: true, //<-- SEE HERE
                                      fillColor: Color(0xFFF5F5F8),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 5, color: Color(0xFFF5F5F8)),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        //<-- SEE HERE
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4.0))),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                    // decoration: supportDecoration,

                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        pVm.setExeeded(int.parse(value));
                                      }

                                      if (value.isNotEmpty &&
                                          int.parse(value) <= 100) {
                                        pVm.setCustomDiscount(value);
                                      } else {
                                        pVm.setCustomDiscount(null);
                                      }
                                    },
                                  ),
                                ),
                                if (pVm.isExeeded)
                                  Text(
                                    'Minimum of 100% discount',
                                    style: st33A02C400Rubik9.copyWith(
                                        color: kcEE1A1A),
                                  )
                              ],
                            ),
                          ),
                        ],
                      )
                      // Card(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(20.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      ),
                  const SizedBox(height: 20),
                  customButton('Sell Property', () {
                    if (pVm.sellPropertyDiscount != null) {
                      final sellP = pVm.sellPropertyMap;

                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return PorfolioDialog(
                      //         title: 'Sell Property',
                      //         operationType: 'Sell',
                      //         operactionColor: kc3DED97,
                      //         content:
                      //             "You are about place a sell request for ${sellP.token} at a ${pVm.sellPropertyDiscount}% Discount. ",
                      //         operationCallback: () {
                      //           Navigator.of(context).pop();
                      //           _showPinMoedal();
                      //         },
                      //       );
                      //     });
                      showMaterialModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 16),
                                height: 238,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Image.asset(homeIndicator),
                                      SizedBox(height: 18,),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Confirm Sell', style: st535353600Rubik16,),
                                      )
                                      ,
                                      SizedBox(height: 24,),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Text("You are about place a sell request for ${sellP.token} at a ${pVm.sellPropertyDiscount}% Discount."),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 48,
                                        child: MaterialButton(
                                          color: kc3DED97,
                                          onPressed: () {
                                            _showPinMoedal();
                                          },
                                          child: Text(
                                            'Sell', style: TextStyle(
                                            color: Color(0xFFFFFFFF)
                                          ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          });
                    } else {
                      flushbarWidget(context, 'Invalid discount', false);
                    }
                  })
                ],
              ),
            );
          }),
    );
  }

  _showPinMoedal() {

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            child: SecurityPinWidget(
              operationType: 'sellProperty',
            ),
          );
        });
    // showMaterialModalBottomSheet(
    //     backgroundColor: Colors.transparent,
    //     context: context,
    //     builder: (context) {
    //       return Container(
    //           padding: EdgeInsets.symmetric(
    //               vertical: 20, horizontal: 16),
    //           height: 367,
    //           decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.vertical(
    //                   top: Radius.circular(20))),
    //           child: SecurityPinWidget(operationType: 'sellProperty'));
    //
    //     });
  }
}
