import 'package:flutter/material.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/property_complete_review_widget.dart';
import 'package:fragvest_mobile/model/property_by_type_model.dart' as rsi;

class RSICompleteReview extends StatelessWidget {
  final List<rsi.Reviews> reviews;

  const RSICompleteReview({Key key, @required this.reviews}) : super(key: key);
  // static const routeName = '/rsi-complete-review';
  @override
  Widget build(BuildContext context) {
    // ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    // final _rsiData = serviceProvider.rsiData;
    // print('The addrees ${_propertyDetial.propertyAddress}');
    return Scaffold(
      appBar: customAppBar('Neighbourhood Reviews', false),
      body: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final reviewsData = reviews[index];
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
