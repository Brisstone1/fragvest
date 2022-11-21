import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/utilities/complete_signup_list_item.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/bottom_nav.dart';
import 'package:fragvest_mobile/widget/camera_button.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/sucess_bottom_modal_sheet.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
// import 'package:flutter_camera_practice/camera_page.dart';
import 'package:fragvest_mobile/widget/camera_snap_button.dart';
// import 'package:camera/camera.dart';
// ll
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/camera_button.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/sucess_bottom_modal_sheet.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum OutRightOwner { Yes, No }

class CompletePropertyUpload extends StatefulWidget {
  final String name;
  final String type;
  final String typeDetail;
  CompletePropertyUpload({this.name, this.type, this.typeDetail});

  @override
  _CompletePropertyUploadState createState() => _CompletePropertyUploadState();
}

class _CompletePropertyUploadState extends State<CompletePropertyUpload> {
  bool _isLoading = false;
  String _token;
  final ImagePicker _imagePicker = ImagePicker();
  XFile _image;
  String _fileName;
  String _filePath;
  String _retrieveDataError;
  String _rightOwner = '1';
  // dynamic _pickImageError;
  List<XFile> _imageFileList;

  int _currentIndex;
  final ImagePicker _frontIdPicker = ImagePicker();
  bool isFrontIdCaptured = false;
  XFile _frontImage;
  String _frontFileName;
  String _frontFilePath;
  String _retrieveDataErrorFront;

  OutRightOwner _radioValue = OutRightOwner.Yes;

  List<String> _selectedList = [];

  final _formkey = GlobalKey<FormState>();
  final _selectedController = TextEditingController();
  final _priceController = TextEditingController();
  final _propertyDetailController = TextEditingController();
  final _locationController = TextEditingController();

  final _longCodinateController = TextEditingController();
  final _latCodinateController = TextEditingController();

  String _prpertyDetail;
  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  @override
  void initState() {
    _token = Provider.of<UserToken>(context, listen: false).userToken;

    super.initState();
  }

  _pickImage() async {
    // Navigator.pop(context);

    final pickedFileList =
    await _imagePicker.pickMultiImage(maxHeight: 500, maxWidth: 500);

    if (pickedFileList != null) {
      setState(() {
        _imageFileList = pickedFileList;

        // _imageFileList.addAll(pickedFileList);
        // print('The lenght is $_imageFileList');

        // _imageFileList.forEach((e) => e.addAll(pickedFileList));
        // _image = image;
        // _fileName = _image.name;
        // _filePath = _image.path;
      });

      ///TODO::: Save image to database
      // _imageFileList.forEach((e) => print('The path ${e.path}'));
      // print('The file $_image');
      // print('File path $_imageFileList');
    }
  }

  _pickFrotId(ImageSource source) async {
    final image = await _frontIdPicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500);

    if (image != null) {
      print('Image taken okllllll ${image}');
      setState(() {
        _frontImage = image;
        _frontFileName = _frontImage.name;
        _frontFilePath = _frontImage.path;
        // _imageFileList = _frontImage.path;
      });

      print('lalala ala');

      var myList = new List(1);

      // // List<dynamic> myList;
      // print('lalala 2');
      // myList[0] = _frontFilePath;
      // // _imageFileList = myList;
      // print('lalala 3');
      //
      // setState(() {
      //   _imageFileList = myList;
      // });

      ///TODO::: Save image to database
      setState(() {
        isFrontIdCaptured = true;
      });
      print('The file----- $_frontFileName');
      print('File path $_frontFilePath');
    }
  }

  Future<void> _retrieveLostData() async {
    final LostDataResponse response = await _imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _image = response.file;
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }


  Future<void> _retrieveLostDataFront() async {
    final LostDataResponse response = await _frontIdPicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _frontImage = response.file;
        });
      }
    } else {
      _retrieveDataErrorFront = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Text _getRetrieveErrorWidgetFront() {
    if (_retrieveDataErrorFront != null) {
      final Text result = Text(_retrieveDataErrorFront);
      _retrieveDataErrorFront = null;
      return result;
    }
    return null;
  }

  Widget _previewImagesFront() {
    final Text retrieveError = _getRetrieveErrorWidgetFront();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_frontImage != null) {
      return Center(
        child: Container(
            height: 100, width: 100, child: Image.file(File(_frontFilePath))),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImages() {
    // final Text retrieveError = _getRetrieveErrorWidget();
    // if (retrieveError != null) {
    //   return retrieveError;
    // }
    // if (_image != null) {
    //   return Center(
    //     child: Container(
    //         height: 100, width: 100, child: Image.file(File(_filePath))),
    //   );
    // } else {
    //   return const Text(
    //     'You have not yet picked an image.',
    //     textAlign: TextAlign.center,
    //   );
    // }
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          key: UniqueKey(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                // GestureDetector(
                //   onTap: () {
                //     print('object');
                //     setState(() {
                //       _currentIndex = index;
                //       if (_currentIndex == index && _currentIndex != null) {
                //         _imageFileList.removeAt(index);
                //       }
                //       //
                //     });
                //   },
                //   child: CircleAvatar(
                //     radius: 10,
                //     backgroundColor: Colors.grey.withOpacity(0.5),
                //     child: Icon(Icons.clear, color: kcWhite, size: 14),
                //   ),
                // ),
                const SizedBox(height: 2),
                Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 80,
                    child: Image.file(File(_frontFilePath))),
              ],
            );
          },
          itemCount: _imageFileList.length,
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  _uploadProperty() async {
    // print(_priceController.text);
    // print(_priceController.text.replaceAll(',', ''));

    if (_formkey.currentState.validate()) {
      setState(() => _isLoading = true);
      final response = await PostServices.uploadProperty(
          token: _token,
          name: widget.name,
          type: widget.type,
          propertyDetail: _prpertyDetail,
          location: _locationController.text,
          longCoordinate: double.tryParse(_longCodinateController.text),
          latCoordinate: double.tryParse(_latCodinateController.text),
          propertyImages: _imageFileList,
          owner: _rightOwner,
          price: _priceController.text.replaceAll(',', ''),
          typeDetail: widget.typeDetail);

      print(response);
      print('--------------');

      setState(() => _isLoading = false);
      if (response is RepoSucess) {
        setState(() => _isLoading = false);
        showBottmModelSheetCustomNaav(
            context, 'Property uploaded successfully!', () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(BottomNav.routeName, (route) => false);
        });
      } else {
        setState(() => _isLoading = false);
        flushbarWidget(context, (response as RepoFailure).errorMessage, false);
      }
    }
  }

  Color getColor(Set<MaterialState> states) {
    return kc3DED97;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Register Property', true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _seperator('Input selling price'),
              _materialWidget(
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsFormatter()
                  ],
                  style: st535353700Rubik14,
                  decoration: borderTextInputDecoration.copyWith(
                      border: InputBorder.none,
                      prefixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        width: 40,
                        decoration: BoxDecoration(
                            border:
                            Border(right: BorderSide(color: Colors.grey))),
                        child: Image.asset(
                          imgNaira,
                          color: kcC9C9C9,
                        ),
                      )),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Field is required';
                    }
                    return null;
                  },
                ),
              ),
              _seperator('Property details'),
              _materialWidget(
                SearchField(
                    controller: _selectedController,
                    suggestions: suggestedSerchItem,
                    validator: (v) {
                      if (_selectedList.length < 0) {
                        return 'Please select property detail';
                      }
                      return null;
                    },
                    onTap: (String val) {
                      setState(() {
                        _selectedList.add(_selectedController.text);
                        _prpertyDetail = _selectedList.join(',');
                        _selectedController.clear();
                        print(_prpertyDetail);
                      });

                      // for(int i; i<=_selectedList.length; i++){
                      //   if
                      // }
                      // var contain = _selectedList.where(
                      //   (element) => element == _selectedController.text,
                      // );
                      // if (contain.isEmpty) {
                      //   print('No');
                      // } else {
                      //   print('Yes');
                      // }

                      // _selectedList.forEach((e) {
                      //   print(_selectedList);
                      //   if (e == e) {
                      //     print('$e exist');
                      //   } else {
                      //     print('$e not exist');
                      //     // _selectedList.add(_selectedController.text);
                      //     // detail = _selectedList.join(',');
                      //     // _selectedController.clear();
                      //     // print(detail);
                      //   }
                      // });
                    },
                    searchStyle: st535353700Rubik13,
                    suggestionStyle: st535353700Rubik13,
                    searchInputDecoration: noBorderDecoration),
              ),
              SizedBox(height: 20),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8.0,
                runSpacing: 10.0,
                children: _selectedList
                    .map(
                      (e) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: kc535353.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(e),
                        IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _selectedList.remove(e);
                              });
                            })
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),
              _seperator('Location of property'),
              _materialWidget(
                TextFormField(
                    controller: _locationController,
                    // keyboardType: TextInputType.number,
                    style: st535353700Rubik14,
                    decoration: noBorderDecoration,
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    }),
              ),
              _seperator('Upload Images of property'),
              Row(
                children: [
                  // cameralButton(() => _pickImage(ImageSource.camera), context,
                  //     'Take Photo', Icons.photo_camera, 0.35),
                  // SizedBox(width: 20),
                  cameralButton(() => _pickImage(), context,
                      'Gallery', Icons.photo, 0.5),
                  SizedBox(width: 5),
                  cameralButton(() => _pickFrotId(ImageSource.camera), context,
                      'Take Photo', Icons.photo_camera, 0.35),

                  // SizedBox(width: 20),
                  // Container(
                  //   child: Column(
                  //     children: [
                  //       ElevatedButton(
                  //         onPressed: () async {
                  //           await availableCameras().then((value) =>
                  //               Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (_) =>
                  //                           CameraPage(cameras: value))));
                  //         },
                  //       ),
                  //       Text('camera')
                  //     ],
                  //   ),
                  // )
                ],
              ),
              // Container(
              //   child: Column(
              //     children: [
              //       ElevatedButton(
              //         onPressed: () async {
              //           await availableCameras().then((value) =>
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (_) =>
              //                           CameraPage(cameras: value))));
              //         },
              //       ),
              //       Text('camera')
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              FutureBuilder<void>(
                future: _retrieveLostDataFront(),
                builder: (BuildContext context,
                    AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'You have not yet picked an  CAMERA image.',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return _previewImagesFront();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an CAMERA image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              ),
              // FutureBuilder<void>(
              //   future: _retrieveLostData(),
              //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              //     switch (snapshot.connectionState) {
              //       case ConnectionState.none:
              //       case ConnectionState.waiting:
              //         return const Text(
              //           'You have not yet picked an image.',
              //           textAlign: TextAlign.center,
              //         );
              //       case ConnectionState.done:
              //         return _previewImages() ;
              //       default:
              //         if (snapshot.hasError) {
              //           return Text(
              //             'Pick image error: ${snapshot.error}}',
              //             textAlign: TextAlign.center,
              //           );
              //         } else {
              //           return const Text(
              //             'You have not yet picked an image.',
              //             textAlign: TextAlign.center,
              //           );
              //         }
              //     }
              //   },
              // ),
              _seperator('Google co-ordinates (optional)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: _materialWidget(
                      TextFormField(
                          controller: _longCodinateController,
                          keyboardType: TextInputType.number,
                          style: st535353700Rubik14,
                          decoration: borderTextInputDecoration.copyWith(
                              border: InputBorder.none,
                              prefixIcon: _letter('N')),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Field is required';
                            }
                            return null;
                          }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: _materialWidget(
                      TextFormField(
                          controller: _latCodinateController,
                          keyboardType: TextInputType.number,
                          style: st535353700Rubik14,
                          decoration: borderTextInputDecoration.copyWith(
                              border: InputBorder.none,
                              prefixIcon: _letter('E')),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Field is required';
                            }
                            return null;
                          }),
                    ),
                  ),
                ],
              ),
              _seperator('Are you the outright owner of this property'),
              Row(
                children: [
                  Radio(
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: OutRightOwner.Yes,
                      groupValue: _radioValue,
                      onChanged: (OutRightOwner val) {
                        setState(() {
                          _rightOwner = '1';
                          _radioValue = val;
                        });
                        print(_radioValue);
                      }),
                  Text('Yes'),
                  SizedBox(width: 40),
                  Radio(
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: OutRightOwner.No,
                      groupValue: _radioValue,
                      onChanged: (OutRightOwner val) {
                        setState(() {
                          _rightOwner = '0';
                          _radioValue = val;
                        });
                      }),
                  Text('No')
                ],
              ),
              SizedBox(height: 40),
              _isLoading
                  ? spinKitLoaderWidget()
                  : customButton('Proceed', _uploadProperty)
            ],
          ),
        ),
      ),
    );
  }

  Widget _seperator(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(text, style: st0C0932500Rubik14),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _materialWidget(Widget widget) {
    return Material(
        elevation: 5, shadowColor: kcWhite.withOpacity(0.9), child: widget);
  }

  Widget _letter(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      width: 40,
      decoration:
      BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
      child: Text(text, style: st535353400Rubik12),
    );
  }
}
