import 'package:flutter/material.dart';
import 'package:room_finder_flutter/models/chat/firestore_group_chat.dart';
import 'package:room_finder_flutter/routers.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/date_time_utils.dart';

class ConversationList extends StatelessWidget {
  final FirestoreGroupChat data;
  final String userID;

  const ConversationList({required this.data, required this.userID});
  @override
  Widget build(BuildContext context) {
    bool isMessageRead = data.recentMessage?.readBy.contains(userID) ?? false;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routers.CHAT_DETAIL, arguments: data),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 32, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: rfCommonCachedNetworkImage(
                      data.urlPhotoGroup,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.titleGroup,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            data.recentMessage?.message ?? '',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: isMessageRead ? FontWeight.normal : FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              DateTimeUtils.formatDateTimeToShortDate(data.recentMessage?.sendAt),
              style: TextStyle(
                  fontSize: 12, fontWeight: isMessageRead ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
