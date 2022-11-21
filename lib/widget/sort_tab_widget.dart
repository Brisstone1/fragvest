import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/market/filter_result_screen.dart';
import 'package:fragvest_mobile/utilities/list_item.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:provider/provider.dart';

class SortTabWidget extends StatefulWidget {
  // final VoidCallback callback;
  // final String type;
  const SortTabWidget({
    Key key,
    // @required this.type,
  }) : super(key: key);

  @override
  State<SortTabWidget> createState() => _SortTabWidgetState();
}

class _SortTabWidgetState extends State<SortTabWidget> {
  RangeValues _currentRangeValues = const RangeValues(500000, 900000);
  int _propertyTypeCurrentIndex;
  int _roomsCurrentIndex;
  int _bedRoomCurrentIndex;

  @override
  Widget build(BuildContext context) {
    final servicePrivder = Provider.of<ServiceProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('Type of Apartment'),
          const SizedBox(height: 24),

          ///Property Type
          Container(
            height: 35,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: propertTypeList.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      servicePrivder.setPropertyType(propertTypeList[i]);
                      print(servicePrivder.propertyType);

                      setState(() {
                        _propertyTypeCurrentIndex = i;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: _propertyTypeCurrentIndex == i
                              ? kc3DED97
                              : kcWhite,
                          border: Border.all(
                              color: _propertyTypeCurrentIndex == i
                                  ? kc3DED97
                                  : kc535353),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        propertTypeList[i],
                        style: st535353400Rubik14.copyWith(
                            color: _propertyTypeCurrentIndex == i
                                ? kcWhite
                                : kc535353),
                      ),
                    ),
                  );
                }),
          ),

          const SizedBox(height: 24),
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
              setState(() {
                _currentRangeValues = values;
                print(servicePrivder.priceRange);
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
          const SizedBox(height: 10),
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
                      setState(() {
                        _roomsCurrentIndex = i;
                      });
                    },
                    child: Container(
                      height: 36,
                      width: 53,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: _roomsCurrentIndex == i ? kc3DED97 : kcWhite,
                          border: Border.all(
                              color: _roomsCurrentIndex == i
                                  ? kc3DED97
                                  : kc535353),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        roomsList[i],
                        style: st535353400Rubik14.copyWith(
                            color:
                                _roomsCurrentIndex == i ? kcWhite : kc535353),
                      ),
                    ),
                  );
                }),
          ),
          // Row(
          //   children: [
          //     rooms('Any', () {
          //       servicePrivder.setRooms('Any');
          //       print(servicePrivder.rooms);
          //     }),
          //     rooms('1', () => servicePrivder.setRooms('1')),
          //     rooms('2', () => servicePrivder.setRooms('2')),
          //     rooms('3+', () => servicePrivder.setRooms('3+')),
          //   ],
          // ),
          const SizedBox(height: 24),
          Text('Bathrooms', style: st535353400Rubik14),
          const SizedBox(height: 10),
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

                      setState(() {
                        _bedRoomCurrentIndex = i;
                      });
                    },
                    child: Container(
                      height: 36,
                      width: 53,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: _bedRoomCurrentIndex == i ? kc3DED97 : kcWhite,
                          border: Border.all(
                              color: _bedRoomCurrentIndex == i
                                  ? kc3DED97
                                  : kc535353),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        bedRoomsList[i],
                        style: st535353400Rubik14.copyWith(
                            color:
                                _bedRoomCurrentIndex == i ? kcWhite : kc535353),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 10),
          // Row(
          //   children: [
          //     rooms('Any', () {
          //       servicePrivder.setBedRoom('Any');
          //       print(servicePrivder.rooms);
          //     }),
          //     rooms('1', () => servicePrivder.setBedRoom('1')),
          //     rooms('2', () => servicePrivder.setBedRoom('2')),
          //     rooms('3+', () => servicePrivder.setBedRoom('3+')),
          //   ],
          // ),
          const SizedBox(height: 40),
          customButton('Filter', () async {
            print('object');

            // final respo =
            //     await
            // await servicePrivder.setAllProerty(false);

            await servicePrivder.setGetProperty(GetServices.getPropertyByFilter(
                context, servicePrivder.rsiType));
            servicePrivder.increaseCount();

            Navigator.pushReplacementNamed(
                context, FilterResultScreen.routeName);

            // Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
