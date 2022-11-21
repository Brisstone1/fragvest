import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/screens/dashboard/dashboard_portfolio_property_detail.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:fragvest_mobile/widget/card_summary.dart';

class PortfolioPropertyWidget extends StatelessWidget {
  @required
  final bool isAll;
  @required
  final bool scrowable;

  const PortfolioPropertyWidget({Key key, this.isAll, this.scrowable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();

    List<Portfolio> _portfolio = serviceProvider.portfolio;

    return isAll
        ? GridView.builder(
            physics: scrowable
                ? BouncingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            // physics: NeverScrollableScrollPhysics(),
            itemCount: isAll ? _portfolio.length : _portfolio.take(2).length,
            itemBuilder: (context, index) {
              final _portfolioData = _portfolio[index];
              final width = MediaQuery.of(context).size.width * 0.41;

              return GestureDetector(
                onTap: () {
                  serviceProvider.setSelectedPortfolio(_portfolioData);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DashboardPortfolioDetail(_portfolioData);
                  }));
                },
                child: cardSummary(
                    propertyImages: _portfolioData.propertyImages,
                    type: _portfolioData.type,
                    propertyType: _portfolioData.propertyType,
                    state: _portfolioData.state,
                    costPrice: _portfolioData.costPrice,
                    invested: _portfolioData.report.invested,
                    width: width,
                    isShopping: false,
                    availableFrag: _portfolioData?.report?.invested

                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: 4 / 5,
              mainAxisExtent: 206,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          )
        : _portfolio.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 60,
                      child: Image.asset(
                        imgPana2,
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 20),
                    child: RichText(
                      text: TextSpan(
                        text:
                            'You currently do not have any property in your portfolio. Buy, rent or invest in a property now!',
                        children: [
                          TextSpan(
                              text: 'now',
                              style: st000000400Poppins12.copyWith(
                                  color: kc3DED97)),
                          TextSpan(text: '!')
                        ],
                        style: st000000400Poppins12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            : GridView.builder(
                // scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _portfolio.take(2).length,
                itemBuilder: (context, index) {
                  final _portfoiloData = _portfolio[index];
                  final width = MediaQuery.of(context).size.width * 0.41;
                  return GestureDetector(
                      onTap: () {
                        // print(index);
                        serviceProvider.setSelectedPortfolio(_portfoiloData);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DashboardPortfolioDetail(_portfoiloData);
                        }));
                      },
                      child: cardSummary(
                          propertyImages: _portfoiloData.propertyImages,
                          type: _portfoiloData.type,
                          propertyType: _portfoiloData.propertyType,
                          state: _portfoiloData.state,
                          costPrice: _portfoiloData.costPrice,
                          invested: _portfoiloData.report.invested,
                          width: width,
                          isShopping: false,
                          availableFrag: _portfoiloData?.report?.invested
                      ));
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
