import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart' as dash;
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/screens/dashboard/trending_property_detail_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:fragvest_mobile/widget/card_summary.dart';

class TrendingPropertyWidget extends StatelessWidget {
  @required
  final bool isAll;
  @required
  final bool scrowable;

  const TrendingPropertyWidget({Key key, this.isAll, this.scrowable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    List<dash.Properties> _trending = serviceProvider.trending;

    return _trending.isEmpty
        ? Center(child: Text('No available property yet!'))
        : isAll
            ?  GridView.builder(
                physics: scrowable
                    ? BouncingScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                itemCount: _trending.length,
                itemBuilder: (context, index) {
                  final _trendingData = _trending[index];
                  final width = MediaQuery.of(context).size.width * 0.41;
                  return GestureDetector(
                    onTap: () {
                      serviceProvider.setSelectedTrending(_trendingData);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TrendingPropertyDetail(_trendingData);
                      }));
                    },
                    child: cardSummary(
                        propertyImages: _trendingData.propertyImages,
                        type: _trendingData.type,
                        propertyType: _trendingData.propertyType,
                        state: _trendingData.state,
                        costPrice: _trendingData.costPrice,
                        invested: _trendingData.fragPrice,
                        width: width,
                        isShopping: true,
                        // availableFrag: _trendingData.propertyStats.availableFrags
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
            : GridView.builder(
                    // scrollDirection: Axis.horizontal,
                    // physics: BouncingScrollPhysics(),
                    // shrinkWrap: true,
                    physics: scrowable
                        ? BouncingScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    itemCount: _trending.take(2).length,
                    itemBuilder: (context, index) {
                      final _trendingData = _trending[index];
                      final width = MediaQuery.of(context).size.width * 0.41;
                      return GestureDetector(
                          onTap: () {
                            serviceProvider.setSelectedTrending(_trendingData);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return TrendingPropertyDetail(_trendingData);
                            }));
                          },
                          // bbb
                          child: cardSummary(
                              propertyImages: _trendingData.propertyImages,
                              type: _trendingData.type,
                              propertyType: _trendingData.propertyType,
                              state: _trendingData.state,
                              costPrice: _trendingData.costPrice,
                              invested: _trendingData.fragPrice,
                              width: width,
                              isShopping: true,
                              // availableFrag: _trendingData.propertyStats.availableFrags
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
