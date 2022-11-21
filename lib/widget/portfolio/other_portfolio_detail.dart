import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/portfolio/renew_rent.dart';
import 'package:fragvest_mobile/screens/portfolio/sell_asset.dart';
import 'package:fragvest_mobile/screens/portfolio/sell_property.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/portfolio/portfolio_dialog.dart';
import 'package:fragvest_mobile/widget/property_date_detail.dart';
import 'package:fragvest_mobile/widget/property_date_detail2.dart';
import 'package:fragvest_mobile/widget/read_more_widget.dart';
import 'package:fragvest_mobile/widget/security_pin_widget.dart';
import 'package:fragvest_mobile/widget/show_google_map.dart';
import '../custom_button_widget.dart';
import '../few_property_detail_widget.dart';
import '../flush_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';

class OtherPortfolioDetails extends StatefulWidget {
  @override
  _OtherPortfolioDetailsState createState() => _OtherPortfolioDetailsState();
}

class _OtherPortfolioDetailsState extends State<OtherPortfolioDetails> {
  bool _isMapSgowing = false;
  double _rating;

  final _formKey = GlobalKey<FormState>();
  final _reveiwController = TextEditingController();
  bool _isTabStar = false;

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    final _portfolioData = serviceProvider.portfolioData;
    final _reportDetail = _portfolioData.report;
    RangeValues _currentRangeValues = const RangeValues(200000000, 600000000);
    String _priceRange = '';

    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              children: [
                Expanded(
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 87,
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFF407BFF).withOpacity(0.22),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                            _portfolioData.type == "invest"
                                ? "Co-owned"
                                : _portfolioData.type == "sale"
                                ? "Owned"
                                : _portfolioData.type == "rent"
                                ? "Rented"
                                : _portfolioData.type,
                            style: st36C5F0500Rubik12),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5, top: 7),
                        child: Text(_portfolioData.propertyAddress,
                            style: st535353700Rubuk12),
                      ),
                      Text(
                        '${_portfolioData.state}, NO ${_portfolioData.zipcode}',
                        style: st535353400Rubik12,
                      ),
                    ],
                  )),
                ),
                const SizedBox(width: 10),
                // Spacer(),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: Row(
            //     children: [
            //       //TODO::: complete here with right data
            //       _fragRoiInvestor('AVAILABLE FRAG',
            //           '${_portfolioData.report.avaialableFrags}'),
            //       const SizedBox(width: 30),
            //       _fragRoiInvestor('ROI', '${_portfolioData.roi}% p.a'),
            //       const SizedBox(width: 30),
            //       _fragRoiInvestor(
            //           'INVESTORS', '${_portfolioData.report.investors}'),
            //     ],
            //   ),
            // ),

            _portfolioData.type == 'invest'
                ? Row(
                    children: [
                      Text('${_portfolioData.report.invested} Frag',
                          style: st07C168600Rubik24)
                    ],
                  )
                : Row(
                    children: [
                      // Text(
                      //   '₦',
                      //   style: TextStyle(fontSize: 13, fontFamily: ""),
                      // ),
                      Text(
                          _portfolioData.type == 'sale'
                              ? '₦${_portfolioData.costPrice}'
                              : _portfolioData.type == 'rent'
                                  ? '₦${_portfolioData.costPrice}'
                                  : '₦${_portfolioData.costPrice} per frag',
                          style: st07C168600Rubik24.copyWith(
                            fontFamily: ""
                          )),
                    ],
                  ),

            if (_portfolioData.type == 'rent')
              PropertyDateDetails(
                  _reportDetail.startDate,
                  '${_reportDetail.daysLeft}',
                  _reportDetail.endDate,
                  _reportDetail.duration),

            if (_portfolioData.type == 'invest')
              Column(
                children: [
                  // LineIndicatorWidget(
                  //     _reportDetail.startDate,
                  //     _reportDetail.currentDate,
                  //     _reportDetail.currentWorthOfInv,
                  //     _reportDetail.endDate,
                  //     _reportDetail.currentNetYieldPercentage),
                  PropertyDateDetails2(
                    fragPrice: _portfolioData.fragPrice,
                    roi: _portfolioData.roi,
                    investors: _portfolioData.report.investors,
                    estNetYield: _reportDetail.estNetYield,
                    initialCapital: _portfolioData.report.initialCapital,
                    percent: _portfolioData.report.currentNetYieldPercentage,
                    currentWorthOfInv: _portfolioData.report.currentWorthOfInv,
                    startDate: _reportDetail.startDate,
                    endDate: _reportDetail.currentDate,
                    availableFrags: _reportDetail.avaialableFrags,
                  )
                ],
              ),

            const SizedBox(height: 20),
            Text('Description', style: st0C0932700Rubik12),
            const SizedBox(height: 10),
            ReadMoreWidget(
              false,
              describption: _portfolioData.propertyDescription,
            ),
            const SizedBox(height: 26),
            FewPropertyDetailWidget(_portfolioData.propertyFeatures),
            const SizedBox(height: 26),

            // RangeSlider(
            //   values: _currentRangeValues,
            //   min: 1,
            //   // max: 1000000,
            //   max: 1000000000,
            //   divisions: 1000000000,
            //   activeColor: kc3DED97,
            //   inactiveColor: Color(0xffd4d4d4),
            //   labels: RangeLabels(
            //     _currentRangeValues.start.round().toString(),
            //     _currentRangeValues.end.round().toString(),
            //   ),
            //   onChanged: (RangeValues values) {
            //     setState(() {
            //       _currentRangeValues = values;
            //       _priceRange =
            //           '${_currentRangeValues.start.toStringAsFixed(0)}-${_currentRangeValues.end.toStringAsFixed(0)}';
            //       // print(_currentRangeValues.start);
            //       // print(_currentRangeValues.end);
            //       // print(_priceRange);
            //     });
            //   },
            // ),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('1', style: st535353400Rubik14),
            //       Text('1,000,000,000', style: st535353400Rubik14)
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            if (_portfolioData.type == 'rent')
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // _portfolioData.status == '0'
                  //     ? customButton('Cancel Rent', () {})
                  //     : portfolioCustomButton('Renew Rent', () {})

                  customButton('Forfeit', () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PorfolioDialog(
                            title: 'Forfeit Rent',
                            operationType: 'Forfeit',
                            content:
                                "You won't get any rent compensation when you forfeit your rent.  Are you sure you want to forfeit your rent?",
                            operationCallback: () {
                              Navigator.pop(context);
                              _showPinMoedal(_portfolioData.portfolioId);
                            },
                          );
                        });
                  },
                      width: MediaQuery.of(context).size.width * 0.41,
                      color: Colors.black),
                  customButton('Renew', () async {
                    // await _showPinMoedal(_portfolioData.portfolioId);
                    await getIt
                        .get<PortfolioVm>()
                        .setPortfolioMap(id: _portfolioData.id);
                    Navigator.of(context).pushNamed(RenewRentScreen.routeName);
                  }, width: MediaQuery.of(context).size.width * 0.41),
                ],
              ),
            Container(),
            if (_portfolioData.type == 'sale')
              customButton('Sell Property', () async {
                await getIt.get<PortfolioVm>().setPortfolioMap(
                    id: _portfolioData.portfolioId,
                    token: _portfolioData.tokenId);

                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return SellPropertyScreen();
                // }));
                return showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                          // color: Colors.blue,
                          // alignment: Alignment.bottomCenter,
                          // margin: EdgeInsets.only(top: 100),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 16),
                          height: 357,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          child: SellPropertyScreen());
                      // SellPropertyScreen();
                    });
              }),
            if (_portfolioData.type == 'invest')
              customButton('Sell Frags', () async {
                await getIt.get<PortfolioVm>().setPortfolioMap(
                    id: _portfolioData.portfolioId,
                    investedFrag: _portfolioData.report.invested,
                    pricePerFrag: _portfolioData.fragPrice);

                // Navigator.of(context).pushNamed(SellAssetsScreen.routeName);
                return showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          height: 349,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          child: SellAssetsScreen());
                    });
              }),
            SizedBox(
              height: 10,
            ),

            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5, color: Color(0xFFBDBDBD))),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Property Location",
                        style: TextStyle(
                          color: Color(0xFF0C0932),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ShowGoogleMap(
                      lat: double.parse(_portfolioData.latCoordinate.trim()),
                      log: double.parse(_portfolioData.longCoordinate.trim()),
                    ),
                  ],
                )),
            // Container(
            //     child: Image.asset(
            //   imgMap,
            //   fit: BoxFit.fill,
            // )),

            // SizedBox(height: 24),
            // Row(
            //   children: [
            //     Text('Property Reviewa', style: st0C0932700Rubik12),
            //     Spacer(),
            //     Text(
            //       '300,000 Reviews',
            //       style: stFFC327400Rubik12.copyWith(color: kc0C0932),
            //     )
            //   ],
            // ),
            // SizedBox(height: 12),
            // //TODO::: Implemet latter
            // FewPropertyReviewWidget(),
            // SizedBox(height: 10),
            // GestureDetector(
            //   onTap: () {
            //     ///TOTDO::: Route here
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text('View all reviews',
            //           style: stFFC327400Rubik12.copyWith(color: kc0C0932)),
            //       Icon(
            //         Icons.east,
            //         size: 20,
            //         color: kc0C0932,
            //       )
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 30),
            // if (_portfolioData.type == 'sale')
            //   customButton(
            //       'Buy Property',
            //       () => Navigator.of(context)
            //           .pushNamed(SalePaymentScreen.routeName)),
            // if (_portfolioData.type == 'rent')
            //   customButton(
            //       'Rent Property',
            //       () => Navigator.of(context)
            //           .pushNamed(RentingPaymentScreen.routeName)),
            // if (_portfolioData.type == 'invest')
            //   customButton(
            //       'Invest',
            //       () => Navigator.of(context)
            //           .pushNamed(InvestPaymentScreen.routeName)),
            // const SizedBox(height: 30),

            // Text('Similar Propertoes', style: st0C0932700Rubik12),
            // PortfolioWidget(scrowable: false, isShowAll: true)

            // /TODO:: FOR PORTFOLIO
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rate this Property', style: st0C0932700Rubik12),
                        Text('Tell others what you think',
                            style: st000000400Rubik12),
                      ],
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        if (!_isTabStar) {
                          flushbarWidget(
                              context, 'Tap star to rate the property', false);
                        } else {
                          _postReviw('${_portfolioData.id}');
                        }
                      },
                      child: Text('POST REVIEW', style: st3DED97400Rubik12),
                    )
                  ],
                ),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  unratedColor: kcC4C4C4.withOpacity(0.5),
                  itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: kc3DED97,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                      _isTabStar = true;
                    });
                    print(rating);
                  },
                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _reveiwController,
                    maxLines: 5,
                    maxLength: 50,
                    style: textfieldStyle,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide.none),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Color(0xFFF4F4F4).withOpacity(0.9),
                        hintText: 'Describe your experience'),
                    validator: (va) {
                      if (va.isEmpty) {
                        return 'Please Describe your experience';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _showPinMoedal(int id) {
    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return SecurityPinWidget(
    //         operationType: 'forfeit',
    //         id: id,
    //       );
    //     });
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            child: SecurityPinWidget(
              operationType: 'forfeit',
            ),
          );
        });
  }

  Widget _fragRoiInvestor(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: st949494700Ralew12),
        Text(data, style: st0000000500Rubik14)
      ],
    );
  }

  _postReviw(String propertyId) async {
    if (_formKey.currentState.validate()) {
      EasyLoading.show(status: 'Posting your review');
      var response = await PostServices.creatReview(
          context, propertyId, _reveiwController.text, '$_rating');

      if (response is LogSucess) {
        EasyLoading.dismiss();
        flushbarWidget(context, response.message, false);
      } else {
        EasyLoading.dismiss();
        flushbarWidget(context, (response as LogFailure).errorMessage, false);
      }
    }
  }
}
