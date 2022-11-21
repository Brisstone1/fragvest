import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/model/available_states_model.dart';
import 'package:fragvest_mobile/screens/market/filter_result_screen.dart';
import 'package:fragvest_mobile/utilities/add_comma_to_number.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/list_item.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/property_vm.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/retry_button.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({Key key}) : super(key: key);

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  RangeValues _currentRangeValues = const RangeValues(200000000, 600000000);
  // RangeValues _currentRangeValues = const RangeValues(200000, 600000);

  // String _selectedLocation;

  String _priceRange = '';
  String _propertyType;

  double assetPrice = 0.0;

  int fragPercent = 0;
  double fragPercentValue = 0.0;
  int percentIndex = 0;
  int roomIndex = 0;
  int bathroomIndex = 0;
  List<String> pressedNumber = [];
  bool isPercent = false;
  // int percentIndex = 0;

  setFragPercent(int percent, int index, String propertyType) {
    isPercent = true;
    fragPercent = percent;
    percentIndex = index;
    assetPrice = 0.0;

    setState(() {
      _propertyType = propertyType;
    });
    // fragPercentValue = (fragPercent / 100) *
    //     double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''));
    // assetPrice = ((fragPercent / 100) *
    //     double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''))) *
    //     double.tryParse(sellPropertyMap.pricePerFrag.replaceAll(' p.f', ''));

    setState(() => {});
  }

  setRoomValue(int percent, int index) {
    isPercent = true;
    fragPercent = percent;
    roomIndex = index;
    // assetPrice = 0.0;
    // fragPercentValue = (fragPercent / 100) *
    //     double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''));
    // assetPrice = ((fragPercent / 100) *
    //     double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''))) *
    //     double.tryParse(sellPropertyMap.pricePerFrag.replaceAll(' p.f', ''));

    setState(() => {});
  }

  setBathRoomValue(int percent, int index) {
    isPercent = true;
    // fragPercent = percent;
    bathroomIndex = index;
    // assetPrice = 0.0;
    // fragPercentValue = (fragPercent / 100) *
    //     double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''));
    // assetPrice = ((fragPercent / 100) *
    //     double.tryParse(sellPropertyMap.investedFrag.replaceAll(',', ''))) *
    //     double.tryParse(sellPropertyMap.pricePerFrag.replaceAll(' p.f', ''));

    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        // height: 200,
        child: SingleChildScrollView(
          child: Container(
            height: 400,
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
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Image.asset(homeIndicator),
                  ),
                  TabBar(
                      // controller: _controller,
                      indicatorPadding:
                          const EdgeInsets.only(left: 40, right: 40),
                      indicatorColor: kc3DED97,
                      // labelStyle: TextStyle(color: Colors.black),
                      // indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 2,
                      // indicatorColor: kc3DED97,
                      // labelColor: kc0C0932,
                      unselectedLabelColor: kc535353,
                      // labelStyle: st16161D500Rubik14,
                      tabs: [
                        Tab(
                          child: Text(
                            'For Sale',
                            style: st535353700Rubik10.copyWith(fontSize: 16, color: kc0C0932),
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
                            'For Co-own',
                            style: st535353700Rubik10.copyWith(fontSize: 16),
                          ),
                        ),
                      ]),
                  Expanded(
                      child: TabBarView(
                    // controller: _controller,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            BaseViewBuilder<PropertyVm>(
                                model: getIt(),
                                initState: (init) {
                                  if (init.availableStatesModel == null) {
                                    init.getAvailableStates();
                                  }
                                },
                                dispose: (dis) {
                                  dis.onDispose();
                                },
                                builder: (pVm, child) {
                                  return pVm.stateLoadStatus == 'initial'
                                      ? initialLoader(45)
                                      : pVm.stateLoadStatus == 'failed'
                                          ? RetryButton(
                                              // orderType: 'buy',
                                              title:
                                                  'Oops! Could not fetch location',
                                              voidCallback: () {
                                                pVm.getAvailableStates();
                                              })
                                          : pVm.stateLoadStatus == 'seccess' &&
                                                  pVm.availableStatesModel !=
                                                      null
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Location',
                                                      style: st0C0932500Rubik14
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    SizedBox(height: 11),
                                                    SizedBox(
                                                      height: 44,
                                                      child: DropdownButtonFormField<
                                                              StateData>(
                                                          value:
                                                              pVm.selectedState,
                                                          decoration:
                                                              borderTextInputDecoration,
                                                          elevation: 16,
                                                          isExpanded: true,
                                                          onChanged: pVm
                                                              .setSelectedState,
                                                          items: pVm
                                                              .availableStatesModel
                                                              .state
                                                              .map((StateData
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                    StateData>(
                                                                value: value,
                                                                child: Text(
                                                                    value
                                                                        .name));
                                                          }).toList()),
                                                    ),
                                                    // SizedBox(height: 30),
                                                    // Text(
                                                    //   'Type of Apartment',
                                                    //   style: st535353400Rubik15,
                                                    // ),
                                                    // SizedBox(height: 15),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children: [
                                                    //     percentButton(
                                                    //         percent: 'Land',
                                                    //         selectedindex: 1,
                                                    //         perecentIndex:
                                                    //             percentIndex,
                                                    //         callback: () =>
                                                    //             setFragPercent(
                                                    //                 25,
                                                    //                 1,
                                                    //                 'Land')),
                                                    //     percentButton(
                                                    //         percent:
                                                    //             'Residential',
                                                    //         selectedindex: 2,
                                                    //         perecentIndex:
                                                    //             percentIndex,
                                                    //         callback: () =>
                                                    //             setFragPercent(
                                                    //                 25,
                                                    //                 2,
                                                    //                 'Residential')),
                                                    //     percentButton(
                                                    //         percent:
                                                    //             'Commercial',
                                                    //         selectedindex: 3,
                                                    //         perecentIndex:
                                                    //             percentIndex,
                                                    //         callback: () =>
                                                    //             setFragPercent(
                                                    //                 25,
                                                    //                 3,
                                                    //                 'Commercial')),
                                                    //   ],
                                                    // ),

                                                    const SizedBox(height: 24),
                                                    Row(
                                                      children: [
                                                        Text('Price range',
                                                            style:
                                                                st535353400Rubik15),
                                                        // Spacer(),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Text(
                                                        '${addCommaToString.format(_currentRangeValues.start)} - ${addCommaToString.format(_currentRangeValues.end)}',
                                                        style: st000000400Rubik14
                                                            .copyWith(
                                                                color: kc3DED97,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    RangeSlider(
                                                      values:
                                                          _currentRangeValues,
                                                      min: 1,
                                                      // max: 1000000,
                                                      max: 1000000000,
                                                      divisions: 1000000000,
                                                      activeColor: kc3DED97,
                                                      inactiveColor:
                                                          Color(0xffd4d4d4),
                                                      labels: RangeLabels(
                                                        _currentRangeValues
                                                            .start
                                                            .round()
                                                            .toString(),
                                                        _currentRangeValues.end
                                                            .round()
                                                            .toString(),
                                                      ),
                                                      onChanged:
                                                          (RangeValues values) {
                                                        setState(() {
                                                          _currentRangeValues =
                                                              values;
                                                          _priceRange =
                                                              '${_currentRangeValues.start.toStringAsFixed(0)}-${_currentRangeValues.end.toStringAsFixed(0)}';
                                                          // print(_currentRangeValues.start);
                                                          // print(_currentRangeValues.end);
                                                          // print(_priceRange);
                                                        });
                                                      },
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('1',
                                                              style:
                                                                  st535353400Rubik14),
                                                          Text('1,000,000,000',
                                                              style:
                                                                  st535353400Rubik14)
                                                        ],
                                                      ),
                                                    ),

                                                    // Column(
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment
                                                    //           .start,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Rooms',
                                                    //       style:
                                                    //           st535353400Rubik15,
                                                    //     ),
                                                    //     SizedBox(height: 15),
                                                    //     Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         roomsButton(
                                                    //             percent: 'Any',
                                                    //             selectedindex:
                                                    //                 4,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 4)),
                                                    //         roomsButton(
                                                    //             percent: '1',
                                                    //             selectedindex:
                                                    //                 5,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 5)),
                                                    //         roomsButton(
                                                    //             percent: '2',
                                                    //             selectedindex:
                                                    //                 6,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 6)),
                                                    //         roomsButton(
                                                    //             percent: '3+',
                                                    //             selectedindex:
                                                    //                 7,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 7)),
                                                    //       ],
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    // Column(
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment
                                                    //           .start,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Bathrooms',
                                                    //       style:
                                                    //           st535353400Rubik15,
                                                    //     ),
                                                    //     SizedBox(height: 15),
                                                    //     Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         bathroomButton(
                                                    //             percent: 'Any',
                                                    //             selectedindex:
                                                    //                 1,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 1)),
                                                    //         bathroomButton(
                                                    //             percent: '1',
                                                    //             selectedindex:
                                                    //                 2,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 2)),
                                                    //         bathroomButton(
                                                    //             percent: '2',
                                                    //             selectedindex:
                                                    //                 3,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 3)),
                                                    //         bathroomButton(
                                                    //             percent: '3+',
                                                    //             selectedindex:
                                                    //                 4,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 4)),
                                                    //       ],
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    SizedBox(height: 20),

                                                    customButton('Filter', () {
                                                      // print('object1 $_selectedLocation');
                                                      // print('object2 $_priceRange');
                                                      // print('object3 $_propertyType');
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return FilterResultScreen(
                                                            // location: "162",
                                                            location:
                                                                '${pVm.selectedState.id}',
                                                            priceRange:
                                                                _priceRange,
                                                            propertyType:
                                                                _propertyType ??
                                                                    '',
                                                            filterPage:
                                                                'Property for Sale');
                                                      }));
                                                    },
                                                        // isActive: pVm.selectedState ==
                                                        //             null &&
                                                        //         _priceRange
                                                        //             .isEmpty &&
                                                        //         _propertyType ==
                                                        //             null
                                                        //     ? false
                                                        //     : true
                                                        isActive: pVm.selectedState ==
                                                                    null ||
                                                                _priceRange
                                                                    .isEmpty
                                                            // ||
                                                            //     _propertyType ==
                                                            //         null
                                                            ? false
                                                            : true),
                                                    SizedBox(height: 30),
                                                  ],
                                                )
                                              : RetryButton(
                                                  // orderType: 'buy'
                                                  title:
                                                      'Oops! Could not fetch location',
                                                  voidCallback: () {
                                                    pVm.getAvailableStates();
                                                  });
                                }),
                          ],
                        ),
                      ),
                      ////DIVIDER
                      SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     IconButton(
                            //         onPressed: () => Navigator.pop(context),
                            //         icon: Icon(
                            //           Icons.arrow_back,
                            //           color: Colors.black,
                            //         )),
                            //     // Text('Filter', style: st535353500Rubik),
                            //     TextButton(
                            //         onPressed: () {
                            //           setState(() {
                            //             // pVm.selectedState = null;
                            //             _priceRange = '';
                            //             _propertyType = null;
                            //           });
                            //         },
                            //         child: Text(
                            //           'Reset',
                            //           style: st000000400Rubik14.copyWith(
                            //               color: kcEE1A1A),
                            //         )),
                            //   ],
                            // ),
                            // SizedBox(height: 5),
                            BaseViewBuilder<PropertyVm>(
                                model: getIt(),
                                initState: (init) {
                                  if (init.availableStatesModel == null) {
                                    init.getAvailableStates();
                                  }
                                },
                                dispose: (dis) {
                                  dis.onDispose();
                                },
                                builder: (pVm, child) {
                                  return pVm.stateLoadStatus == 'initial'
                                      ? initialLoader(45)
                                      : pVm.stateLoadStatus == 'failed'
                                          ? RetryButton(
                                              // orderType: 'buy',
                                              title:
                                                  'Oops! Could not fetch location',
                                              voidCallback: () {
                                                pVm.getAvailableStates();
                                              })
                                          : pVm.stateLoadStatus == 'seccess' &&
                                                  pVm.availableStatesModel !=
                                                      null
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Location',
                                                      style: st0C0932500Rubik14
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    SizedBox(height: 11),
                                                    SizedBox(
                                                      height: 44,
                                                      child: DropdownButtonFormField<
                                                              StateData>(
                                                          value:
                                                              pVm.selectedState,
                                                          decoration:
                                                              borderTextInputDecoration,
                                                          elevation: 16,
                                                          isExpanded: true,
                                                          onChanged: pVm
                                                              .setSelectedState,
                                                          items: pVm
                                                              .availableStatesModel
                                                              .state
                                                              .map((StateData
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                    StateData>(
                                                                value: value,
                                                                child: Text(
                                                                    value
                                                                        .name));
                                                          }).toList()),
                                                    ),
                                                    // SizedBox(height: 30),
                                                    // Text(
                                                    //   'Type of Apartment',
                                                    //   style: st535353400Rubik15,
                                                    // ),
                                                    // SizedBox(height: 15),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children: [
                                                    //     percentButton(
                                                    //         percent: 'Land',
                                                    //         selectedindex: 1,
                                                    //         perecentIndex:
                                                    //             percentIndex,
                                                    //         callback: () =>
                                                    //             setFragPercent(
                                                    //                 25,
                                                    //                 1,
                                                    //                 'Land')),
                                                    //     percentButton(
                                                    //         percent:
                                                    //             'Residential',
                                                    //         selectedindex: 2,
                                                    //         perecentIndex:
                                                    //             percentIndex,
                                                    //         callback: () =>
                                                    //             setFragPercent(
                                                    //                 25,
                                                    //                 2,
                                                    //                 'Residential')),
                                                    //     percentButton(
                                                    //         percent:
                                                    //             'Commercial',
                                                    //         selectedindex: 3,
                                                    //         perecentIndex:
                                                    //             percentIndex,
                                                    //         callback: () =>
                                                    //             setFragPercent(
                                                    //                 25,
                                                    //                 3,
                                                    //                 'Commercial')),
                                                    //   ],
                                                    // ),

                                                    const SizedBox(height: 24),
                                                    Row(
                                                      children: [
                                                        Text('Price range',
                                                            style:
                                                                st535353400Rubik15),
                                                        // Spacer(),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Text(
                                                        '${addCommaToString.format(_currentRangeValues.start)} - ${addCommaToString.format(_currentRangeValues.end)}',
                                                        style: st000000400Rubik14
                                                            .copyWith(
                                                                color: kc3DED97,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    RangeSlider(
                                                      values:
                                                          _currentRangeValues,
                                                      min: 1,
                                                      // max: 1000000,
                                                      max: 1000000000,
                                                      divisions: 1000000000,
                                                      activeColor: kc3DED97,
                                                      inactiveColor:
                                                          Color(0xffd4d4d4),
                                                      labels: RangeLabels(
                                                        _currentRangeValues
                                                            .start
                                                            .round()
                                                            .toString(),
                                                        _currentRangeValues.end
                                                            .round()
                                                            .toString(),
                                                      ),
                                                      onChanged:
                                                          (RangeValues values) {
                                                        setState(() {
                                                          _currentRangeValues =
                                                              values;
                                                          _priceRange =
                                                              '${_currentRangeValues.start.toStringAsFixed(0)}-${_currentRangeValues.end.toStringAsFixed(0)}';
                                                          // print(_currentRangeValues.start);
                                                          // print(_currentRangeValues.end);
                                                          // print(_priceRange);
                                                        });
                                                      },
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('1',
                                                              style:
                                                                  st535353400Rubik14),
                                                          Text('1,000,000,000',
                                                              style:
                                                                  st535353400Rubik14)
                                                        ],
                                                      ),
                                                    ),

                                                    // Column(
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment
                                                    //           .start,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Rooms',
                                                    //       style:
                                                    //           st535353400Rubik15,
                                                    //     ),
                                                    //     SizedBox(height: 15),
                                                    //     Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         roomsButton(
                                                    //             percent: 'Any',
                                                    //             selectedindex:
                                                    //                 4,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 4)),
                                                    //         roomsButton(
                                                    //             percent: '1',
                                                    //             selectedindex:
                                                    //                 5,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 5)),
                                                    //         roomsButton(
                                                    //             percent: '2',
                                                    //             selectedindex:
                                                    //                 6,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 6)),
                                                    //         roomsButton(
                                                    //             percent: '3+',
                                                    //             selectedindex:
                                                    //                 7,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 7)),
                                                    //       ],
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    // Column(
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment
                                                    //           .start,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Bathrooms',
                                                    //       style:
                                                    //           st535353400Rubik15,
                                                    //     ),
                                                    //     SizedBox(height: 15),
                                                    //     Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         bathroomButton(
                                                    //             percent: 'Any',
                                                    //             selectedindex:
                                                    //                 1,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 1)),
                                                    //         bathroomButton(
                                                    //             percent: '1',
                                                    //             selectedindex:
                                                    //                 2,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 2)),
                                                    //         bathroomButton(
                                                    //             percent: '2',
                                                    //             selectedindex:
                                                    //                 3,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 3)),
                                                    //         bathroomButton(
                                                    //             percent: '3+',
                                                    //             selectedindex:
                                                    //                 4,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 4)),
                                                    //       ],
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    SizedBox(height: 20),

                                                    customButton('Filter', () {
                                                      // print('object1 $_selectedLocation');
                                                      // print('object2 $_priceRange');
                                                      // print('object3 $_propertyType');
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return FilterResultScreen(
                                                            // location: "162",
                                                            location:
                                                                '${pVm.selectedState.id}',
                                                            priceRange:
                                                                _priceRange,
                                                            propertyType:
                                                                _propertyType ??
                                                                    '',
                                                            filterPage:
                                                                'Property for Rent');
                                                      }));
                                                    },
                                                        // isActive: pVm.selectedState ==
                                                        //             null &&
                                                        //         _priceRange
                                                        //             .isEmpty &&
                                                        //         _propertyType ==
                                                        //             null
                                                        //     ? false
                                                        //     : true
                                                        isActive: pVm.selectedState ==
                                                                    null ||
                                                                _priceRange
                                                                    .isEmpty
                                                            // ||
                                                            //     _propertyType ==
                                                            //         null
                                                            ? false
                                                            : true),
                                                    SizedBox(height: 30),
                                                  ],
                                                )
                                              : RetryButton(
                                                  // orderType: 'buy'
                                                  title:
                                                      'Oops! Could not fetch location',
                                                  voidCallback: () {
                                                    pVm.getAvailableStates();
                                                  });
                                }),
                          ],
                        ),
                      ),
                      ////DIVIDER
                      SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     IconButton(
                            //         onPressed: () => Navigator.pop(context),
                            //         icon: Icon(
                            //           Icons.arrow_back,
                            //           color: Colors.black,
                            //         )),
                            //     // Text('Filter', style: st535353500Rubik),
                            //     TextButton(
                            //         onPressed: () {
                            //           setState(() {
                            //             // pVm.selectedState = null;
                            //             _priceRange = '';
                            //             _propertyType = null;
                            //           });
                            //         },
                            //         child: Text(
                            //           'Reset',
                            //           style: st000000400Rubik14.copyWith(
                            //               color: kcEE1A1A),
                            //         )),
                            //   ],
                            // ),
                            // SizedBox(height: 5),
                            BaseViewBuilder<PropertyVm>(
                                model: getIt(),
                                initState: (init) {
                                  if (init.availableStatesModel == null) {
                                    init.getAvailableStates();
                                  }
                                },
                                dispose: (dis) {
                                  dis.onDispose();
                                },
                                builder: (pVm, child) {
                                  return pVm.stateLoadStatus == 'initial'
                                      ? initialLoader(45)
                                      : pVm.stateLoadStatus == 'failed'
                                          ? RetryButton(
                                              // orderType: 'buy',
                                              title:
                                                  'Oops! Could not fetch location',
                                              voidCallback: () {
                                                pVm.getAvailableStates();
                                              })
                                          : pVm.stateLoadStatus == 'seccess' &&
                                                  pVm.availableStatesModel !=
                                                      null
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Location',
                                                      style: st0C0932500Rubik14
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    SizedBox(height: 11),

                                                    SizedBox(
                                                      height: 44,
                                                      child: DropdownButtonFormField<
                                                              StateData>(
                                                          value:
                                                              pVm.selectedState,
                                                          decoration:
                                                              borderTextInputDecoration,
                                                          elevation: 16,
                                                          isExpanded: true,
                                                          onChanged: pVm
                                                              .setSelectedState,
                                                          items: pVm
                                                              .availableStatesModel
                                                              .state
                                                              .map((StateData
                                                                  value) {
                                                            return DropdownMenuItem<
                                                                    StateData>(
                                                                value: value,
                                                                child: Text(
                                                                    value
                                                                        .name));
                                                          }).toList()),
                                                    ),

                                                    const SizedBox(height: 24),
                                                    Row(
                                                      children: [
                                                        Text('Price range',
                                                            style:
                                                                st535353400Rubik15),
                                                        // Spacer(),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Text(
                                                        '${addCommaToString.format(_currentRangeValues.start)} - ${addCommaToString.format(_currentRangeValues.end)}',
                                                        style: st000000400Rubik14
                                                            .copyWith(
                                                                color: kc3DED97,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    RangeSlider(
                                                      values:
                                                          _currentRangeValues,
                                                      min: 1,
                                                      // max: 1000000,
                                                      max: 1000000000,
                                                      divisions: 1000000000,
                                                      activeColor: kc3DED97,
                                                      inactiveColor:
                                                          Color(0xffd4d4d4),
                                                      labels: RangeLabels(
                                                        _currentRangeValues
                                                            .start
                                                            .round()
                                                            .toString(),
                                                        _currentRangeValues.end
                                                            .round()
                                                            .toString(),
                                                      ),
                                                      onChanged:
                                                          (RangeValues values) {
                                                        setState(() {
                                                          _currentRangeValues =
                                                              values;
                                                          _priceRange =
                                                              '${_currentRangeValues.start.toStringAsFixed(0)}-${_currentRangeValues.end.toStringAsFixed(0)}';
                                                          // print(_currentRangeValues.start);
                                                          // print(_currentRangeValues.end);
                                                          // print(_priceRange);
                                                        });
                                                      },
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('1',
                                                              style:
                                                                  st535353400Rubik14),
                                                          Text('1,000,000,000',
                                                              style:
                                                                  st535353400Rubik14)
                                                        ],
                                                      ),
                                                    ),

                                                    // Column(
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment
                                                    //           .start,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Rooms',
                                                    //       style:
                                                    //           st535353400Rubik15,
                                                    //     ),
                                                    //     SizedBox(height: 15),
                                                    //     Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         roomsButton(
                                                    //             percent: 'Any',
                                                    //             selectedindex:
                                                    //                 4,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 4)),
                                                    //         roomsButton(
                                                    //             percent: '1',
                                                    //             selectedindex:
                                                    //                 5,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 5)),
                                                    //         roomsButton(
                                                    //             percent: '2',
                                                    //             selectedindex:
                                                    //                 6,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 6)),
                                                    //         roomsButton(
                                                    //             percent: '3+',
                                                    //             selectedindex:
                                                    //                 7,
                                                    //             roomIndex:
                                                    //                 roomIndex,
                                                    //             callback: () =>
                                                    //                 setRoomValue(
                                                    //                     25, 7)),
                                                    //       ],
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    // Column(
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment
                                                    //           .start,
                                                    //   children: [
                                                    //     Text(
                                                    //       'Bathrooms',
                                                    //       style:
                                                    //           st535353400Rubik15,
                                                    //     ),
                                                    //     SizedBox(height: 15),
                                                    //     Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .spaceBetween,
                                                    //       children: [
                                                    //         bathroomButton(
                                                    //             percent: 'Any',
                                                    //             selectedindex:
                                                    //                 1,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 1)),
                                                    //         bathroomButton(
                                                    //             percent: '1',
                                                    //             selectedindex:
                                                    //                 2,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 2)),
                                                    //         bathroomButton(
                                                    //             percent: '2',
                                                    //             selectedindex:
                                                    //                 3,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 3)),
                                                    //         bathroomButton(
                                                    //             percent: '3+',
                                                    //             selectedindex:
                                                    //                 4,
                                                    //             bathroomIndex:
                                                    //                 bathroomIndex,
                                                    //             callback: () =>
                                                    //                 setBathRoomValue(
                                                    //                     25, 4)),
                                                    //       ],
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    SizedBox(height: 20),

                                                    customButton('Filter', () {
                                                      // print('object1 $_selectedLocation');
                                                      // print('object2 $_priceRange');
                                                      // print('object3 $_propertyType');
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return FilterResultScreen(
                                                            // location: "162",
                                                            location:
                                                                '${pVm.selectedState.id}',
                                                            priceRange:
                                                                _priceRange,
                                                            propertyType:
                                                                _propertyType ??
                                                                    '',
                                                            filterPage:
                                                                'Property for Co-Own');
                                                      }));
                                                    },
                                                        isActive: pVm.selectedState ==
                                                                    null ||
                                                                _priceRange
                                                                    .isEmpty
                                                            // ||
                                                            //     _propertyType ==
                                                            //         null
                                                            ? false
                                                            : true),
                                                    // isActive: _priceRange
                                                    //     .isEmpty ||
                                                    //     _propertyType ==
                                                    //         null
                                                    //     ? false
                                                    //     : true),
                                                    SizedBox(height: 30),
                                                  ],
                                                )
                                              : RetryButton(
                                                  // orderType: 'buy'
                                                  title:
                                                      'Oops! Could not fetch location',
                                                  voidCallback: () {
                                                    pVm.getAvailableStates();
                                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}

Widget percentButton(
    {String percent,
    VoidCallback callback,
    int perecentIndex = 0,
    int selectedindex}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
        width: 100,
        height: 36,
        margin: EdgeInsets.only(bottom: 10),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: perecentIndex == selectedindex ? kc3DED97 : kcWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Color(0xFF969595))),
        child: Text(
          '$percent',
          style: st000000500Roboto14.copyWith(
              color: perecentIndex == selectedindex ? kcWhite : kc535353),
        )),
  );
}

Widget roomsButton(
    {String percent,
    VoidCallback callback,
    int roomIndex = 0,
    int selectedindex}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
        width: 73,
        height: 36,
        margin: EdgeInsets.only(bottom: 10),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: roomIndex == selectedindex ? kc3DED97 : kcWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Color(0xFF969595))),
        child: Text(
          '$percent',
          style: st000000500Roboto14.copyWith(
              color: roomIndex == selectedindex ? kcWhite : kc535353),
        )),
  );
}

Widget bathroomButton(
    {String percent,
    VoidCallback callback,
    int bathroomIndex = 0,
    int selectedindex}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
        width: 73,
        height: 36,
        margin: EdgeInsets.only(bottom: 10),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: bathroomIndex == selectedindex ? kc3DED97 : kcWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Color(0xFF969595))),
        child: Text(
          '$percent',
          style: st000000500Roboto14.copyWith(
              color: bathroomIndex == selectedindex ? kcWhite : kc535353),
        )),
  );
}
