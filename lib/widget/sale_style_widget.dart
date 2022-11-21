import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class SaleStyleWidget extends StatelessWidget {
  final String type;
  final String price;
  final String tokenId;
  const SaleStyleWidget({Key key, this.type, this.price, this.tokenId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(tokenId, style: st535353500Rubik12),
            Spacer(),
            RichText(
              text: TextSpan(
                  text: '₦',
                  children: [
                    TextSpan(text: price, style: st535353500Rubik14
                        //  addCommaToString.format(int.parse(price))
                        ),
                  ],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kc535353)),
            )
          ],
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                  text: 'for ',
                  children: [TextSpan(text: type)],
                  style: stNormal13.copyWith(color: kc00AA57)),
            ),
          ],
        ),
      ],
    );
  }
}

class PortfolioSaleStyleWidget extends StatelessWidget {
  final String type;
  final String price;
  final String tokenId;
  const PortfolioSaleStyleWidget({Key key, this.type, this.price, this.tokenId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(tokenId, style: st535353500Rubik12),
            Spacer(),
            RichText(
              text: TextSpan(
                  text: '₦',
                  children: [
                    TextSpan(text: price, style: st535353500Rubik14),
                  ],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kc535353)),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Owned',
            style: stNormal13.copyWith(color: kc00AA57),
          ),
        ),
      ],
    );
  }
}
