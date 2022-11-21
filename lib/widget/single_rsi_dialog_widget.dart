import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:provider/provider.dart';

import '../screens/market/r_s_i_filter_result.dart';
import '../utilities/list_item.dart';
import 'custom_button_widget.dart';

class SinfleRSIDialogWidget extends StatefulWidget {
  final VoidCallback callback;
  const SinfleRSIDialogWidget({Key key, this.callback}) : super(key: key);

  @override
  State<SinfleRSIDialogWidget> createState() => _SinfleRSIDialogWidgetState();
}

class _SinfleRSIDialogWidgetState extends State<SinfleRSIDialogWidget> {
  RangeValues _currentRangeValues = const RangeValues(500000, 900000);

  @override
  Widget build(BuildContext context) {
    final servicePrivder = Provider.of<ServiceProvider>(context);
    return SingleChildScrollView(
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 24),
            Text('Price range', style: st535353400Rubik14),
            RangeSlider(
              values: _currentRangeValues,
              min: 30000,
              max: 1000000,
              divisions: 5,
              activeColor: kc3DED97,
              inactiveColor: Color(0xffd4d4d4),
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                servicePrivder.setPriceRange(
                    '${values.start.round()}-${values.end.round()}');
                print(servicePrivder.priceRange);
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('30k', style: st535353400Rubik14),
                  Text('1,000,000', style: st535353400Rubik14)
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Rooms', style: st535353400Rubik14),
            const SizedBox(height: 8),
            Container(
              height: 35,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: roomsList.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        servicePrivder.setRooms(roomsList[i]);
                        print('Rooms ' + servicePrivder.rooms);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 36,
                        width: 53,
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: kc535353),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          roomsList[i],
                          style: st535353400Rubik14,
                        ),
                      ),
                    );
                  }),
            ),
            // Row(
            //   children: [
            //     rooms('Any', widget.callback),
            //     rooms('1', widget.callback),
            //     rooms('2', widget.callback),
            //     rooms('3+', widget.callback),
            //   ],
            // ),
            const SizedBox(height: 24),
            Text('Bathrooms', style: st535353400Rubik14),
            const SizedBox(height: 8),
            // Row(
            //   children: [
            //     rooms('Any', widget.callback),
            //     rooms('1', widget.callback),
            //     rooms('2', widget.callback),
            //     rooms('3+', widget.callback),
            //   ],
            // ),
            Container(
              height: 35,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: bedRoomsList.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        servicePrivder.setBedRoom(bedRoomsList[i]);
                        print('Bedrooms ' + servicePrivder.bedroom);
                      },
                      child: Container(
                        height: 36,
                        width: 53,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: kc535353),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          bedRoomsList[i],
                          style: st535353400Rubik14,
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 40),
            customButton('Filter', () {
              Navigator.pushReplacementNamed(
                  context, RSIFilterResult.routeName);
            })
          ],
        ),
      ),
    );
  }
}
