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

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verify-screen';
  const VerificationScreen({Key key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _preferredId;
  String _token;
  String _idType;

  bool _isPassport = true;
  bool _isSeleccted = false;
  bool _showFronImage = false;
  bool _isLoading = false;
  bool _isImageCompleted = false;

  bool isFrontIdCaptured = false;

  final ImagePicker _frontIdPicker = ImagePicker();
  XFile _frontImage;
  String _frontFileName;
  String _frontFilePath;
  String _retrieveDataErrorFront;

  final ImagePicker _backIdPicker = ImagePicker();
  XFile _backImage;
  String _backFileName;
  String _backFilePath;
  String _retrieveDataErrorBack;

  final _formKey = GlobalKey<FormState>();
  final _idTextController = TextEditingController();

  @override
  void initState() {
    _token = Provider.of<UserToken>(context, listen: false).userToken;
    super.initState();
  }

  _pickFrotId(ImageSource source) async {
    final image = await _frontIdPicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500);

    if (image != null) {
      print('Image taken');
      setState(() {
        _frontImage = image;
        _frontFileName = _frontImage.name;
        _frontFilePath = _frontImage.path;
      });

      ///TODO::: Save image to database
      setState(() {
        isFrontIdCaptured = true;
      });
      print('The file $_frontFileName');
      print('File path $_frontFilePath');
    }
  }

  _pickBackId(ImageSource source) async {
    // Navigator.pop(context);
    final backImage = await _backIdPicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500);

    if (backImage != null) {
      setState(() {
        _backImage = backImage;
        _backFileName = _backImage.name;
        _backFilePath = _backImage.path;
        _isImageCompleted = true;
      });

      ///TODO::: Save image to database
      print('The back file $_backImage');
      print('File back path $_backFilePath');
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
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> _retrieveLostDataBack() async {
    final LostDataResponse response = await _backIdPicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _backImage = response.file;
        });
      }
    } else {
      _retrieveDataErrorBack = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidgetBack() {
    if (_retrieveDataErrorBack != null) {
      final Text result = Text(_retrieveDataErrorBack);
      _retrieveDataErrorBack = null;
      return result;
    }
    return null;
  }

  Widget _previewImagesBack() {
    final Text retrieveError = _getRetrieveErrorWidgetBack();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_backImage != null) {
      return Center(
        child: Container(
            height: 100, width: 100, child: Image.file(File(_backFilePath))),
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  _uploadData() async {
    print('upload click');
    if (_formKey.currentState.validate()) {
      if ((_frontImage != null) || (_backImage != null)) {
        setState(() => _isLoading = true);
        final resposne = await PostServices.uploadId(
            token: _token,
            type: _idType,
            idNumber: _idTextController.text,
            frontImagePath: _frontImage,
            backImagepath: _backImage);
        setState(() => _isLoading = false);
        if (resposne is RepoSucess) {
          setState(() => _isLoading = false);
          showBottmModelShweet(context,
              'Your details has been uploaded successfully, verification in progress');
        } else {
          setState(() => _isLoading = false);
          flushbarWidget(
              context, (resposne as RepoFailure).errorMessage, false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('The image file $_backImage');
    return Scaffold(
      appBar: customAppBar('Verify', true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Provide a Government I.D', style: st535353600Rubik16),
                SizedBox(height: 10),
                Text(
                    'You are required to provide a government issued identification card (Int’l passport or National id.)',
                    style: st535353400Rubik14),
                SizedBox(height: 50),
                Text('Government issued ID( choose a preferred ID)',
                    style: st0C0932500Rubik14),
                SizedBox(height: 8),
                Container(
                  // padding: const EdgeInsets.only(left: 10),
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: kcF5f5f5)),
                  child: DropdownButtonFormField<String>(
                    value: _preferredId,
                    iconSize: 24,
                    icon: const Icon(Icons.arrow_drop_down),
                    hint: Text(
                      'select an option',
                      style: textfieldStyle,
                    ),
                    style: textfieldStyle,
                    decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Color(0xFFF5F5F8),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                        borderRadius: BorderRadius.circular(5.0),
                        //<-- SEE HERE
                      ),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                      contentPadding: EdgeInsets.all(10),
                    ),

                    onChanged: (String newValue) {
                      setState(() {
                        // _preferredId = newValue;
                        _isPassport = !_isPassport;
                        _isSeleccted = true;
                        _isImageCompleted = false;
                        _showFronImage = false;
                        isFrontIdCaptured = false;
                        _frontImage = null;
                        _backImage = null;
                        _idTextController.clear();
                      });
                      if (newValue == 'National ID') {
                        setState(() {
                          _idType = 'national_id';
                        });
                      } else if(newValue == 'Drivers Licence'){
                        setState(() {
                          _idType = 'Drivers_Licence';
                        });
                      }else {
                        setState(() {
                          _idType = 'passport_id';
                        });
                      }

                      print(_idType);
                    },
                    validator: (value) =>
                        value == null ? 'Field required' : null,
                    items: <String>['International passport', 'National ID', 'Drivers Licence']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: textfieldStyle),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 30),
                if (_isSeleccted)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_idType == "passport_id" ?
                           'Passport ID Number': _idType == "national_id"?
                           'National ID Number': "Drivers License ID Number"),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _idTextController,
                        decoration: borderTextInputDecoration,
                        onChanged: (String val) {
                          if (_idTextController.text.length > 0) {
                            setState(() {
                              _showFronImage = true;
                            });
                          } else {
                            _showFronImage = false;
                            _backImage = null;
                            _frontImage = null;
                            isFrontIdCaptured = false;
                          }
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Field required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                // if (_showFronImage)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text('Upload the front page of the ID',
                          style: st0C0932500Rubik14),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cameralButton(() => _pickFrotId(ImageSource.camera),
                              context, 'Take Photo', Icons.photo_camera, 0.35),
                          SizedBox(width: 5),
                          cameralButton(() => _pickFrotId(ImageSource.gallery),
                              context, 'Gallery', Icons.photo, 0.45)
                        ],
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<void>(
                        future: _retrieveLostDataFront(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Text(
                                'You have not yet picked an image.',
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
                                  'You have not yet picked an image.',
                                  textAlign: TextAlign.center,
                                );
                              }
                          }
                        },
                      )

                      // if (_frontImage != null)
                      //   Center(
                      //     child: Container(
                      //         height: 100,
                      //         width: 100,
                      //         child: Image.file(File(_frontFilePath))),
                      //   ),
                    ],
                  ),
                // if (isFrontIdCaptured)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Text('Upload the back page of the ID',
                          style: st0C0932500Rubik14),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cameralButton(() => _pickBackId(ImageSource.camera),
                              context, 'Take Photo', Icons.photo_camera, 0.35),
                          SizedBox(width: 20),
                          cameralButton(() => _pickBackId(ImageSource.gallery),
                              context, 'Gallery', Icons.photo, 0.45)
                        ],
                      ),

                      const SizedBox(height: 20),
                      FutureBuilder<void>(
                        future: _retrieveLostDataBack(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            case ConnectionState.done:
                              return _previewImagesBack();
                            default:
                              if (snapshot.hasError) {
                                return Text(
                                  'Pick image error: ${snapshot.error}}',
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                return const Text(
                                  '',
                                  textAlign: TextAlign.center,
                                );
                              }
                          }
                        },
                      )
                      // const SizedBox(height: 20),
                      // if (_backImage != null)
                      //   Center(
                      //     child: Container(
                      //         height: 100,
                      //         width: 100,
                      //         child: Image.file(File(_backFilePath))),
                      // ),
                    ],
                  ),
                SizedBox(height: 60),
                !_isImageCompleted
                    ? Container(
                        alignment: Alignment.center,
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kc3DED97.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('Submit', style: btnStyle),
                      )
                    : Material(
                        child: _isLoading
                            ? spinKitLoaderWidget()
                            : customButton('Submit', _uploadData)),
                // MaterialButton(
                //   onPressed: showModelShweet,
                //   child: Text('Data'),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
