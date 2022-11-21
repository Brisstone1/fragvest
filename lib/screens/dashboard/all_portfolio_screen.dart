import 'package:flutter/material.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/portfolio_property_widget.dart';

class AllPortfolioScreen extends StatelessWidget {
  static const routeName = '/all-portfolio';
  const AllPortfolioScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Portfolio', true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PortfolioPropertyWidget(isAll: true, scrowable: true),
      ),
    );
  }
}
