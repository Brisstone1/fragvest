import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/screens/tour/tour_fee_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/dommy_avater_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TourScreen extends StatefulWidget {
  final List<String> availableDate;
  final List<int> availableTime;
  final String email;
  final String phone;
  final int propertyId;

  const TourScreen(this.availableDate, this.availableTime, this.email,
      this.phone, this.propertyId);
  @override
  _TourScreenState createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  bool _isChecked = false;
  int _selectedTime;

  String dateSelect;
  String daySelected;
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberContorller = TextEditingController();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    return Scaffold(
        appBar: customAppBar('Schedule a tour with', false),
        body: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Row(
              children: [
                dummyAvater(),
                SizedBox(width: 10),
                Text('${serviceProvider.firstName} ${serviceProvider.lastName}',
                    style: st2F54C6400Rubik11.copyWith(
                        color: kc0C0932,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'You are about to create a meeting with one of our agent Mr Salisu AA',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            SizedBox(height: 15),
            // Text('Available days',
            //     style: st2F54C6400Rubik11.copyWith(color: kc0C0932)),
            Stack(
              children: [
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kc0C0932.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20)),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay:  _focusedDay,
                      onDaySelected: (selectedDay, focusedDay) {


                        print(selectedDay.day);
                        print('-----------------');
                        print(widget.availableDate);
                        setState(() {
                          _focusedDay = focusedDay;
                          daySelected = '${selectedDay.day}';
                        });
                        if (widget.availableDate.contains(
                            '${selectedDay.year},${selectedDay.month},${selectedDay.day}')) {
                          dateSelect = selectedDay.toString().split(' ')[0];

                          return isSameDay(selectedDay, focusedDay);
                        } else {
                          flushbarWidget(context,
                              'Please select from the highligted days', false);
                        }
                      },
                      holidayPredicate: (day) {
                        if (widget.availableDate.length == 1 &&
                            widget.availableDate[0] ==
                                '${day.year},${day.month},${day.day}') {
                          return true;
                        } else if (widget.availableDate.length == 2 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 3 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 4 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 5 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 6 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 7 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 8 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 9 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 10 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 11 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 12 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 13 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 14 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[13] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 15 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[13] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[14] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 16 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[13] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[14] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[15] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 17 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[13] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[14] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[15] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[16] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 18 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[13] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[14] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[15] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[16] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[17] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 19 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[13] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[14] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[15] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[16] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[17] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[18] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else if (widget.availableDate.length == 20 &&
                            (widget.availableDate[0] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[1] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[2] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[3] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[4] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[5] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[6] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[7] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[8] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[9] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[10] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[11] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[12] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[13] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[14] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[15] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[16] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[17] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[18] ==
                                    '${day.year},${day.month},${day.day}' ||
                                widget.availableDate[19] ==
                                    '${day.year},${day.month},${day.day}')) {
                          return true;
                        } else {
                          return false;
                        }
                        // for (int i = 0; i <= _data.length; i++) {
                        //   if (_data[i] == '${day.year},${day.month},${day.day}') {
                        //     return true;
                        //   } else {
                        //     return false;
                        //   }
                      },
                      headerStyle: HeaderStyle(
                        leftChevronVisible: true,
                        rightChevronVisible: true,
                        headerPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        titleTextStyle: GoogleFonts.poppins(
                            color: kcWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kcWhite,
                              borderRadius: BorderRadius.circular(8.0)),
                          selectedTextStyle: TextStyle(color: kcWhite)),
                      calendarBuilders: CalendarBuilders(
                        dowBuilder: (context, day) {
                          // if (day.weekday == DateTime.sunday) {
                          //   final text = DateFormat.E().format(day);

                          // return Center(
                          //   child: Text(
                          //     "${day}",
                          //     style: TextStyle(color: Colors.red),
                          //   ),
                          // );
                          // }
                        },
                        todayBuilder: (context, day, focusedDay) => Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFF3DED97)),
                                color: daySelected != null
                                    ? Colors.white
                                    : Color(0xFF3DED97)),
                            child: Text(
                              '${day.day}',
                              style: GoogleFonts.poppins(
                                  color: kc0C0932,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        selectedBuilder: (context, day, focusedDay) =>
                            Container(
                                margin: const EdgeInsets.all(5.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Text(
                                  day.day.toString(),
                                  style: GoogleFonts.poppins(
                                      color: kc0C0932,
                                      fontWeight: FontWeight.w700),
                                )),
                        holidayBuilder: (context, date, events) => Container(
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              date.day.toString(),
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF111111),
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ),
                  ),
                ),
                if (daySelected != null)
                  Positioned(
                      top: 20,
                      right: 70,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFF3DED97),
                        child: Text(
                          daySelected,
                          style: GoogleFonts.poppins(
                              color: Color(0xFF111111),
                              fontWeight: FontWeight.w700),
                        ),
                      ))
              ],
            ),
            SizedBox(height: 30),
            Text(
              'What time works best for you?',
              style: TextStyle(
                  color: kc0C0932, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Wrap(
                spacing: 8.0,
                runSpacing: 10.0,
                children: widget.availableTime
                    .map((e) => GestureDetector(
                          onTap: () {
                            print(e);
                            setState(() {
                              _selectedTime = e;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            decoration: BoxDecoration(
                              color: _selectedTime == e
                                  ? kc07C168
                                  : Color(0xFFF5F5F8),
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                  color: _selectedTime == e
                                      ? kc3DED97
                                      : Color(0xFFF5F5F8),
                                  width: 0.4),
                            ),
                            child: Text('$e',
                                style: st000000700Roboto10.copyWith(
                                  color:
                                      _selectedTime == e ? kcWhite : kc0C0932,
                                )),
                          ),
                        ))
                    .toList()),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: stTextFieldTitle500969595Google14,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: _phoneNumberContorller,
                      decoration: borderTextInputDecoration.copyWith(
                          hintText: 'Phone Number'),
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Field required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Email Address",
                    style: stTextFieldTitle500969595Google14,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      enabled: false,
                      initialValue: '${serviceProvider.email}',
                      decoration: borderTextInputDecoration.copyWith(
                          hintText: 'Email Address'),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Full Name",
                    style: stTextFieldTitle500969595Google14,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      enabled: false,
                      initialValue:
                          '${serviceProvider.firstName} ${serviceProvider.lastName}',
                      decoration: borderTextInputDecoration.copyWith(
                          hintText: 'Full Name'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                IconButton(
                    onPressed: () => setState(() => _isChecked = !_isChecked),
                    icon: Transform.translate(
                      offset: Offset(-12, 0),
                      child: Icon(
                        !_isChecked
                            ? Icons.check_box_outline_blank_outlined
                            : Icons.check_box_outlined,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    )),
                Expanded(
                  child: Text(
                    'By clicking schedule a tour, you agree to our Terms & Condition',
                    style: st535353400Rubik10,
                  ),
                )
              ],
            ),
            Text(
              'Scheduling a tour with any of our agents will cost you an additional sum of just ₦3, 000',
              style: stEB5757400Poppin10.copyWith(
                  fontFamily: "",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: kc0C0932),
            ),
            SizedBox(height: 70),
            customButton('Schedule a tour', () {
              _navToTourFee(serviceProvider.email);
            })
          ],
        ));
  }

  _navToTourFee(String email) async {
    if (_formKey.currentState.validate()) {
      if (dateSelect != null) {
        if (_selectedTime != null) {
          if (_isChecked) {
            String newDate;
            setState(() {
              newDate = '$dateSelect $_selectedTime:00:00';
            });
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TourFeeScreen(
                      prodcutId: widget.propertyId,
                      time: newDate,
                      email: widget.email,
                      phoneNumber: _phoneNumberContorller.text,
                    )));
//
            // EasyLoading.show(status: 'Processing...');
            // var response = await PostServices.scheduleTour(
            //     context: context,
            //     propertyId: widget.propertyId,
            //     dateTime: newDate,
            //     email: widget.email,
            //     phone: _phoneNumberContorller.text);
            // if (response is LogSucess) {
            //   EasyLoading.dismiss();
            //   Navigator.pop(context);
            //   flushbarWidget(context, response.message, true);
            // } else {
            //   EasyLoading.dismiss();
            //   flushbarWidget(
            //       context, (response as LogFailure).errorMessage, false);
            // }

            //
          } else {
            flushbarWidget(
                context, 'Please checkout our Terms & Condition', false);
          }
        }
      } else {
        flushbarWidget(
            context, 'Please select time from the available time', false);
      }
    } else {
      flushbarWidget(
          context, 'Please select date from the highligted days', false);
    }
  }
}
