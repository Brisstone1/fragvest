import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardSummary(
    {List propertyImages,
    double width,
    String state,
    String type,
    String State,
    String propertyType,
    String costPrice,
    String invested,
    bool isShopping,
String availableFrag
    }) {
  

  return Container(
    width: width,
    decoration: BoxDecoration(
        // color: Color(0xFF000000),

        // borderRadius: BorderRadius.circular(10)
        ),
    child: Container(
      // padding: const EdgeInsets.all(8),
      width: 165,
      height: 206,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Color(0xFFBDBDBD))),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              Container(
                height: 118,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: propertyImages[0],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                          height: 50,
                          width: 30,
                          child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Column(
                  children: [
                    if(isShopping)
                      Container(
                        width: 81,
                        height: 25,
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: kcWhite,
                            borderRadius: BorderRadius.circular(5)),

                        child: Text(
                          type == 'invest'
                              ? 'For Co-own'
                              : type == 'rent'
                                  ? 'For Rent'
                                  : type == "sale"
                                      ? "For Sale"
                                      : type,
                          style: TextStyle(
                              color: Color(0xFF07C168),
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    if(!isShopping )
                      Container(
                        width: 81,
                        height: 25,
                        alignment: Alignment.center,
                        // padding:
                        //     const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            color: kcWhite,
                            borderRadius: BorderRadius.circular(5)),

                        child: Text(
                          type == 'invest'
                              ? 'Co-owned'
                              : type == 'rent'
                              ? 'Rented'
                              : type == "sale"
                              ? "Owned"
                              : type,
                          style: TextStyle(
                              color: Color(0xFF07C168),
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text('${propertyType}',
                style:
                    st535353500Rubik12.copyWith(fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(state.contains('Abuja') ? "Abuja FCT" : state,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: kc0C0932)),
          ),
          SizedBox(
            height: 4,
          ),
          if(isShopping)
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                type == 'invest'  ? '₦${invested.split(' ')[0]} per frag' :type == 'rent'  ? '₦${costPrice.split(' ')[0]} per annum': '₦${costPrice}',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF07C168)),
              ),
            ),
          if(!isShopping && (type == "invest"))
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                type == 'invest'  ? '${availableFrag} frags' :type == 'rent'  ? '₦${costPrice.split(' ')[0]} per annum': '₦${costPrice}',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF07C168)),
              ),
            ),
          if(((!isShopping) && (type == "rent")) || ((!isShopping) && (type == "sale")))
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              type == 'invest'  ? '₦${invested.split(' ')[0]} per fragii' :type == 'rent'  ? '₦${costPrice.split(' ')[0]} per annum': '₦${costPrice}',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: "",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF07C168)),
            ),
          ),

          // if(isShopping && (type == "invest") || !isShopping)
          //   Container(
          //     margin: EdgeInsets.only(left: 10),
          //     child: Text(
          //       type == 'invest'  ? '${availableFrag} frags' :type == 'rent'  ? '₦${costPrice.split(' ')[0]} per annum': '₦${costPrice}',
          //       style: TextStyle(
          //           fontSize: 14,
          //           fontFamily: "",
          //           fontWeight: FontWeight.w600,
          //           color: Color(0xFF07C168)),
          //     ),
          //   )
        ],
      ),
    ),
  );
}
