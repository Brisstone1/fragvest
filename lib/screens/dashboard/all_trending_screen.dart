import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/trending_property_widget.dart';

class AllTrendingScreen extends StatelessWidget {
  static const routeName = '/all-trending';
  const AllTrendingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kcWhite,
      appBar: customAppBar('Newest Deals', true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  TrendingPropertyWidget(
          isAll: true,
          scrowable: true,
        ),
      ),
    );
  }
}
