import 'package:flutter/material.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/widget/few_property_reveiw_widget.dart';
import 'package:provider/provider.dart';
import '../few_property_reveiw_widget.dart';

class FewPropertyMainReviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    final _propertyDetial = serviceProvider.propertyData;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 160,
      color: Colors.grey.withOpacity(0.06),
      child: ListView.builder(
          itemCount: _propertyDetial.reviews.take(5).length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final reviewsData = _propertyDetial.reviews[index];
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
