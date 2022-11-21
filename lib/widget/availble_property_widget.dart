import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/all_properties_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/market/property_detail.dart';
import 'package:fragvest_mobile/widget/rent_style_widget.dart';
import 'package:fragvest_mobile/widget/sale_style_widget.dart';
import 'package:provider/provider.dart';
import 'invest_style_widget.dart';
import 'package:google_fonts/google_fonts.dart';import 'package:fragvest_mobile/widget/card_summary.dart';
class AvailablePropertyWidget extends StatefulWidget {
  @required
  final bool scrowable;
  @required
  final bool isShowAll;
  const AvailablePropertyWidget({Key key, this.scrowable, this.isShowAll})
      : super(key: key);

  @override
  State<AvailablePropertyWidget> createState() =>
      _AvailablePropertyWidgetState();
}

class _AvailablePropertyWidgetState extends State<AvailablePropertyWidget> {
  ServiceProvider serviceProvider;



  @override
  void didChangeDependencies() {
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.setAllProerty(true);
    // serviceProvider.setGetProperty(
    //     GetServices.getProperty(context, serviceProvider.allProperty, 'all'));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: GetServices.getAllProperty(context),
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
                    child: Text(snapshot.error.toString() ==
                                'Connection closed while receiving data' ||
                            snapshot.error.toString() ==
                                'Connection closed before full header was received'
                        ? 'Check internet connection'
                        : snapshot.error.toString()),
                  )
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return Container(
              // height: 250,
              alignment: Alignment.center,
              child: SpinKitSpinningLines(
                color: kc3DED97,
              ),
            );
          } else {
            AllPropertiesModel allPropertiesModel = snapshot.data;

            return allPropertiesModel.data.isEmpty
                ? Center(child: Text('No available property yet!'))
                : Container(
              // height: 100,
              //       color: Colors.blue,
                    child: GridView.builder(
                      physics: widget.scrowable
                          ? BouncingScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.isShowAll
                          ? allPropertiesModel.data.length
                          : allPropertiesModel.data.take(5).length,
                      itemBuilder: (context, index) {
                        final _propertyData = allPropertiesModel.data[index];
                        final width = MediaQuery.of(context).size.width * 0.41;
                        return GestureDetector(
                            onTap: () {
                              serviceProvider.setPropertyData(_propertyData);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PropertyDetail(_propertyData)));
                            },
                            child: cardSummary(
                                propertyImages: _propertyData.propertyImages,
                                type: _propertyData.type,
                                propertyType: _propertyData.propertyType,
                                state: _propertyData.state,
                                costPrice: _propertyData.costPrice,
                                invested: _propertyData.fragPrice,
                                width: width,
                                isShopping: true,
                                availableFrag: _propertyData?.propertyStats?.availableFrags
                            )

                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // childAspectRatio: 4 / 5,
                        mainAxisExtent: 206,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ));
          }
        });
  }
}
