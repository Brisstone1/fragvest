import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/complete_signup_list_item.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/random_widget.dart';

import '../text_input_decoration.dart';
import 'package:intl/intl.dart';

class CompleteSingupTabThree extends StatefulWidget {
  const CompleteSingupTabThree({Key key}) : super(key: key);

  @override
  _CompleteSingupTabThreeState createState() => _CompleteSingupTabThreeState();
}

class _CompleteSingupTabThreeState extends State<CompleteSingupTabThree> {
  String _gender;
  String _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          TextFormField(
            decoration: colapseDecoration.copyWith(hintText: 'Full Name'),
          ),
          DropdownButtonFormField<String>(
            value: _gender,
            iconSize: 24,
            icon: arrowDropDown(),
            hint: dropdownhint('- Source of investment guidance -'),
            style: textfieldStyle,
            onChanged: (String newValue) {
              setState(() {
                _gender = newValue;
              });
            },
            items: gender.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: textfieldStyle),
              );
            }).toList(),
          ),
          Transform.translate(
            offset: Offset(0, 8),
            child: MaterialButton(
              onPressed: _presentDatePicker,
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  dropdownhint(_selectedDate == null
                      ? '- Select Date Of Birth -'
                      : _selectedDate),
                  Spacer(),
                  arrowDropDown()
                ],
              ),
            ),
          ),
          Divider(
            color: kc535353.withOpacity(0.4),
            thickness: 1,
          ),
          SizedBox(height: 20),
          Text(
            'Location',
            style: stBlack700Rubik13,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: colapseDecoration.copyWith(hintText: 'Country'),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: colapseDecoration.copyWith(hintText: 'State'),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: colapseDecoration.copyWith(hintText: 'City'),
          ),
        ],
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = DateFormat.yMMMMd().format(value);
        // _selectedDate = DateFormat.MMMEd().format(value);
      });
    });
  }
}
