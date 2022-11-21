import 'package:flutter/material.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/property_complete_review_widget.dart';
import 'package:provider/provider.dart';

class CompletePropertyTrendingReview extends StatelessWidget {
  static const routeName = '/complete-trending-review';
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    Properties _selectedtrending = serviceProvider.selectedTrending;
    return Scaffold(
      appBar: customAppBar('Neighbourhood Reviews', false),
      body: ListView.builder(
          itemCount: _selectedtrending.reviews.length,
          itemBuilder: (context, index) {
            final reviewsData = _selectedtrending.reviews[index];
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
