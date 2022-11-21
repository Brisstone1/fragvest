import 'package:flutter/material.dart';
import 'package:fragvest_mobile/model/watch_list_model.dart' as watch;
import 'package:fragvest_mobile/widget/few_property_reveiw_widget.dart';

class WatchListMainReviewWidget extends StatelessWidget {
  final List<watch.Reviews> watchList;

  const WatchListMainReviewWidget({Key key, @required this.watchList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 160,
      color: Colors.grey.withOpacity(0.06),
      child: ListView.builder(
          itemCount: watchList.take(5).length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final reviewsData = watchList[index];
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
