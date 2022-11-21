import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

import 'dommy_avater_widget.dart';

class PropertyCompleteReviewWidget extends StatelessWidget {
  final String imageUrl;
  final String firstName;
  final String date;
  final String message;
  final String star;

  const PropertyCompleteReviewWidget(
      {Key key,
      this.imageUrl,
      this.firstName,
      this.date,
      this.message,
      this.star})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      // width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        //
                        errorWidget: (context, url, error) => dummyAvater(),
                        // Icon(Icons.error),
                        fit: BoxFit.fill)),
              ),
              SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstName,
                    style: st535353700Rubik10,
                  ),
                  Text('Resident - $date', style: st535353400Rubik10)
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: st535353400Rubik12,
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Container(
                height: 30,
                // width: 60,
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.5, color: kc535353)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(star),
                    SizedBox(width: 4),
                    Icon(
                      Icons.emoji_emotions,
                      color: kc3DED97,
                      size: 18,
                    )
                  ],
                ),
              ),
              Spacer(),
              Text('Flag', style: st535353700Rubik10)
            ],
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
    );
  }
}
