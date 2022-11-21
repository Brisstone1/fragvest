import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestStyleWidget extends StatelessWidget {
  final String type;
  final String price;
  final String tokenId;
  final String rio;
  final String state;
  final String propertyType;
  const InvestStyleWidget(
      {Key key,
      this.type,
      this.propertyType,
      this.state,
      this.price,
      this.tokenId,
      this.rio})
      : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 8,),
        Container(

          margin: EdgeInsets.only(left: 10, top: 5),
          child: Text('${propertyType}',
              style: st535353500Rubik12),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
              state.contains('Abuja')
                  ? "Abuja FCT"
                  : state,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: kc0C0932
              )
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            '₦${price}',
            style: TextStyle(
                fontSize: 14,
                fontFamily: "",
                fontWeight: FontWeight.w600,
                color: Color(0xFF07C168)),
          ),
        )
        // Container(
        //   child: Text(type, style: TextStyle(
        //     color: Colors.red
        //   ),),
        // ),
        // Row(
        //   children: [
        //     Container(
        //         alignment: Alignment.centerLeft,
        //         padding: const EdgeInsets.only(top: 4),
        //         child: Text(propertyType, style: st535353500Rubik12)),
        //
        //     Spacer(),
        //     // Text('ROI',
        //     //     style: st535353400Rubik13.copyWith(color: Color(0xFFA3A3A3)))
        //   ],
        // ),
        // Text(type == "invest"? "Co-own": type, style: stNormal13.copyWith(color: kc2F54C6)),

        // Container(
        //   alignment: Alignment.centerLeft,
        //   padding: const EdgeInsets.symmetric(vertical: 4),
        //   child: Text(
        //     state,
        //     style: TextStyle(
        //         color: kc2F54C6, fontSize: 12, fontWeight: FontWeight.w500),
        //   ),
        // ),

        // Row(
        //   children: [
        //     Text(
        //       '$rio% p.a',
        //       style: st535353600Rubik16.copyWith(color: Color(0xFF07C168)),
        //     ),
        //     // Text('N20,000 p.a', style: st535353500Rubik14),
        //     RichText(
        //       text: TextSpan(
        //           // text: '₦',
        //           children: [
        //             // TextSpan(text: price, style: st535353500Rubik14
        //             //     // addCommaToString.format(int.parse(price))
        //             //     ),
        //             // TextSpan(text: ' p.f')
        //           ],
        //           style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.w500,
        //               color: kc535353)),
        //     ),
        //     Spacer(),
        //   ],
        // ),
      ],
    );
  }
}

class PortfolioInvestStyleWidget extends StatelessWidget {
  final String type;
  final String frag;
  final String tokenId;
  final String rio;
  const PortfolioInvestStyleWidget(
      {Key key, this.type, this.frag, this.tokenId, this.rio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(frag);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(tokenId, style: st535353500Rubik12),
            Spacer(),
            Text('$frag FRAG', style: st535353500Rubik14)
          ],
        ),
        Text('Invested', style: stNormal13.copyWith(color: kc2F54C6)),
      ],
    );
  }
}
