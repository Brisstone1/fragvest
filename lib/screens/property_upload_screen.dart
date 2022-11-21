import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/property_repository.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';

import 'complete_property_upload.dart';

class PropertyUploadScreen extends StatefulWidget {
  const PropertyUploadScreen({Key key}) : super(key: key);

  @override
  _PropertyUploadScreenState createState() => _PropertyUploadScreenState();
}

class _PropertyUploadScreenState extends State<PropertyUploadScreen> {
  PropertyRepository propertyRepository = PropertyRepository();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  List<String> _properties = ["Choose type"];
  List<String> _detail = ["Choose detail"];
  String _selectedProperty = "Choose type";
  String _selectedDetail = "Choose detail";

  String _displayName = '';
  String _propertySelected = '';

  bool _isSelected = false;
  bool _isDetailSelected = false;
  bool _isPropertyDeSelected = false;
  bool _isTypeChange = true;

  @override
  void initState() {
    _properties = List.from(_properties)
      ..addAll(propertyRepository.getDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: propertyAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            print('object');
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text('Property Name', style: st0C0932500Rubik14),
                SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  decoration: borderTextInputDecoration.copyWith(
                      hintText: 'Enter a name for the property'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Field required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 35),
                Text('Type of property', style: st0C0932500Rubik14),
                SizedBox(height: 10),
                _container(
                  child: DropdownButtonFormField<String>(
                    iconSize: 24,
                    style: textfieldStyle,

                    icon: const Icon(Icons.arrow_drop_down),
                    // decoration: InputDecoration(border: InputBorder.none),

                    items: _properties.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) => _onSelectedProperty(value),
                    value: _selectedProperty,
                  ),
                ),
                SizedBox(height: 30),
                if (_isSelected)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_displayName, style: st0C0932500Rubik14),
                      SizedBox(height: 10),
                      _container(
                          child: DropdownButtonFormField<String>(
                        iconSize: 24,
                        style: textfieldStyle,
                        decoration: InputDecoration(border: InputBorder.none),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: _detail.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (value) => _onSelectedDetail(value),
                        value: _selectedDetail,
                      )),
                    ],
                  ),
                SizedBox(height: 60),
                if (_isDetailSelected && !_isTypeChange)
                  customButton('Next', () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CompletePropertyUpload(
                                name: _nameController.text,
                                type: _selectedProperty,
                                typeDetail: _selectedDetail,
                              )));
                    }
                  })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectedProperty(String value) {
    setState(() {
      _isTypeChange = true;
      _selectedDetail = "Choose $value";
      _detail = ["Choose $value"];
      _selectedProperty = value;
      _displayName = value;
      _propertySelected = value;
      _detail = List.from(_detail)
        ..addAll(propertyRepository.getProperties(value));
    });
    if (value == 'Choose type') {
      setState(() {
        _isSelected = false;
        _isPropertyDeSelected = false;
      });
    } else {
      setState(() {
        _isSelected = true;
        _isPropertyDeSelected = true;
      });
    }
  }

  void _onSelectedDetail(String value) {
    setState(
      () => _selectedDetail = value,
    );
    if (value == 'Choose Residential property' ||
        value == 'Choose Commercial property' ||
        value == 'Choose Industrial property') {
      setState(() {
        _isTypeChange = true;
        _isDetailSelected = true;
      });
    } else {
      setState(() {
        _isTypeChange = false;
        _isDetailSelected = false;
        _isDetailSelected = true;
      });
    }
  }
}

Widget _container({Widget child}) {
  return Container(
    padding: const EdgeInsets.only(left: 10),
    height: 45,
    decoration: BoxDecoration(
        color: Color(0xFFF5F5F8),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kcD6D6D6)),
    // color: Colors.red,
    child: child,
  );
}
