import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class MemberItem extends StatelessWidget {
  final ChatUser data;
  const MemberItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          commonCachedNetworkAvatar(
            url: data.profilePhoto ?? '',
            width: 56,
            height: 56,
            radius: 80,
          ),
          16.width,
          Text(
            data.name,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
