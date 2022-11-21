import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/constants/string_format.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart' as dash;
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/screens/complete_trending_property_review.dart';
import 'package:fragvest_mobile/screens/payment/invest_payment_screen.dart';
import 'package:fragvest_mobile/screens/payment/rent_payment_screen.dart';
import 'package:fragvest_mobile/screens/payment/sele_payment.dart';
import 'package:fragvest_mobile/screens/tour/tour_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/property_date_detail2.dart';
import 'package:fragvest_mobile/widget/read_more_widget.dart';
import 'package:fragvest_mobile/widget/show_google_map.dart';
import '../../availble_property_widget.dart';
import '../../custom_button_widget.dart';
import '../../few_property_detail_widget.dart';
import 'few_trending_property_review.dart';

import 'package:provider/provider.dart';

import '../../property_tour_buttons.dart';

class OtherTrendingPropertyDetails extends StatefulWidget {
  @override
  _OtherTrendingPropertyDetailsState createState() =>
      _OtherTrendingPropertyDetailsState();
}

class _OtherTrendingPropertyDetailsState
    extends State<OtherTrendingPropertyDetails> {
  bool _isMapSgowing = false;

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    dash.Properties _selectedtrending = serviceProvider.selectedTrending;

    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 87,
                      height: 25,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 23),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF407BFF).withOpacity(0.22),
                      ),
                      child: Text(
                          _selectedtrending.type == "invest"
                              ? "Co-own"
                              : _selectedtrending.type,
                          style: st36C5F0500Rubik12),
                    ),

                    Container(
                      // alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10),
                      //   color: Color(0xFF407BFF).withOpacity(0.3),
                      // ),

                      child: Text(_selectedtrending.propertyAddress,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0C0932))),
                    ),

                    // Text(_selectedtrending.propertyAddress,
                    //     style: st535353700Rubuk12),
                    Text(
                      '${_selectedtrending.state}, NO ${_selectedtrending.zipcode}',
                      style: st535353400Rubik12,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _selectedtrending.type == 'invest'
                          //     ? Text('FRAG PRICE',
                          //     style:
                          //     stFFC327400Rubik12.copyWith(color: kc2F54C6))
                          //     : Text(
                          //     'for ${_selectedtrending.type.toCapitalized()}',
                          //     style: stFFC327400Rubik12.copyWith(
                          //         color: _selectedtrending.type == 'sale'
                          //             ? kc00AA57
                          //             : kcFFC327)),
                        ],
                      ),
                    ),
                  ],
                )),
                // Spacer(),
              ],
            ),
            // if (_selectedtrending.type != 'invest')
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    Text('₦',
                        style: TextStyle(
                            fontFamily: "",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF07C168))),
                    Text(
                        _selectedtrending.type == 'invest'
                            ? '${_selectedtrending.fragPrice}'
                            : '${_selectedtrending.costPrice}',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF07C168))),
                  ],
                ),
              ),
            if (_selectedtrending.type == 'invest')
              // PropertyDateDetails2(fragPrice: _selectedtrending.fragPrice, roi: _selectedtrending.roi, investors: _selectedtrending.propertyStats.investors,
              //     estNetYield: _selectedtrending.es,
              //     initialCapital: initialCapital, percent: percent, currentWorthOfInv: currentWorthOfInv, startDate: startDate, endDate: _selectedtrending.e, availableFrags: _selectedtrending.propertyStats.availableFrags)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //TODO::: complete here with right data
                        _fragRoiInvestor('Available Frag',
                            '${_selectedtrending.propertyStats.availableFrags}'),
                        const SizedBox(width: 30),
                        _fragRoiInvestor(
                            'ROI', '${_selectedtrending.roi}% per annum'),
                        const SizedBox(width: 30),
                        _fragRoiInvestor('Co-owners',
                            '${_selectedtrending.propertyStats.investors}'),
                      ],
                    ),

                    ///TODO:: FOR PORTFOLIO
                    // LineIndicatorWidget(),
                  ],
                ),
              ),

            //TODO:: FOR PORTFOLIO
            // PropertyDateDetails(),
            const SizedBox(height: 20),
            Text('Description', style: st0C0932700Rubik12),
            const SizedBox(height: 10),
            ReadMoreWidget(
              false,
              describption: _selectedtrending.propertyDescription,
            ),
            const SizedBox(height: 26),
            if (_selectedtrending.type == 'sale')
              customButton(
                  'Buy Property',
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SalePaymentScreen(
                          _selectedtrending.costPrice,
                          _selectedtrending.id,
                          _selectedtrending.tokenId,
                          _selectedtrending.fragPrice)))),
            if (_selectedtrending.type == 'rent')
              customButton(
                  'Rent Property',
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RentingPaymentScreen(
                          _selectedtrending.costPrice,
                          _selectedtrending.id,
                          _selectedtrending.tokenId,
                          _selectedtrending.fragPrice)))),

            if (_selectedtrending.type == 'invest')
              customButton(
                  'Buy Frags',
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InvestPaymentScreen(
                          _selectedtrending.costPrice,
                          _selectedtrending.fragPrice,
                          _selectedtrending.tokenId,
                          _selectedtrending.id)))),
            SizedBox(height: 12),

            ///TODO:: Link to their diff screen
            if (_selectedtrending.type != 'invest')
              Row(
                children: [
                  conainerButton(
                    context,
                    'Schedule a Physical Tour',
                    Icons.explore,
                    0.5,
                    kc6C63FF,
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TourScreen(
                            _selectedtrending
                                .propertyAgent.availability.availableDate,
                            _selectedtrending
                                .propertyAgent.availability.availableTime,
                            _selectedtrending.propertyAgent.email,
                            _selectedtrending.propertyAgent.phone,
                            _selectedtrending.id))),
                  ),
                  Spacer(),
                  conainerButton(
                      context, 'Call Manager', Icons.call, 0.4, kc407BFF, () {
                    _callNumber(_selectedtrending.propertyAgent.phone);
                  }),
                ],
              ),
            SizedBox(height: 24),
            // Column(
            //   children: [
            //     Center(
            //       child: conainerButton(
            //           context, 'Call Manager', Icons.call, 0.7, kc3DED97, () {
            //         _callNumber(_selectedtrending.propertyAgent.phone);
            //       }),
            //     ),
            //     const SizedBox(height: 15),
            //     Row(
            //       children: [
            //         conainerButton(
            //           context,
            //           'Schedule a Physical Tour',
            //           Icons.explore,
            //           0.5,
            //           kc6C63FF,
            //           () => Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) => TourScreen(
            //                   _selectedtrending
            //                       .propertyAgent.availability.availableDate,
            //                   _selectedtrending
            //                       .propertyAgent.availability.availableTime,
            //                   _selectedtrending.propertyAgent.email,
            //                   _selectedtrending.propertyAgent.phone,
            //                   _selectedtrending.id))),
            //         ),
            //         Spacer(),
            //         conainerButton(context, 'Virtual Tour',
            //             Icons.local_convenience_store, 0.4, kcFFC327, () {})
            //       ],
            //     ),
            //   ],
            // ),

            // Container(
            //     child: Image.asset(
            //   imgMap,
            //   fit: BoxFit.fill,
            // )),
            FewPropertyDetailWidget(_selectedtrending.propertyFeatures),
            SizedBox(height: 24),

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
                      lat: double.parse(_selectedtrending.latCoordinate.trim()),
                      log:
                          double.parse(_selectedtrending.longCoordinate.trim()),
                    ),
                  ],
                )),

            SizedBox(height: 50),
            Row(
              children: [
                Text('Property Reviews', style: st0C0932700Rubik12),
                Spacer(),
                Text(
                  '${_selectedtrending.reviews.length} Reviews',
                  // '300,000 Reviews',
                  style: stFFC327400Rubik12.copyWith(color: kc0C0932),
                )
              ],
            ),
            SizedBox(height: 12),
            //TODO::: Implemet latter
            _selectedtrending.reviews.length == 0
                ? Text('No review yet!')
                : FewPropertyTrendingReviewWidget(),
            if (_selectedtrending.reviews.length > 0)
              Column(
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CompletePropertyTrendingReview.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('View all reviews',
                            style:
                                stFFC327400Rubik12.copyWith(color: kc0C0932)),
                        Icon(
                          Icons.east,
                          size: 20,
                          color: kc0C0932,
                        )
                      ],
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 30),
            // Row(
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Rate this Property', style: st0C0932700Rubik12),
            //         Text('Tell others what you think',
            //             style: st000000400Rubik12),
            //       ],
            //     ),
            //     Spacer(),
            //     TextButton(
            //       onPressed: () {
            //         // if (!_isTabStar) {
            //         //   flushbarWidget(context,
            //         //       'Tap star to rate the property', false);
            //         // } else {
            //         //   _postReviw('${widget.portfolio.id}');
            //         // }
            //       },
            //       child: Text('POST REVIEW', style: st3DED97400Rubik12),
            //     )
            //   ],
            // ),

            const SizedBox(height: 30),

            Text('Similar Properties', style: st0C0932700Rubik12),
            AvailablePropertyWidget(scrowable: false, isShowAll: true)

            ///TODO:: FOR PORTFOLIO
            // SizedBox(height: 20),
            // Column(
            //   children: [
            //     Row(
            //       children: [
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text('Rate this Property', style: st0C0932700Rubik12),
            //             Text('Tell others what you think',
            //                 style: st000000400Rubik12),
            //           ],
            //         ),
            //         Spacer(),
            //         MaterialButton(
            //           onPressed: () {},
            //           child: Text('POST REVIEW', style: st3DED97400Rubik12),
            //         )
            //       ],
            //     ),
            //     SizedBox(height: 10),
            //     RatingBar.builder(
            //       initialRating: 3,
            //       minRating: 1,
            //       direction: Axis.horizontal,
            //       allowHalfRating: true,
            //       itemCount: 5,
            //       unratedColor: kcC4C4C4.withOpacity(0.5),
            //       itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
            //       itemBuilder: (context, _) => Icon(
            //         Icons.star,
            //         color: kc3DED97,
            //       ),
            //       onRatingUpdate: (rating) {
            //         print(rating);
            //       },
            //     ),
            //     SizedBox(height: 10),
            //     TextField(
            //       maxLines: 5,
            //       maxLength: 50,
            //       decoration: InputDecoration(
            //           focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(5)),
            //               borderSide: BorderSide.none),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(5)),
            //           ),
            //           filled: true,
            //           fillColor: Color(0xFFF4F4F4).withOpacity(0.9),
            //           hintText: 'Describe your experience (Optional)'),
            //     ),
            //   ],
            // ),
            // Container(
            //   alignment: Alignment.center,
            //   height: 45,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     border: Border.all(color: kc3DED97),
            //   ),
            //   child: Text('Sell Asset', style: st3DED97500Rubik18),
            // ),
          ],
        ),
      ),
    );
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
}

_callNumber(String number) async {
  // const number = '08101895306'; //set the number here
  bool res = await FlutterPhoneDirectCaller.callNumber(number);
}
