import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/portfolio/order_buy_tab.dart';
import 'package:fragvest_mobile/widget/portfolio/order_invest_tab.dart';
import 'package:fragvest_mobile/widget/portfolio/order_rent_tab.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Order History'),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 31,
                // decoration: BoxDecoration(
                //     color: kcF6F6F6, borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 4,
                    indicatorColor: kc3DED97,
                    labelColor: kc0C0932,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black),
                    tabs: [
                      Tab(
                        text: 'Rent',
                      ),
                      Tab(
                        text: 'Buy',
                      ),
                      Tab(
                        text: 'Co-own',
                      ),
                    ]),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  OrderRentTab(),
                  OrderBuyTab(),
                  OrderInvestTab(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
