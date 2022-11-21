import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/get_country_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/utilities/complete_signup_list_item.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/bottom_nav.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/random_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
// import ServiceProvider

class CompleteSignUpScreen extends StatefulWidget {
  static const routeName = '/complete-signup';
  const CompleteSignUpScreen({Key key}) : super(key: key);

  @override
  _CompleteSignUpScreenState createState() => _CompleteSignUpScreenState();
}

class _CompleteSignUpScreenState extends State<CompleteSignUpScreen> {
  String _employmentStatus;
  String _annualIncome;
  String _investmentGuide;
  String _investmentFamiliar;
  String _yearlyInvest;
  String _durationOfInvest;
  String _genger;
  String _countryID = '161';
  String _selectedDate;
  String _stateID;
  String _cityID;
  String _city;

  final _formKey = GlobalKey<FormState>();
  final _lastnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _posterController = TextEditingController();
  final _addressController = TextEditingController();

  String _token;

  int _cuurentTab = 0;

  bool _isLoading = false;
  bool _isCountrySelelcted = true;
  bool _isStateSelelcted = false;
  bool _isCitySelelcted = false;

  Future<Object> stateObject;

  void _nextButton() {
    if (_cuurentTab <= 3) {
      setState(() => _cuurentTab++);
      print(_cuurentTab);
    }
  }

  void _firstTabButton() {
    setState(() => _cuurentTab = 0);
  }

  void _secondTabButton() {
    setState(() => _cuurentTab = 1);
  }

  void _thirdTabButton() {
    setState(() => _cuurentTab = 2);
  }

  @override
  void initState() {
    _token = Provider.of<UserToken>(context, listen: false).userToken;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Complete your Signup',
                  style: TextStyle(
                      color: Color(0xFF0C0932),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 10),
              Container(
                // alignment: Alignment.centerRight,
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'Information collected are confidential and safe from outside sources.',
                  style: TextStyle(
                      color: Color(0xFF535353),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 5),

              // Divider(
              //   color: kc535353,
              //   thickness: 1,
              // ),
              // Row(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Transform.translate(
              //           offset: Offset(-15, 0),
              //           child: IconButton(
              //               icon: _iconButton(0), onPressed: _firstTabButton),
              //         ),
              //         Transform.translate(
              //             offset: Offset(-15, 0),
              //             child:
              //                 Text('Employment details', style: textfieldStyle))
              //       ],
              //     ),
              //     // SizedBox(width: 15),
              //     Row(
              //       children: [
              //         IconButton(
              //             icon: _iconButton(1), onPressed: _secondTabButton),
              //         Text(
              //           'Investment Experience',
              //           style: textfieldStyle,
              //         )
              //       ],
              //     )
              //   ],
              // ),
              Row(
                children: [
                  Transform.translate(
                    offset: Offset(-15, 0),
                    child: IconButton(
                        icon: _iconButton(2), onPressed: _thirdTabButton),
                  ),
                  Transform.translate(
                      offset: Offset(-15, 0), child: _stepTitle())
                ],
              ),

              SizedBox(height: 10),
              if (_cuurentTab == 0) _thridTabWidget(),
              if (_cuurentTab == 1) _secondTabWidget(),
              if (_cuurentTab == 2) _fistTabWidget(),
              if (_cuurentTab == 3)
                Column(
                  children: [
                    _fistTabWidget(),
                    _secondTabWidget(),
                    _thridTabWidget()
                  ],
                ),
              SizedBox(height: 40),
              _isLoading
                  ? spinKitLoaderWidget()
                  : customButton(
                      _cuurentTab < 2
                          ? 'Next'
                          : _cuurentTab == 2
                              ? 'Preview'
                              : 'Submit Change',
                      () => _cuurentTab <= 2 ? _nextButton() : _submitButton(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(int index) {
    int stage;

    setState(() {
      stage = _cuurentTab + 1;
    });

    // return Icon(
    //   _cuurentTab == index ? Icons.check : Icons.circle,
    //   size: 18,
    //   color: _cuurentTab == index ? kc6597F5 : kcC4C4C4,
    // );

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          color: Color(0xFF07C168),
          borderRadius: BorderRadius.all(Radius.circular(100))),
      alignment: Alignment.center,
      child: Text(
        "${stage}",
        style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _stepTitle() {
    String title;
    print(_cuurentTab);
    if (_cuurentTab == 0) {
      title = "Personnal Information";
    }
    if (_cuurentTab == 1) {
      title = "Investment Profile";
    }
    if (_cuurentTab == 2) {
      title = "Employment details";
    }
    if (_cuurentTab == 3) {
      title = "Preview";
    }
    return Container(
      child: Text(
        "${title}",
        style: TextStyle(
            color: Color(0xFF42C082),
            fontWeight: FontWeight.w500,
            fontSize: 14),
      ),
    );
  }

  Widget _fistTabWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('Select Employment Status', style: textfieldStyle),
        SizedBox(height: 10),
        SizedBox(
            height: 44,
            child: DropdownButtonFormField<String>(
              value: _employmentStatus,
              iconSize: 24,
              icon: Icon(Icons.arrow_drop_down),
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
              hint: dropdownhint('Select Employment Status'),
              // elevation: 16,
              style: textfieldStyle,
              onChanged: (String newValue) {
                setState(() {
                  _employmentStatus = newValue;
                });
              },
              validator: (value) => value == null ? 'Field required' : null,
              items: employment.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textfieldStyle),
                );
              }).toList(),
            )),
        SizedBox(height: 20),
        Text('Select Annual Income', style: textfieldStyle),
        SizedBox(height: 10),

        SizedBox(
            height: 44,
            child: DropdownButtonFormField<String>(
              value: _annualIncome,
              iconSize: 24,
              icon: Icon(Icons.arrow_drop_down),
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
              hint: dropdownhint('Select Annual income'),
              style: textfieldStyle,
              onChanged: (String newValue) {
                setState(() {
                  _annualIncome = newValue;
                });
              },
              validator: (value) => value == null ? 'Field required' : null,
              items: annualIncome.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textfieldStyle),
                );
              }).toList(),
            )),

        // InputDecorator(
        //   decoration: InputDecoration(
        //     filled: true, //<-- SEE HERE
        //     fillColor: Color(0xFFF5F5F8),
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: BorderSide(width: 5, color: Color(0xFFF5F5F8)),
        //       borderRadius: BorderRadius.circular(5.0),
        //       //<-- SEE HERE
        //     ),
        //     border: OutlineInputBorder(
        //         borderRadius: const BorderRadius.all(Radius.circular(4.0))),
        //     contentPadding: EdgeInsets.all(10),
        //   ),
        //   child: DropdownButtonHideUnderline(
        //     child: DropdownButton<String>(
        //       value: _genger,
        //       isDense: true,
        //       isExpanded: true,
        //       hint: dropdownhint('Gender'),
        //       items: [
        //         DropdownMenuItem(child: Text("Select Gender"), value: ""),
        //         DropdownMenuItem(child: Text("Male"), value: "Male"),
        //         DropdownMenuItem(child: Text("Female"), value: "Female"),
        //       ],
        //       onChanged: (newValue) {
        //         setState(() {
        //           _genger = newValue;
        //         });
        //       },
        //     ),
        //   ),
        // )
        // SizedBox(height: 10),
        // DropdownButtonFormField<String>(
        //   value: _investmentGuide,
        //   iconSize: 24,
        //   icon: Icon(Icons.arrow_drop_down),
        //   hint: dropdownhint('Source of investment guidance'),
        //   style: textfieldStyle,
        //   onChanged: (String newValue) {
        //     setState(() {
        //       _investmentGuide = newValue;
        //     });
        //   },
        //   validator: (value) => value == null ? 'Field required' : null,
        //   items: investGudiance.map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value, style: textfieldStyle),
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }

  Widget _secondTabWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('Investment Familiarity', style: textfieldStyle),
        SizedBox(height: 10),
        SizedBox(
            height: 44,
            child: DropdownButtonFormField<String>(
              value: _investmentFamiliar,
              iconSize: 24,
              icon: Icon(Icons.arrow_drop_down),
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
              hint: dropdownhint('Investment Familiarity'),
              // elevation: 16,
              style: textfieldStyle,
              onChanged: (String newValue) {
                setState(() {
                  _investmentFamiliar = newValue;
                });
              },
              validator: (value) => value == null ? 'Field required' : null,
              items: familiarity.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textfieldStyle),
                );
              }).toList(),
            )),
        SizedBox(height: 24),
        Text('Source of investment guidance', style: textfieldStyle),
        SizedBox(height: 10),
        SizedBox(
            height: 44,
            child: DropdownButtonFormField<String>(
              value: _investmentGuide,
              iconSize: 24,
              icon: Icon(Icons.arrow_drop_down),
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
              hint: dropdownhint('Source of investment guidance'),
              style: textfieldStyle,
              onChanged: (String newValue) {
                setState(() {
                  _investmentGuide = newValue;
                });
              },
              validator: (value) => value == null ? 'Field required' : null,
              items:
                  investGudiance.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textfieldStyle),
                );
              }).toList(),
            )),
        SizedBox(height: 24),
        Text('Yearly Investment', style: textfieldStyle),
        SizedBox(height: 10),
        SizedBox(
            height: 44,
            child: DropdownButtonFormField<String>(
              value: _yearlyInvest,
              iconSize: 24,
              icon: Icon(Icons.arrow_drop_down),
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
              hint: dropdownhint('Yearly Investment'),
              style: textfieldStyle,
              onChanged: (String newValue) {
                setState(() {
                  _yearlyInvest = newValue;
                });
              },
              validator: (value) => value == null ? 'Field required' : null,
              items: yearlyInvest.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textfieldStyle),
                );
              }).toList(),
            )),
        SizedBox(height: 24),
        Text('Duration of Investment', style: textfieldStyle),
        SizedBox(height: 10),
        SizedBox(
            height: 44,
            child: DropdownButtonFormField<String>(
              value: _durationOfInvest,
              iconSize: 24,
              icon: Icon(Icons.arrow_drop_down),
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
              hint: dropdownhint('Duration of Investment'),
              style: textfieldStyle,
              onChanged: (String newValue) {
                setState(() {
                  _durationOfInvest = newValue;
                });
              },
              validator: (value) => value == null ? 'Field required' : null,
              items: durationOfInvestment
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textfieldStyle),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _thridTabWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('First Name', style: textfieldStyle),
        SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: _firstnameController,

            // decoration: colapseDecoration.copyWith(hintText: 'First Name'),
            decoration: InputDecoration(
              hintText: "John",
              hintStyle: TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
              filled: true, //<-- SEE HERE
              fillColor: Color(0xFFF5F5F8),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                borderRadius: BorderRadius.circular(5.0),
                //<-- SEE HERE
              ),
            ),
            validator: (String val) {
              if (val.isEmpty) {
                return 'Field is required';
              }
              return null;
            },
          ),
        ),

        SizedBox(height: 24),
        Text('Last Name', style: textfieldStyle),
        SizedBox(height: 8),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: _lastnameController,
            decoration: InputDecoration(
              hintText: "Doe",
              hintStyle: TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
              filled: true, //<-- SEE HERE
              fillColor: Color(0xFFF5F5F8),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                borderRadius: BorderRadius.circular(5.0),
                //<-- SEE HERE
              ),
            ),
            // decoration: colapseDecoration.copyWith(hintText: 'Last Name'),

            validator: (String val) {

              if (val.isEmpty) {
                return 'Field is required';
              }
              return null;
            },
          ),
        ),

        SizedBox(height: 24),
        Text('Gender', style: textfieldStyle),
        SizedBox(height: 8),
        SizedBox(
            height: 44,
            child: DropdownButtonFormField<String>(
              value: _genger,
              iconSize: 24,
              icon: Icon(Icons.arrow_drop_down),
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
              hint: dropdownhint('Gender'),
              style: textfieldStyle,
              onChanged: (String newValue) {
                setState(() {
                  _genger = newValue;
                });
              },
              validator: (value) => value == null ? 'Field required' : null,
              items: gender.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textfieldStyle),
                );
              }).toList(),
            )),

        const SizedBox(height: 24),
        Text('Date of Birth', style: textfieldStyle),
        SizedBox(height: 8),
        SizedBox(
            height: 44,
            child: Transform.translate(
              offset: Offset(0, 8.5),
              child: MaterialButton(
                onPressed: _presentDatePicker,
                color: Color(0xFFF5F5F8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  // side: BorderSide(
                  //   color: Color(0xFFF5F5F8),
                  //   // width: 0.6,
                  // ),
                ),
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: dropdownhint(
                        _selectedDate == null ? 'xx/xx/xxxx' : _selectedDate,
                      ),
                    ),
                    Spacer(),
                    arrowDropDown()
                  ],
                ),
              ),
            )),
        // Divider(
        //   color: kc535353.withOpacity(0.4),
        //   thickness: 1,
        // ),
        // SizedBox(height: 20),
        // Text(
        //   'Location',
        //   style: stBlack700Rubik13,
        // ),
        SizedBox(height: 24),
        Text('Country', style: textfieldStyle),
        SizedBox(height: 8),
        FutureBuilder<Object>(
            future: GetServices.getCountries(context),
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
                          setState(() {
                            GetServices.getCountries(context);
                          });
                        },
                        child: Text(snapshot.error.toString()),
                      )
                    ],
                  ),
                );
              } else if (!snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: double.infinity,
                  child: SpinKitDancingSquare(
                    size: 40,
                    color: kc3DED97,
                  ),
                );
              } else {
                GetCountryModel countryMode = snapshot.data;
                final countryData = countryMode.data;

                // //Add Counrty into a new list
                // List<String> newCountry = [];
                // countryData.forEach((element) {
                //   newCountry.add('${element.id}' + ' ' + element.iso);
                // });

                return Container(
                  // padding: const EdgeInsets.only(left: 10),
                  height: 44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFFF5F5F8))),
                  child:
                    // SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Color(0xFFF5F5F8),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                          borderRadius: BorderRadius.circular(5.0),
                          //<-- SEE HERE
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0))),
                        contentPadding: EdgeInsets.all(10),

                      ),
                      value: _countryID,
                      iconSize: 24,
                      icon: Icon(Icons.arrow_drop_down),
                      hint: dropdownhint('Nigeria'),
                      style: textfieldStyle,
                      onChanged: (String newValue) {
                        setState(() {
                          _countryID = newValue;
                          // _countryID = newValue;
                          print('The country id $_countryID');
                          // _countryID = int.parse(_country.split(" ")[0]);
                          //
                          _isCountrySelelcted = true;
                          _isStateSelelcted = false;
                          // print('The country Id $_countryID');
                          // stateObject    GetServices.getStates(_token, _countryID);
                        });
                        // GetServices.getStates(_token, _countryID);
                      },
                      validator: (value) =>
                          value == null ? 'Field required' : null,
                      // items: newCountry
                      //     .map<DropdownMenuItem<String>>((String value) {
                      //   return DropdownMenuItem<String>(
                      //     value: value,
                      //     child: Text(value, style: textfieldStyle),
                      //   );
                      // }
                      items: countryData.map((mapCountry) {
                        return DropdownMenuItem<String>(
                          value: '${mapCountry.id}',
                          child: Text(mapCountry.iso, style: textfieldStyle),
                        );
                      }).toList(),
                    ),

                );
              }
            }),
        // SizedBox(height: 10),
        if (_isCountrySelelcted)
          FutureBuilder<Object>(
              // future: _isCountrySelelcted
              //     ? GetServices.getStates(_token, _countryID)
              //     : null,

              future: GetServices.getStates(_token, int.parse(_countryID)),
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
                    alignment: Alignment.center,
                    height: 40,
                    width: double.infinity,
                    child: SpinKitDancingSquare(
                      size: 40,
                      color: kc3DED97,
                    ),
                  );
                } else {
                  GetStateModel stateMode = snapshot.data;
                  final stateData = stateMode.data;

                  //Add Counrty into a new list
                  List<String> newState = [];
                  stateData.forEach((element) {
                    newState.add('${element.id}' + ' ' + element.name);
                  });
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Text('State', style: textfieldStyle),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true, //<-- SEE HERE
                          fillColor: Color(0xFFF5F5F8),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                            borderRadius: BorderRadius.circular(5.0),
                            //<-- SEE HERE
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(4.0))),
                          contentPadding: EdgeInsets.all(10),

                        ),
                        value: _stateID,
                        iconSize: 24,
                        icon: Icon(Icons.arrow_drop_down),
                        hint: dropdownhint('Select State'),
                        style: textfieldStyle,
                        onChanged: (String newValue) {
                          setState(() {
                            _stateID = newValue;
                            _isStateSelelcted = true;
                            // print(_stateId);
                            // _stateID = int.parse(_state.split(" ")[0]);
                            print('The state Id $_stateID');
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Field required' : null,
                        // items: newState
                        //     .map<DropdownMenuItem<String>>((dynamic value) {
                        //   return DropdownMenuItem<String>(
                        //     value: value,
                        //     child: Text(value, style: textfieldStyle),
                        //   );
                        // }).toList(),

                        items: stateData.map((mapState) {
                          return DropdownMenuItem<String>(
                            value: '${mapState.id}',
                            child: Text(mapState.name, style: textfieldStyle),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }
              }),
        SizedBox(height: 24),
        if (_isStateSelelcted)
          FutureBuilder<Object>(
              // future: _isCountrySelelcted
              //     ? GetServices.getStates(_token, _countryID)
              //     : null,

              future: GetServices.getCities(_token, int.parse(_stateID)),
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
                    alignment: Alignment.center,
                    height: 40,
                    width: double.infinity,
                    child: SpinKitDancingSquare(
                      size: 40,
                      color: kc3DED97,
                    ),
                  );
                } else {
                  GetCityModel cityModel = snapshot.data;
                  final cityData = cityModel.data;

                  //Add Counrty into a new list
                  // List<String> newCity = [];
                  // cityData.forEach((element) {
                  //   newCity.add('${element.id}' + ' ' + element.name);
                  // });
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Text('City', style: textfieldStyle),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true, //<-- SEE HERE
                          fillColor: Color(0xFFF5F5F8),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                            borderRadius: BorderRadius.circular(5.0),
                            //<-- SEE HERE
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(4.0))),
                          contentPadding: EdgeInsets.all(10),

                        ),
                        value: _city,
                        iconSize: 24,
                        icon: Icon(Icons.arrow_drop_down),
                        hint: dropdownhint('Select City'),
                        style: textfieldStyle,
                        onChanged: (String newValue) {
                          setState(() {
                            _city = newValue;
                            // print(_stateId);
                            // _cityID = int.parse(_city.split(" ")[0]);
                            print('The state Id $_cityID');
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Field required' : null,
                        // items: newCity
                        //     .map<DropdownMenuItem<String>>((dynamic value) {
                        //   return DropdownMenuItem<String>(
                        //     value: value,
                        //     child: Text(value, style: textfieldStyle),
                        //   );
                        // }).toList(),

                        // }
                        items: cityData.map((mapCity) {
                          return DropdownMenuItem<String>(
                            value: '${mapCity.id}',
                            child: Text(mapCity.name, style: textfieldStyle),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }
              }),
        SizedBox(height: 24),
        Text('Postal Code', style: textfieldStyle),
        SizedBox(height: 8),
        SizedBox(
            height: 44,
            child: TextFormField(
              controller: _posterController,
              decoration: InputDecoration(
                hintText: "XXXX",
                hintStyle: TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
                filled: true, //<-- SEE HERE
                fillColor: Color(0xFFF5F5F8),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                  borderRadius: BorderRadius.circular(5.0),
                  //<-- SEE HERE
                ),
              ),
              // decoration: colapseDecoration.copyWith(hintText: 'postal code'),
              validator: (String val) {
                if (val.isEmpty) {
                  return 'Field is required';
                }
                return null;
              },
            )),
        SizedBox(height: 24),
        Text('Address', style: textfieldStyle),
        SizedBox(height: 8),

        SizedBox(
            height: 44,
            child: TextFormField(
              controller: _addressController,
              decoration: colapseDecoration.copyWith(hintText: 'Address'),
              validator: (String val) {
                if (val.isEmpty) {
                  return 'Field is required';
                }
                return null;
              },
            )),
      ],
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
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

  _submitButton() async {
    if (_formKey.currentState.validate()) {
      if (_selectedDate == null) {
        flushbarWidget(context, 'Please pick data of birth', false);
      }

      setState(() {
        _isLoading = true;
      });
      final response = await PostServices.completeRegistration(
          context: context,
          employmentStatus: _employmentStatus,
          annualIncome: _annualIncome,
          investmentFamiliarity: _investmentFamiliar,
          sourceOfInvestmentAdvice: _investmentGuide,
          yearlyInvestment: _yearlyInvest,
          durationOfInvestment: _durationOfInvest,
          gender: _genger,
          dateOfBirth: _selectedDate,
          firstName: _firstnameController.text,
          lastName: _lastnameController.text,
          countryId: 161,
          posterCode: _posterController.text,
          address: _addressController.text);

      setState(() {
        _isLoading = false;
      });

      if (response is LogSucess) {
        flushbarWidget(context, response.message, true);
        Navigator.of(context).pushNamedAndRemoveUntil(
            BottomNav.routeName, (Route<dynamic> route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
        flushbarWidget(context, (response as LogFailure).errorMessage, false);
      }
    }
  }
}
