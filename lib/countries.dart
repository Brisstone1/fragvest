import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key key}) : super(key: key);

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  bool _isVisible = false;

  _changeVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      print(_isVisible);
    });
  }

  //Create empty list
  int numOfClick = 0;
  _getListLength() {
    setState(() {
      numOfClick = numOfClick + 1;
      print(numOfClick);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          TextFormField(
            obscureText: !_isVisible,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () => _changeVisibility(),
                    icon: Icon(!_isVisible
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),
          SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _indicator(
                      color: numOfClick >= 1 ? Colors.red : Colors.white),
                  _indicator(
                      color: numOfClick >= 2 ? Colors.red : Colors.white),
                  _indicator(color: numOfClick >= 3 ? Colors.red : Colors.white)
                ],
              ),
              numOfClick >= 3
                  ? CupertinoActivityIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customButton('1'),
                        customButton('2'),
                        customButton('3'),
                        customButton('4')
                      ],
                    ),
              // customButton()
            ],
          )
        ]));
  }

  Widget customButton(String text) {
    return GestureDetector(
      onTap: () => _getListLength(),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.black)),
        child: Text(text),
      ),
    );
  }

  Widget _indicator({Color color}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black)),
    );
  }
}

class Countries {
  final String name;
  final int code;
  final String flagColor;

  Countries(this.name, this.code, this.flagColor);
}

List<Countries> countries = [
  Countries('Nigeria', 234, 'Green and White'),
  Countries('Ghana', 345, 'Black and Yello'),
  Countries('USA', 190, 'Blue and Red'),
  Countries('London', 876, 'White'),
];
