import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowGoogleMap extends StatefulWidget {
  final double lat;
  final double log;

  const ShowGoogleMap({Key key, @required this.lat, @required this.log})
      : super(key: key);
  @override
  State<ShowGoogleMap> createState() => ShowGoogleMapState();
}

class ShowGoogleMapState extends State<ShowGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  Marker _origin;
  Marker _destination;

  bool _showMapType = false;
  MapType mapType = MapType.normal;
  int index1;
  int index2;
  int index3;
  int index4;
  int index5;

  @override
  Widget build(BuildContext context) {
    // ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    // final _propertyDetial = serviceProvider.propertyData;

    // double lat = 23.34;

    final CameraPosition _getGoogleMap = CameraPosition(
        bearing: 192.8334901395799,
        // target: LatLng(45.521563, -122.677433),
        target: LatLng(widget.lat, widget.log),
        // zoom: 14.4746,
        zoom: 11.0);
    return Container(
      height: 230,
      child: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            trafficEnabled: true,
            buildingsEnabled: true,
            mapType: mapType,
            initialCameraPosition: _getGoogleMap,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination,
            },
            onLongPress: _addMarker,
          ),
          Positioned(
              top: 3,
              left: 50,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showMapType = !_showMapType;
                      });
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.white54,
                        radius: 17,
                        child: Icon(
                          !_showMapType
                              ? Icons.hide_image_sharp
                              : Icons.published_with_changes,
                          color: Colors.red,
                        )),
                  ),
                  if (!_showMapType)
                    Wrap(children: [
                      SizedBox(width: 6),
                      Container(
                        height: 25,
                        child: _mapType('None', index1, () {
                          setState(() {
                            mapType = MapType.none;
                            index1 = 1;
                            index2 = 0;
                            index3 = 0;
                            index4 = 0;
                            index5 = 0;
                          });
                        }),
                      ),

                      SizedBox(width: 5),
                      Container(
                          height: 25,
                          child:_mapType('Normal', index2, () {
                            setState(() {
                              mapType = MapType.normal;
                              index1 = 0;
                              index2 = 1;
                              index3 = 0;
                              index4 = 0;
                              index5 = 0;
                            });
                          })
                      )
                      ,
                      SizedBox(width: 5),
                      Container(
                          height: 25,
                          child:_mapType('Hybrid', index3, () {
                            setState(() {
                              mapType = MapType.hybrid;
                              index1 = 0;
                              index2 = 0;
                              index3 = 1;
                              index4 = 0;
                              index5 = 0;
                            });
                          })
                      )
                      ,
                      SizedBox(width: 5),
                      Container(
                          height: 25,
                          child:_mapType('Satellite', index4, () {
                            setState(() {
                              mapType = MapType.satellite;
                              index1 = 0;
                              index2 = 0;
                              index3 = 0;
                              index4 = 1;
                              index5 = 0;
                            });
                          })
                      )
                      ,
                      SizedBox(width: 5),
                      Container(
                          height: 25,
                          child:_mapType('Terrian', index5, () {
                            setState(() {
                              mapType = MapType.terrain;
                              index1 = 0;
                              index2 = 0;
                              index3 = 0;
                              index4 = 0;
                              index5 = 1;
                            });
                          })
                      )
                      ,
                    ])
                ],
              )),
          Positioned(
              top: 60,
              right: 0,
              child: IconButton(
                onPressed: () {
                  CameraUpdate.newCameraPosition(_getGoogleMap);
                },
                icon: Icon(Icons.center_focus_strong),
              ))
        ],
      ),
    );
  }

  Widget _mapType(String txt, int index, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 20,
        color: index == 1 ? Colors.green : Colors.white,
        child: Text(
          txt,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }

  void _addMarker(LatLng argument) {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: argument);
        _destination = null;
      });
    } else {
      setState(() {
        _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: argument);
        // _destination =null;
      });
    }
  }
}
