import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

import 'dommy_avater_widget.dart';

class FewPropertyReviewWidget extends StatelessWidget {
  final String imageUrl;
  final String firstName;
  final String date;
  final String message;
  final String star;

  const FewPropertyReviewWidget(
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
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          // color: kcWhite,
          borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: Color(0xFFBDBDBD))
      ),

      width: MediaQuery.of(context).size.width * 0.6,
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
          SizedBox(height: 10),
          Expanded(
            child: Text(
              message,
              style: st535353400Rubik12,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.5, color: kc535353)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(star),
                    Icon(
                      Icons.emoji_emotions,
                      color: Colors.amber,
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
