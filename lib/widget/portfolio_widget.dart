import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/portfolio_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/screens/portfolio/portfolio_detail_screen.dart';

import 'package:fragvest_mobile/widget/rent_style_widget.dart';
import 'package:fragvest_mobile/widget/sale_style_widget.dart';
import 'package:provider/provider.dart';
import 'invest_style_widget.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/card_summary.dart';
class PortfolioWidget extends StatelessWidget {
  @required
  final bool scrowable;
  @required
  final bool isShowAll;
  const PortfolioWidget({Key key, this.scrowable, this.isShowAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    PortfolioModel portfolioModel = serviceProvider.portfolioModel;
    return portfolioModel.data.properties.length == 0
        ? Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Text("You don't have property yet!"))
        : GridView.builder(
            physics: scrowable
                ? BouncingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: isShowAll
                ? portfolioModel.data.properties.length
                : portfolioModel.data.properties.take(5).length,
            itemBuilder: (context, index) {
              final _portfolioData = portfolioModel.data.properties[index];
              final width = MediaQuery.of(context).size.width * 0.41;

              return GestureDetector(
                onTap: () {
                  serviceProvider.setPortfolioData(_portfolioData);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PortfolioDetailScreen(_portfolioData)));
                },
                child: cardSummary(
                    propertyImages: _portfolioData.propertyImages,
                    type: _portfolioData.type,
                    propertyType: _portfolioData.propertyType,
                    state: _portfolioData.state,
                    costPrice: _portfolioData.costPrice,
                    invested: _portfolioData.fragPrice,
                    width: width,
                  isShopping: false,

                    availableFrag: _portfolioData?.report?.invested
                )
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: 4 / 5,
              mainAxisExtent: 206,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ));
  }
}
