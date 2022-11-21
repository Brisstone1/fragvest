import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class RentStyleWidget extends StatelessWidget {
  final String type;
  final String price;
  final String tokenId;
  final String propertyTpye;
  const RentStyleWidget(
      {Key key, this.type, this.price, this.tokenId, this.propertyTpye})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(tokenId, style: st535353500Rubik12),
            Spacer(),
            Text(
              propertyTpye,
              style: st2F54C6400Rubik18,
            ),
          ],
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                  text: 'for ',
                  children: [TextSpan(text: type)],
                  style: stNormal13.copyWith(color: kcFFC327)),
            ),
            Spacer(),
            RichText(
              text: TextSpan(
                  text: '₦',
                  children: [
                    TextSpan(text: price),
                  ],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kc535353)),
            )
          ],
        ),
      ],
    );
  }
}

class PortfolioRentStyleWidget extends StatelessWidget {
  final String type;
  final String price;
  final String tokenId;
  final String propertyTpye;
  const PortfolioRentStyleWidget(
      {Key key, this.type, this.price, this.tokenId, this.propertyTpye})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(tokenId, style: st535353500Rubik12),
            Spacer(),
            Text(
              propertyTpye,
              style: st2F54C6400Rubik18,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Rented',
              style: stNormal13.copyWith(color: kcFFC327),
            ),
            Spacer(),
            RichText(
              text: TextSpan(
                  text: '₦',
                  children: [
                    TextSpan(text: price),
                  ],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kc535353)),
            )
          ],
        ),
      ],
    );
  }
}
