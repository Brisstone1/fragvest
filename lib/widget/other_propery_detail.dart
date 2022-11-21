import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/screens/payment/invest_payment_screen.dart';
import 'package:fragvest_mobile/screens/payment/rent_payment_screen.dart';
import 'package:fragvest_mobile/screens/payment/sele_payment.dart';
import 'package:fragvest_mobile/screens/watchlist/complete_review/property_complete_review.dart';
import 'package:fragvest_mobile/screens/tour/tour_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/read_more_widget.dart';
import 'package:fragvest_mobile/widget/show_google_map.dart';
import 'availble_property_widget.dart';
import 'custom_button_widget.dart';
import 'few_property_detail_widget.dart';
import 'watchlist_widget/few_property_main_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'property_tour_buttons.dart';

class OtherPropertyDetails extends StatefulWidget {
  @override
  _OtherPropertyDetailsState createState() => _OtherPropertyDetailsState();
}

class _OtherPropertyDetailsState extends State<OtherPropertyDetails> {
  bool _isMapSgowing = false;

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    final _propertyDetial = serviceProvider.propertyData;

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
                      decoration: BoxDecoration(
                          color: Color(0xFF407BFF).withOpacity(0.22),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                          _propertyDetial.type == "invest"
                              ? "Co-own"
                              : _propertyDetial.type == "rent"
                                  ? "For Rent"
                                  : "For ${_propertyDetial.type}",
                          style: st36C5F0500Rubik12),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(_propertyDetial.propertyAddress,
                        style: TextStyle(
                            color: Color(0xFF0C0932),
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${_propertyDetial.state}, NO ${_propertyDetial.zipcode}',
                      style: st535353400Rubik12,
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // if (_propertyDetial.type != 'invest')
              Container(
                // margin: EdgeInsets.symmetric(vertical: 24),
                // color: Colors.red,
                child: Row(
                  children: [
                    Text('₦',
                        style: TextStyle(
                            fontFamily: "",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF07C168))),
                    Text(
                        _propertyDetial.type == 'invest'
                            ? '${_propertyDetial.fragPrice}'
                            : '${_propertyDetial.costPrice}',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF07C168))),
                  ],
                ),
              ),
            // const SizedBox(height: 20),
            if (_propertyDetial.type == 'invest')
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //TODO::: complete here with right data
                        _fragRoiInvestor(
                            'Frag Price', _propertyDetial.fragPrice),
                        const SizedBox(width: 30),
                        _fragRoiInvestor(
                            'ROI', '${_propertyDetial.roi}% per annum'),
                        const SizedBox(width: 30),
                        _fragRoiInvestor('Co-owners',
                            _propertyDetial.propertyStats.investors),


                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // _fragRoiInvestor('EST. Net Yield',
                        //     _propertyDetial.estNetYield),
                        // const SizedBox(width: 30),
                        _fragRoiInvestor('Available Frag',
                            _propertyDetial.propertyStats.availableFrags),
                        const SizedBox(width: 30),
                      ],
                    ),

                    ///TODO:: FOR PORTFOLIO
                    // LineIndicatorWidget(),
                  ],
                ),
              ),

            //TODO:: FOR PORTFOLIO
            // PropertyDateDetails(),
            const SizedBox(height: 32),
            Text('Description', style: st0C0932700Rubik12),
            const SizedBox(height: 10),
            ReadMoreWidget(
              false,
              describption: _propertyDetial.propertyDescription,
            ),
            FewPropertyDetailWidget(_propertyDetial.propertyFeatures),
            const SizedBox(height: 10),
            // Navigator.of(context)
            //     .pushNamed(SalePaymentScreen.routeName)),
            if (_propertyDetial.type == 'rent')
              customButton(
                  'Rent Property',
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RentingPaymentScreen(
                          _propertyDetial.costPrice,
                          _propertyDetial.id,
                          _propertyDetial.tokenId,
                          _propertyDetial.fragPrice)))),

            if (_propertyDetial.type == 'invest')
              customButton(
                  'Buy Frags',
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InvestPaymentScreen(
                          _propertyDetial.costPrice,
                          _propertyDetial.fragPrice,
                          _propertyDetial.tokenId,
                          _propertyDetial.id)))),

            if (_propertyDetial.type == 'sale')
              customButton(
                  'Buy Property',
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SalePaymentScreen(
                          _propertyDetial.costPrice,
                          _propertyDetial.id,
                          _propertyDetial.tokenId,
                          _propertyDetial.fragPrice)))),
            const SizedBox(height: 10),

            ///TODO:: Link to their diff screen
            if (_propertyDetial.type != 'invest')
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
                              _propertyDetial
                                  .propertyAgent.availability.availableDate,
                              _propertyDetial
                                  .propertyAgent.availability.availableTime,
                              _propertyDetial.propertyAgent.email,
                              _propertyDetial.propertyAgent.phone,
                              _propertyDetial.id)))),
                  Spacer(),
                  conainerButton(
                      context, 'Call Manager', Icons.call, 0.4, kc407BFF, () {
                    _callNumber(_propertyDetial.propertyAgent.phone);
                  }),
                ],
              ),
            SizedBox(height: 24),

            // Column(
            //   children: [
            //     conainerButton(
            //         context, 'Call Manager', Icons.call, 0.7, kc3DED97, () {
            //       _callNumber(_propertyDetial.propertyAgent.phone);
            //     }),
            //     const SizedBox(height: 15),
            //     Row(
            //       children: [
            //         conainerButton(
            //             context,
            //             'Schedule a Physical Tour',
            //             Icons.explore,
            //             0.5,
            //             kc6C63FF,
            //             () => Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (context) => TourScreen(
            //                     _propertyDetial
            //                         .propertyAgent.availability.availableDate,
            //                     _propertyDetial
            //                         .propertyAgent.availability.availableTime,
            //                     _propertyDetial.propertyAgent.email,
            //                     _propertyDetial.propertyAgent.phone,
            //                     _propertyDetial.id)))),
            //         Spacer(),
            //         conainerButton(context, 'Virtual Tour',
            //             Icons.local_convenience_store, 0.4, kcFFC327, () {})
            //       ],
            //     ),
            //   ],
            // ),

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
                      lat: double.parse(_propertyDetial.latCoordinate.trim()),
                      log: double.parse(_propertyDetial.longCoordinate.trim()),
                    ),
                  ],
                )),
            // ShowGoogleMap(
            //   lat: double.parse(_propertyDetial.latCoordinate.trim()),
            //   log: double.parse(_propertyDetial.longCoordinate.trim()),
            // ),
            // Container(
            //     child: Image.asset(
            //   imgMap,
            //   fit: BoxFit.fill,
            // )),

            SizedBox(height: 24),
            Row(
              children: [
                Text('Property Reviews', style: st0C0932700Rubik12),
                Spacer(),
                Text(
                  '${_propertyDetial.reviews.length} Reviews',
                  style: stFFC327400Rubik12.copyWith(color: kc0C0932),
                )
              ],
            ),
            SizedBox(height: 12),
            //TODO::: Implemet latter
            _propertyDetial.reviews.length == 0
                ? Text('No review yet!')
                : FewPropertyMainReviewWidget(),

            if (_propertyDetial.reviews.length > 0)
              Column(
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      ///TOTDO::: Route here
                      Navigator.of(context)
                          .pushNamed(PropertCompleteReview.routeName);
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

  _makeCall(String pho) async {
    if (await canLaunch(pho)) {
      await launch(pho);
    } else {
      throw 'dkfdjgdfkjgdf fvmfd ';
    }
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
