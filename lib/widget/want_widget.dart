import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/screens/market/rent_sale_invest_filter_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class WantWidget extends StatelessWidget {
  const WantWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'What do you want?',
        //   style: st535353700Rubik16,
        // ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _wantWidget(context, imgPinkPana, 'Buy', 0),
            _wantWidget(context, imgBlueRafiki, 'Co-own', 1),
            _wantWidget(context, imgAmico1, 'Rent', 2)
          ],
        )
      ],
    );
  }

  Widget _wantWidget(
      BuildContext context, String image, String text, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RentSaleInvestFilterScreen(
              type: index == 0
                  ? 'sale'
                  : index == 1
                      ? 'invest'
                      : 'rent');
        }));
        // Navigator.of(context).pushNamed(RentSaleInvestFilterScreen.,
        //     arguments: index == 0
        //         ? 'sale'
        //         : index == 1
        //             ? 'invest'
        //             : 'rent');
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.28,
            height: 70,
            decoration: BoxDecoration(
              color: kc407BFF.withOpacity(0.40),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              image,
            ),
          ),
          SizedBox(height: 5),
          Text(text, style: st0C0932500Rubik16)
        ],
      ),
    );
  }
}
