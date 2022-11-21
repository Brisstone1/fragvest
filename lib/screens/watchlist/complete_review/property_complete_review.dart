import 'package:flutter/material.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/property_complete_review_widget.dart';
import 'package:provider/provider.dart';

class PropertCompleteReview extends StatelessWidget {
  static const routeName = '/property-complete-review';
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    final _propertyDetial = serviceProvider.propertyData;
    // print('The addrees ${_propertyDetial.propertyAddress}');
    return Scaffold(
      appBar: customAppBar('Neighbourhood Reviews', false),
      body: ListView.builder(
          itemCount: _propertyDetial.reviews.length,
          itemBuilder: (context, index) {
            final reviewsData = _propertyDetial.reviews[index];
            return PropertyCompleteReviewWidget(
                imageUrl: reviewsData.user.profileImg,
                firstName: reviewsData.user.firstName,
                date: reviewsData.date,
                message: reviewsData.message,
                star: reviewsData.stars);
          }),
    );
  }
}
