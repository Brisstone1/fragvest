import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/sort_tab_widget.dart';
import 'package:provider/provider.dart';

class SortByStatus extends StatefulWidget {
  const SortByStatus({
    Key key,
  }) : super(key: key);

  @override
  State<SortByStatus> createState() => _SortByStatusState();
}

class _SortByStatusState extends State<SortByStatus>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  // String type;

  @override
  void initState() {
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);

    serviceProvider.setRSIType('sale');
    // type = 'sale';
    print('Init ' + serviceProvider.rsiType);
    _controller = TabController(length: 3, vsync: this);
    _controller
      ..addListener(() {
        setState(() {
          serviceProvider.setPriceRange(null);
          serviceProvider.setPropertyType(null);
          serviceProvider.setRooms(null);
          serviceProvider.setBedRoom(null);
          if (_controller.index == 0) {
            serviceProvider.setRSIType('sale');

            // type = 'sale';
          } else if (_controller.index == 1) {
            serviceProvider.setRSIType('rent');
            // type = 'rent';
          } else if (_controller.index == 2) {
            serviceProvider.setRSIType('invest');
            // type = 'invest';
          }
          print('Scroll ' + serviceProvider.rsiType);
        });
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 560.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  controller: _controller,
                  // indicatorPadding: const EdgeInsets.only(left: 40, right: 40),
                  indicatorColor: kc3DED97,
                  // labelStyle: TextStyle(color: Colors.black),

                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 4,
                  labelColor: kc0C0932,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black),
                  tabs: [
                    Tab(
                      child: Text(
                        'For Sale',
                        style: st535353700Rubik10.copyWith(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'For Rent',
                        style: st535353700Rubik10.copyWith(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'For Invest',
                        style: st535353700Rubik10.copyWith(fontSize: 16),
                      ),
                    ),
                  ]),
              Expanded(
                  child: TabBarView(
                controller: _controller,
                children: [SortTabWidget(), SortTabWidget(), SortTabWidget()],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
