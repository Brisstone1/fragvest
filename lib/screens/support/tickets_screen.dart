import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/get_all_tickets_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/support/support_chat_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:provider/provider.dart';

import 'create_ticket.dart';

class TicketScreen extends StatefulWidget {
  static const routeName = '/tickets-screen';

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isFirst = ModalRoute.of(context).settings.arguments as bool;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcWhite,
        appBar:
            ticketAppBar(context, Text('Tickets',
                style: st535353600Rubik16)
            ),
        body: ListView(

          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 30,
              width: double.infinity,
              // color: Color(0xFFF4F4F4),
            ),
            FutureBuilder<Object>(
                future: GetServices.getTickets(context),
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
                              // setState((){});
                            },
                            child: Text(snapshot.error.toString()),
                          )
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: SpinKitSpinningLines(
                        color: kc3DED97,
                      ),
                    );
                  } else {
                    GetAllTicketsModel _tickets = snapshot.data;

                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 60),
                        shrinkWrap: true,
                        itemCount: _tickets.data.tickets.length,
                        itemBuilder: (context, index) {
                          final serviceProvider = Provider.of<ServiceProvider>(
                              context,
                              listen: false);

                          final _ticketdata = _tickets.data.tickets[index];

                          return GestureDetector(
                            onTap: () {
                              serviceProvider.setTicket(_ticketdata.ticketId);
                              serviceProvider.setChatStatus(_ticketdata.status);
                              Navigator.of(context)
                                  .pushNamed(SupportChatScreen.routeName);
                            },
                            child: Container(
                              height: 60,
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _ticketdata.subject,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500, color: kc0C0932,
                                            fontSize: 12
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),

                                        Text(
                                        'Ticket ID:  ${_ticketdata.ticketId}',
                                          style: st000000400Roboto12.copyWith(
                                              color: Color(0xFF8E8E8E)),
                                          maxLines: 1,
                                        ),
                                        // Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 40),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _ticketdata.date,
                                        style: st000000400Roboto12.copyWith(
                                            color: Color(0xFF8E8E8E)),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        height: 20,
                                        width: 90,

                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(

                                            border: Border.all(
                                                color: _ticketdata.status ==
                                                        'in progress'
                                                    ? kc00AA57
                                                    : Colors.red,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle_rounded,
                                              color: _ticketdata.status ==
                                                      'in progress'
                                                  ? kc00AA57
                                                  : Colors.red,
                                              size: 8,
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                _ticketdata.status,
                                                style: TextStyle(
                                                    color: _ticketdata.status ==
                                                        'in progress'
                                                        ? kc00AA57
                                                        : Colors.red,
                                                    fontSize: 10),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                })
          ],
        ),
        bottomSheet: Container(
          color: kcWhite,
          child: Padding(

            padding: const EdgeInsets.all(20),
            child: customButton(
                'Message us',
                    () => _isFirst
                    ? Navigator.of(context).pop()
                    : Navigator.of(context).pushNamed(CreateTicket.routeName)),
          ),
        ) ,
      ),
    );
  }
}
