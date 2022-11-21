import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/notification_model.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/other_notification_widget.dart';
import 'package:provider/provider.dart';

enum FilterOption { Month, Day }

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification-screen';
  NotificationScreen({Key key}) : super(key: key);



  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isMonth = true;
  String _filterValue = '';
  bool _isModelShow = false;
  bool show = true;

  FilterOption _option = FilterOption.Month;
  @override
  Widget build(BuildContext context) {
    String _token = Provider.of<UserToken>(context, listen: false).userToken;
    return GestureDetector(
      onTap: () => setState(() => _isModelShow = false),
      child: Scaffold(
          backgroundColor: kcWhite,
          appBar: actionAppBar('Notifications', imgFilter, _showFilter, false, true),
          body: FutureBuilder<Object>(
              future: GetServices.getNotification(_token),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(snapshot.error.toString() ==
                              'Connection closed before full header was received'
                          ? 'Internet connection failed'
                          : snapshot.error.toString()));
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('Loading..'),
                  );
                } else {
                  NotificationModel _notificationModel = snapshot.data;
                  print(snapshot.data);
                  // return Container(
                  //   child: Text('kkkk'),
                  // );
                  if (_notificationModel.data.today.isEmpty) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      // transformAlignment: TransformA,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(noNotification),
                          SizedBox(height: 16,),
                          Text('No new notification', style: TextStyle(
                            color: kc0C0932,
                            fontSize: 19,
                            fontWeight: FontWeight.w600
                          ),)
                        ],
                      ),
                    );
                  } else {
                    return ListView(
                      children: [
                        if (_notificationModel.data.today.length > 0)
                          _timeFrameText('Today'),
                        NotifcationWidget(_notificationModel, 'today'),
                        if (_notificationModel.data.today.length > 0)
                          _timeFrameText('Others'),
                        NotifcationWidget(_notificationModel, 'others')
                      ],
                    );
                  }
                }
              }),
          bottomSheet: _isModelShow ? _filterOption() : SizedBox.shrink()),
    );
  }

  _showFilter() {
    setState(
      () => _isModelShow = !_isModelShow,
    );
  }

  Widget _timeFrameText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(text),
    );
  }

  Widget _filterOption() {
    return GestureDetector(
      onTap: () => setState(() => _isModelShow = true),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filer', style: stBlack700Rubik17),
            Transform.translate(
              offset: Offset(-26, 0),
              child: RadioListTile(
                activeColor: kc3DED97,
                value: FilterOption.Month,
                groupValue: _option,
                onChanged: (FilterOption option) {
                  setState(() => _option = option);
                },
                title: Text('Month', style: stBlack700Rubik17),
              ),
            ),
            Transform.translate(
              offset: Offset(-26, 0),
              child: RadioListTile(
                value: FilterOption.Day,
                groupValue: _option,
                onChanged: (FilterOption option) {
                  setState(() => _option = option);
                },
                title: Text('Day', style: stBlack700Rubik17),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
                onTap: () => setState(() => _isModelShow = false),
                child: customButton('Proceed', () {}))
          ],
        ),
      ),
    );
  }
}
