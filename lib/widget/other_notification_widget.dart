import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/notification_model.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class NotifcationWidget extends StatefulWidget {
  final String timeFrame;
  final NotificationModel notificationModel;
  const NotifcationWidget(this.notificationModel, this.timeFrame);

  @override
  _NotifcationWidgetState createState() => _NotifcationWidgetState();
}

class _NotifcationWidgetState extends State<NotifcationWidget> {
  int _currentIndex;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        itemCount: widget.timeFrame == 'today'
            ? widget.notificationModel.data.today.length
            : widget.notificationModel.data.others.length,
        itemBuilder: (context, index) {
          final _data = widget.timeFrame == 'today'
              ? widget.notificationModel.data.today[index]
              : widget.notificationModel.data.others[index];
          return GestureDetector(
              onTap: () => setState(
                    () => _currentIndex = index,
                  ),
              child: _currentIndex == index
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: _decoration(kc0C0932),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _imageContainer(imgBedroom),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _data.title,
                                    style: st535353700Rubik14.copyWith(
                                        color: kcWhite),
                                  ),
                                  Text(
                                    _data.title,
                                    style: st535353400Rubik12.copyWith(
                                        color: kcWhite.withOpacity(0.7)),
                                  )
                                ],
                              ),
                              // Spacer(),

                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            _data.body,
                            style: st535353400Rubik12.copyWith(
                              color: kcWhite.withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: _decoration(kcWhite),
                      child: Row(
                        children: [
                          _imageContainer(imgBedroom),
                          // Spacer(),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_data.title, style: TextStyle(
                                color: Color(0xFF0C0932),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              )),
                              SizedBox(height: 12),
                              Text(_data.title, style: TextStyle(
                                color: Color(0xFF07C168),
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              )),
                              SizedBox(height: 12),
                              Text('${_data.date}', style: st535353400Rubik12),
                            ],
                          ),

                          // _imageContainer(imgBedroom)
                        ],
                      )));
        });
  }

  Widget _imageContainer(String imgUrl) {
    return Container(
      height: 56,
      width: 62,
      margin: EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.asset(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  BoxDecoration _decoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: kc535353,
        width: 0.4,
      ),
    );
  }
}
