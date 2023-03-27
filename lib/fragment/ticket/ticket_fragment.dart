import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/ticket/ticket_component.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          backgroundColor: rf_primaryColor,
          title: Text("Ticket", style: boldTextStyle(color: white, size: 20)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FilterScreen()));
                },
                icon: rf_setting.iconImage(iconColor: white, size: 22))
          ],
        ),
        body: Center(
            child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      10.height,
                      Ticket(
                        title: 'Phong Nha - Kẻ Bàng',
                        type: 'Khám phá',
                        start: '01/01/2024',
                        end: '15/01/2024',
                        from: 'Tp.Hồ Chí Minh',
                        to: 'Quảng Bình',
                        price: '5,000,000 VND',
                      ),
                      10.height
                    ],
                  );
                })));
  }
}
