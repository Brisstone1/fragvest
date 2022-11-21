import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
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
import '../../../model/dashboard_model.dart';
import '../../custom_button_widget.dart';
import '../../few_property_detail_widget.dart';
import '../../flush_bar_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';

class OtherDasboardPortfolioDetails extends StatefulWidget {
  final Portfolio portfolio;

  OtherDasboardPortfolioDetails({@required this.portfolio});
  @override
  _OtherDasboardPortfolioDetailsState createState() =>
      _OtherDasboardPortfolioDetailsState();
}

class _OtherDasboardPortfolioDetailsState
    extends State<OtherDasboardPortfolioDetails> {
  bool _isMapSgowing = false;
  double _rating;

  final _formKey = GlobalKey<FormState>();
  final _reveiwController = TextEditingController();
  bool _isTabStar = false;

  @override
  Widget build(BuildContext context) {

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
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: Color(0xFF407BFF).withOpacity(0.22),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                            widget.portfolio.type == "invest"
                                ? "Co-owned"
                                : widget.portfolio.type == "sale"
                                    ? "Owned"
                                    : widget.portfolio.type == "rent"
                                        ? "Rented"
                                        : widget.portfolio.type,
                            style: st36C5F0500Rubik12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(widget.portfolio.propertyAddress,
                            style: TextStyle(
                                color: Color(0xFF0C0932),
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                      Text(
                        '${widget.portfolio.state}, NO ${widget.portfolio.zipcode}',
                        style: st535353400Rubik12,
                      ),
                    ],
                  )),
                ),
                const SizedBox(width: 10),
                // Spacer(),
                Container(
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //     widget.portfolio.type == 'rent'
                      //         ? 'Rented'
                      //         : widget.portfolio.type == 'sale'
                      //             ? 'Owned'
                      //             : 'Invested',
                      //     style: stFFC327400Rubik12.copyWith(
                      //         color: widget.portfolio.type == 'sale'
                      //             ? kc00AA57
                      //             : widget.portfolio.type == 'rent'
                      //                 ? kcFFC327
                      //                 : kc2F54C6)),
                      // widget.portfolio.type == 'invest'
                      //     ? Row(
                      //         children: [
                      //           Text('${widget.portfolio.report.invested} FRAG',
                      //               style: st535353500Rubik14)
                      //         ],
                      //       )
                      //     : Row(
                      //         children: [
                      //           Text(
                      //             '₦',
                      //             style:
                      //                 TextStyle(fontSize: 13, fontFamily: ""),
                      //           ),
                      //           Text(
                      //               widget.portfolio.type == 'sale'
                      //                   ? '${widget.portfolio.costPrice}'
                      //                   : widget.portfolio.type == 'rent'
                      //                       ? '${widget.portfolio.costPrice}'
                      //                       : '${widget.portfolio.costPrice} p.f',
                      //               style: st535353500Rubik14),
                      //         ],
                      //       ),
                    ],
                  ),
                ),
              ],
            ),
            // if (widget.portfolio.type == 'invest')
            //   Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 20),
            //     child: Row(
            //       children: [
            //         //TODO::: complete here with right data
            //         _fragRoiInvestor('AVAILABLE FRAG',
            //             '${widget.portfolio.report.avaialableFrags}'),
            //         const SizedBox(width: 30),
            //         _fragRoiInvestor('ROI', '${widget.portfolio.roi}% p.a'),
            //         const SizedBox(width: 30),
            //         _fragRoiInvestor(
            //             'INVESTORS', '${widget.portfolio.report.investors}'),
            //       ],
            //     ),
            //   ),
            // widget.portfolio.report.
            SizedBox(
              height: 20,
            ),
            widget.portfolio.type == 'invest'
                ? Row(
                    children: [
                      Text('${widget.portfolio.report.invested} Frag',
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
                          widget.portfolio.type == 'sale'
                              ? '₦${widget.portfolio.costPrice}'
                              : widget.portfolio.type == 'rent'
                                  ? '₦${widget.portfolio.costPrice}'
                                  : '₦${widget.portfolio.costPrice} per frag',
                          style: st07C168600Rubik24.copyWith(fontFamily: "")),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            if (widget.portfolio.type == 'invest')
              Column(
                children: [
                  Container(
                    // color: Colors.green,
                    child: PropertyDateDetails2(
                        fragPrice: widget.portfolio.fragPrice,
                        roi: widget.portfolio.roi,
                        investors: widget.portfolio.report.investors,
                        estNetYield: widget.portfolio.report.estNetYield,
                        initialCapital: widget.portfolio.report.initialCapital,
                        percent:
                            widget.portfolio.report.currentNetYieldPercentage,
                        currentWorthOfInv:
                            widget.portfolio.report.currentWorthOfInv,
                        startDate: widget.portfolio.report.startDate,
                        endDate: widget.portfolio.report.endDate,
                        availableFrags:
                            widget.portfolio.propertyStats.availableFrags),
                  ),
                  // LineIndicatorWidget(
                  //     widget.portfolio.report.startDate,
                  //     widget.portfolio.report.currentDate,
                  //     widget.portfolio.report.currentWorthOfInv,
                  //     widget.portfolio.report.endDate,
                  //     widget.portfolio.report.currentNetYieldPercentage),
                ],
              ),

            if (widget.portfolio.type == 'rent')
              PropertyDateDetails(
                  widget.portfolio.report.startDate,
                  '${widget.portfolio.report.daysLeft}',
                  widget.portfolio.report.endDate,
                  widget.portfolio.report.duration),
            if (widget.portfolio.type == 'invest') const SizedBox(height: 20),
            SizedBox(
              height: 10,
            ),
            Text('Description', style: st0C0932700Rubik12),
            const SizedBox(height: 10),
            ReadMoreWidget(
              false,
              describption: widget.portfolio.propertyDescription,
            ),
            const SizedBox(height: 10),
            FewPropertyDetailWidget(widget.portfolio.propertyFeatures),
            const SizedBox(height: 26),
            if (widget.portfolio.type == 'rent')
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // widget.portfolio.report.daysLeft == 0
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
                              _showPinMoedal();
                            },
                          );
                        });
                  },
                      width: MediaQuery.of(context).size.width * 0.41,
                      color: Colors.black),
                  customButton('Renew', () async {
                    await getIt
                        .get<PortfolioVm>()
                        .setPortfolioMap(id: widget.portfolio.id);
                    Navigator.of(context).pushNamed(RenewRentScreen.routeName);
                  }, width: MediaQuery.of(context).size.width * 0.41),
                ],
              ),
            Container(),
            if (widget.portfolio.type == 'sale')
              customButton('Sell Property', () async {
                await getIt.get<PortfolioVm>().setPortfolioMap(
                    id: widget.portfolio.portfolioId,
                    token: widget.portfolio.tokenId);

                return showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          height: 367,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          child: SellPropertyScreen());
                    });
                //
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SellPropertyScreen();
                  // return showMaterialModalBottomSheet()
                }));
              }),
            if (widget.portfolio.type == 'invest')
              customButton('Sell Asset', () async {
                await getIt.get<PortfolioVm>().setPortfolioMap(
                    id: widget.portfolio.portfolioId,
                    pricePerFrag: widget.portfolio.fragPrice,
                    investedFrag: widget.portfolio.report.invested);

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

            const SizedBox(height: 30),

            //TODO:: Implement later
            // MaterialButton(
            //   padding: const EdgeInsets.symmetric(horizontal: 0),
            //   onPressed: () => setState(() => _isMapSgowing = !_isMapSgowing),
            //   child: Row(
            //     children: [
            //       Text('Map View', style: st0C0932700Rubik12),
            //       Spacer(),
            //       Icon(!_isMapSgowing
            //           ? Icons.arrow_drop_down
            //           : Icons.arrow_drop_up)
            //     ],
            //   ),
            // ),
            // if (_isMapSgowing)
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
                      lat: double.parse(widget.portfolio.latCoordinate.trim()),
                      log: double.parse(widget.portfolio.longCoordinate.trim()),
                    ),
                  ],
                )),
            // ShowGoogleMap(
            //   lat: double.parse(
            //     widget.portfolio.latCoordinate.trim(),
            //   ),
            //   log: double.parse(widget.portfolio.longCoordinate.trim()),
            // ),

            // /TODO:: FOR PORTFOLIO
            if (widget.portfolio.type != 'sale')
              Column(
                children: [
                  SizedBox(height: 20),
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
                            flushbarWidget(context,
                                'Tap star to rate the property', false);
                          } else {
                            _postReviw('${widget.portfolio.id}');
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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

  _showPinMoedal() {
    // showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return SecurityPinWidget(
    //         operationType: 'forfeit',
    //         id: widget.portfolio.portfolioId,
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
