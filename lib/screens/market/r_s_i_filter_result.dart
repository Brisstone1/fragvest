import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/property_by_type_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/market/rent_sale_invest_detail.dart';
import 'package:fragvest_mobile/widget/future_error_message_widget.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/invest_style_widget.dart';
import 'package:fragvest_mobile/widget/rent_style_widget.dart';
import 'package:fragvest_mobile/widget/sale_style_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../utilities/styles.dart';
import '../../widget/single_rsi_dialog_widget.dart';

class RSIFilterResult extends StatefulWidget {
  static const routeName = '/rsi-result';
  const RSIFilterResult({Key key}) : super(key: key);

  @override
  _RSIFilterResultState createState() => _RSIFilterResultState();
}

class _RSIFilterResultState extends State<RSIFilterResult> {
  @override
  Widget build(BuildContext context) {
    // String token = Provider.of<UserToken>(context, listen: false).userToken;

    ServiceProvider serviceProvider = context.watch<ServiceProvider>();

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kcF5f5f5.withOpacity(0.2),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Filter Result',
          style: stFFFFFF400Rubik14.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: GetServices.getPropertyBySingleFilter(
                  context, serviceProvider.rsiType),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return futureErrorMessage(
                      () => setState(() {}), snapshot.hasError.toString());
                } else if (!snapshot.hasData) {
                  return initialLoader(250);
                } else {
                  PropertyByTypeModel propertyByTypeModel = snapshot.data;
                  return propertyByTypeModel.data.length == 0
                      ? Center(
                          child: Text('Opps! No property found'),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: propertyByTypeModel.data.length,
                                  itemBuilder: (context, index) {
                                    final _rsiData =
                                        propertyByTypeModel.data[index];
                                    return GestureDetector(
                                      onTap: () {
                                        serviceProvider.setRsiData(_rsiData);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RentSaleInvestDetail(
                                                        _rsiData)));
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 190,
                                        decoration: BoxDecoration(
                                          color: kcWhite.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 120,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                      imageUrl: _rsiData
                                                          .propertyImages[0],
                                                      placeholder: (context,
                                                              url) =>
                                                          // CircularProgressIndicator(),
                                                          SpinKitCircle(
                                                              size: 30),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      fit: BoxFit.fill)),
                                            ),
                                            if (_rsiData.type == 'sale')
                                              SaleStyleWidget(
                                                  type: _rsiData.type,
                                                  price: _rsiData.costPrice,
                                                  tokenId: _rsiData.tokenId),
                                            if (_rsiData.type == 'invest')
                                              InvestStyleWidget(
                                                  type: _rsiData.type,
                                                  price: _rsiData.costPrice,
                                                  tokenId: _rsiData.tokenId),
                                            if (_rsiData.type == 'rent')
                                              RentStyleWidget(
                                                type: _rsiData.type,
                                                price: _rsiData.costPrice,
                                                tokenId: _rsiData.tokenId,
                                                propertyTpye:
                                                    _rsiData.propertyType,
                                              )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        );
                }
              })),
    );
  }

  _showFilter() {
    showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          final serviceProvder =
              Provider.of<ServiceProvider>(context, listen: false);
          serviceProvder.setPriceRange(null);
          serviceProvder.setRooms(null);
          serviceProvder.setBedRoom(null);
          return SinfleRSIDialogWidget();
        });
  }
}
