import 'package:flutter/material.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/property_complete_review_widget.dart';
import 'package:fragvest_mobile/model/watch_list_model.dart';

class CompleteCompleteReview extends StatelessWidget {
  final List<Reviews> reviews;

  const CompleteCompleteReview({Key key, @required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
