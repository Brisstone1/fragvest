import 'package:flutter/material.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/src/pie_chart.dart' as le;
import 'package:provider/provider.dart';

class PortFolioChat extends StatelessWidget {
  // final AssetAllocation assetAllocation;
  // PortFolioChat(this.assetAllocation);
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    final _assetsChat = serviceProvider.assetAllocation;
    // print('The chart ${_assetsChat.invested}');

    return Container(
        height: 146,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          // color: Color(0xFF0C0932),
          decoration: BoxDecoration(
            // color: Color(0xFF0C0932),
            image: new DecorationImage(
              image: new AssetImage("assets/images/portfoliobg.png"),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(5),
            // color: Colors.white,
            // border: Border(
            //   left: BorderSide(
            //     color: Colors.green,
            //     width: 3,
            //   ),
            // ),
          ),
          child: PieChart(
            dataMap: dataType(_assetsChat.invested.toDouble(),
                _assetsChat.rented.toDouble(), _assetsChat.owned.toDouble()),
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 4,
            colorList: [
              Color(0xFF2F54C6),
              Color(0xFFFFC327),
              Color(0xFF00AA57),

            ],
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 20,
            // centerText: "HYBRID",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: le.LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: st535353500Rubik14,
            ),
            chartValuesOptions: ChartValuesOptions(
              decimalPlaces: 0,
              showChartValueBackground: false,
              showChartValues: false,
              showChartValuesInPercentage: false,
              // showChartValuesOutside: true,
            ),
          ),
        ));
  }

  Map<String, double> dataType(double invest, double rated, double owned) {
    Map<String, double> data = {
      "Co-owned      $invest%": invest,
      "Rented${"    "}          $rated%": rated,
      "Owned ${"  "}           $owned%": owned,
    };
    return data;
  }
}
