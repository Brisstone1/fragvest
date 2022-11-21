import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/widget/rent_style_widget.dart';
import 'package:fragvest_mobile/widget/sale_style_widget.dart';
import 'package:provider/provider.dart';

import 'invest_style_widget.dart';

class PropertyTemplateTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    final properData = serviceProvider.propertyData;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 190,
      decoration: BoxDecoration(
        color: kcWhite.withOpacity(0.8),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            margin: EdgeInsets.only(bottom: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl: properData.propertyImages[0],
                    placeholder: (context, url) =>
                        SpinKitCircle(size: 30), // CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill)),
          ),
          SizedBox(height: 10,),
          if (properData.type == 'sale')
            SaleStyleWidget(type: properData.type, price: properData.costPrice),
          if (properData.type == 'invest')
            InvestStyleWidget(
                type: properData.type, price: properData.costPrice),
          if (properData.type == 'rent')
            RentStyleWidget(
                type: properData.type,
                price: properData.costPrice,
                propertyTpye: properData.propertyType)
        ],
      ),
    );
  }
}
