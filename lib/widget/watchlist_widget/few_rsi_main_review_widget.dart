import 'package:flutter/material.dart';
import 'package:fragvest_mobile/widget/few_property_reveiw_widget.dart';
import 'package:fragvest_mobile/model/property_by_type_model.dart' as ris;

class FewRISMainReviewWidget extends StatelessWidget {
  final List<ris.Reviews> reviews;

  const FewRISMainReviewWidget({Key key, @required this.reviews})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 160,
      color: Colors.grey.withOpacity(0.06),
      child: ListView.builder(
          itemCount: reviews.take(5).length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final reviewsData = reviews[index];
            return FewPropertyReviewWidget(
                imageUrl: reviewsData.user.profileImg,
                firstName: reviewsData.user.firstName,
                date: reviewsData.date,
                message: reviewsData.message,
                star: reviewsData.stars);
          }),
    );
  }
}
