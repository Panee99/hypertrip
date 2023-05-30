import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/components/ticket/ticket_component.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/ticket/ticket_list_response.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/screens/ticket/filter_screen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class TicketFragment extends StatefulWidget {
  const TicketFragment({super.key});

  @override
  State<TicketFragment> createState() => _TicketFragmentState();
}

class _TicketFragmentState extends State<TicketFragment> {
  late Future<List<TicketListResponse>> ticketList;
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    getTicketList();
  }

  void getTicketList() {
    authProvider = context.read<AuthProvider>();
    ticketList = AppRepository()
        .getTicketList(authProvider.getUserId()!, authProvider.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWidget(context,
            title: 'Ticket',
            roundCornerShape: true,
            showLeadingIcon: true,
            action: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FilterScreen()));
                },
                icon: rf_setting.iconImage(iconColor: white, size: 22))),
        // AppBar(
        //   automaticallyImplyLeading: false,
        //   systemOverlayStyle:
        //       SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        //   backgroundColor: rf_primaryColor,
        //   title: Text("Ticket", style: boldTextStyle(color: white, size: 20)),
        //   centerTitle: true,
        //   actions: [
        // IconButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => FilterScreen()));
        //     },
        //     icon: rf_setting.iconImage(iconColor: white, size: 22))
        //   ],
        // ),
        body: FutureBuilder<List<TicketListResponse>>(
            future: ticketList,
            builder: (BuildContext context,
                AsyncSnapshot<List<TicketListResponse>> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: context.height() * 0.5,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                final tickets = snapshot.data!;
                print('Ticket fragment: ' + tickets.length.toString());
                return Center(
                    child: ListView.builder(
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          print('Ticker fragment: ' +
                              tickets[index].tourId.toString());
                          return Column(
                            children: [
                              10.height,
                              Ticket(
                                tourId: tickets[index].tourId!,
                              ),
                              10.height
                            ],
                          );
                        }));
              }
            }));
  }
}
