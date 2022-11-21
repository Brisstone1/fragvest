import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/availble_property_widget.dart';
import 'package:fragvest_mobile/widget/want_widget.dart';
import 'package:provider/provider.dart';

import '../../widget/appbar_widget.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key key}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  void initState() {
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.setAllProerty(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kcF5f5f5.withOpacity(0.6),
      appBar: marketAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            WantWidget(),
            SizedBox(height: 50),
            Text('Available Properties', style: st535353600Rubik16),
            SizedBox(height: 20),
            // Container(
            //   color: Colors.red,
            //   height: 300,
            // )
            AvailablePropertyWidget(scrowable: false, isShowAll: true)
          ],
        ),
      ),
    );
  }
}
