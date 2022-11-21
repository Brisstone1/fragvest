import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/screens/market/property_detail.dart';
import 'package:provider/provider.dart';
import '../../constants/kcolors.dart';
import '../../model/all_properties_model.dart';
import '../../provider/service_provider.dart';
import '../../repository/get_services.dart';
import '../../utilities/styles.dart';
import '../../widget/invest_style_widget.dart';
import '../../widget/rent_style_widget.dart';
import '../../widget/sale_style_widget.dart';

class FilterResultScreen extends StatefulWidget {
  final String location;
  final String priceRange;
  final String propertyType;
  final String filterPage;
  const FilterResultScreen(
      {Key key,
      @required this.location,
      @required this.priceRange,
      @required this.propertyType,
      @required this.filterPage})
      : super(key: key);
  static const routeName = '/filter-result';

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  ServiceProvider serviceProvider;
  bool _isClearFilter = false;

  @override
  void initState() {
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kcF5f5f5.withOpacity(0.2),
        elevation: 0,
        toolbarHeight: 10,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<Object>(
          future: GetServices.getFilteredProperty(
              context, widget.priceRange, widget.propertyType, widget.location),
          // GetServices.getPropertyByFilter(context, serviceProvider.rsiType),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: kc3DED97,
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(snapshot.error.toString()),
                    )
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Container(
                height: 250,
                alignment: Alignment.center,
                child: SpinKitSpinningLines(
                  color: kc3DED97,
                ),
              );
            } else {
              AllPropertiesModel allPropertiesModel = snapshot.data;

              return allPropertiesModel.data.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Opps! No property found'),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.keyboard_return),
                              label: Text('Back'))
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.arrow_back)),
                            Text(
                              "${widget.filterPage}",
                              style:
                                  st535353600Rubik16.copyWith(color: kc0C0932),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MaterialButton(
                                color: kc3DED97,
                                onPressed: (() => setState(
                                      () => _isClearFilter = true,
                                    )),
                                child: Text(
                                  'Clear Filter',
                                  style: stFFFFFF400Rubik14,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              _isClearFilter
                                  ? 'No result'
                                  : '${allPropertiesModel.data.length} result',
                              style: st0C0932500Rubik14.copyWith(
                                  color: Color(0xFF969595),
                                  fontWeight: FontWeight.w500)),
                        )
                        ,
                        _isClearFilter
                            ? Container(
                                // color: Colors.red,
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.60,
                                child: Text('Filter result cleared'),
                              )
                            : Expanded(
                                child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: allPropertiesModel.data.length,
                                  itemBuilder: (context, index) {
                                    final _propertyData =
                                        allPropertiesModel.data[index];

                                    // print(_propertyData.costPrice);
                                    // print("JOYY IBBBINI");
                                    // print(_propertyData.type);
                                    // print("JOYY IBBBINI");
                                    // print(_propertyData.roi);
                                    // print("JOYY IBBBINI");
                                    // print(_propertyData.tokenId);
                                    // type: _propertyData?.type,
                                    // price:
                                    // _propertyData?.costPrice,
                                    // tokenId:
                                    // _propertyData?.tokenId,
                                    // rio: _propertyData?.roi,
                                    // serviceProvider
                                    //     .setPropertyData(_propertyData);
                                    // final status = 'Inevst';
                                    return GestureDetector(
                                        onTap: () {
                                          serviceProvider
                                              .setPropertyData(_propertyData);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PropertyDetail(
                                                          _propertyData)));

                                          // Navigator.of(context).pushNamed(
                                          //   PropertyDetail.routeName,
                                          // );
                                        },
                                        // child: PropertyTemplateTwo()
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            width: 165,
                                            height: 206,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: Color(0xFFBDBDBD))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 112,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                          child: CachedNetworkImage(
                                                              imageUrl:
                                                                  _propertyData
                                                                          .propertyImages[
                                                                      0],
                                                              placeholder: (context,
                                                                      url) =>
                                                                  CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    ),
                                                    Positioned(
                                                      top: 10,
                                                      right: 10,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 12,
                                                                vertical: 4),
                                                        decoration: BoxDecoration(
                                                            color: kcWhite,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Text(
                                                          _propertyData.type ==
                                                                  'invest'
                                                              ? 'Co-owned'
                                                              : _propertyData
                                                                          .type ==
                                                                      'rent'
                                                                  ? 'Rented'
                                                                  : _propertyData
                                                                      .type,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF07C168)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                if (_propertyData.type ==
                                                    'sale')
                                                  SaleStyleWidget(
                                                      type: _propertyData.type,
                                                      price: _propertyData
                                                          .costPrice,
                                                      tokenId: _propertyData
                                                          .tokenId),
                                                if (_propertyData.type ==
                                                    'invest')
                                                  InvestStyleWidget(
                                                    type: _propertyData?.type,
                                                    price: _propertyData
                                                        ?.costPrice,
                                                    tokenId:
                                                        _propertyData?.tokenId,
                                                    rio: _propertyData?.roi,
                                                    state: _propertyData?.state,
                                                    propertyType: _propertyData
                                                        ?.propertyType,
                                                  ),
                                                if (_propertyData.type ==
                                                    'rent')
                                                  RentStyleWidget(
                                                      type: _propertyData.type,
                                                      price: _propertyData
                                                          .costPrice,
                                                      tokenId:
                                                          _propertyData.tokenId,
                                                      propertyTpye:
                                                          _propertyData
                                                              .propertyType)
                                              ],
                                            )));
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    // childAspectRatio: 4 / 5,
                                    mainAxisExtent: 206,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                ),
                              )),
                      ],
                    );
            }
          }),
    );
  }
}
