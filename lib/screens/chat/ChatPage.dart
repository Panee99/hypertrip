import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/chat/conversationList.dart';
import 'package:room_finder_flutter/models/chat/chatUserModels.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';

class ChatPageScreen extends StatefulWidget {
  @override
  _ChatPageScreenState createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: 'name',
        messageText: 'messageText',
        imageURL: 'imageURL',
        time: 'time'),
    ChatUsers(
        name: 'name',
        messageText: 'messageText',
        imageURL: 'imageURL',
        time: 'time'),
    ChatUsers(
        name: 'name',
        messageText: 'messageText',
        imageURL: 'imageURL',
        time: 'time'),
    ChatUsers(
        name: 'name',
        messageText: 'messageText',
        imageURL: 'imageURL',
        time: 'time'),
    ChatUsers(
        name: 'name',
        messageText: 'messageText',
        imageURL: 'imageURL',
        time: 'time'),
    ChatUsers(
        name: 'name',
        messageText: 'messageText',
        imageURL: 'imageURL',
        time: 'time'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đoạn chat',
                    style: boldTextStyle(color: Colors.black, size: 20),
                  ),
                ]).paddingLeft(16),
            leadingWidth: 150,
            elevation: 0,
            backgroundColor: whiteSmoke,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: whiteSmoke,
                statusBarIconBrightness: Brightness.dark),
            actions: [
              Row(
                children: [
                  SvgPicture.asset(add_square, height: 20),
                  16.width,
                ],
              ).paddingRight(16),
            ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: body,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          ListView.builder(
            itemCount: chatUsers.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ConversationList(
                name: chatUsers[index].name,
                messageText: chatUsers[index].messageText,
                imageUrl: chatUsers[index].imageURL,
                time: chatUsers[index].time,
                isMessageRead: (index == 0 || index == 3) ? true : false,
              );
            },
          ),
        ],
      ).paddingOnly(left: 16, top: 8),
    );
  }
}
