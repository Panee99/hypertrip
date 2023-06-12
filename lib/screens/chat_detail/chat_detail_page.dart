import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/chat/firestore_group_chat.dart';
import 'package:room_finder_flutter/screens/chat_detail/components/chat_item.dart';
import 'package:room_finder_flutter/screens/chat_detail/components/input_message.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class ChatDetailPage extends StatefulWidget {
  final FirestoreGroupChat firestoreGroupChat;

  ChatDetailPage({required this.firestoreGroupChat});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          GetIt.I.get<ChatDetailBloc>()..add(FetchMessageGroupChat(widget.firestoreGroupChat.id)),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  2.width,
                  CircleAvatar(
                    child: rfCommonCachedNetworkImage(
                      widget.firestoreGroupChat.urlPhotoGroup,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                    maxRadius: 20,
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.firestoreGroupChat.titleGroup,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<ChatDetailBloc, ChatDetailState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: state.messages.length,
                  padding: EdgeInsets.only(bottom: 100),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChatItem(data: state.messages[index]);
                  },
                ),
                InputMessage(groupId: widget.firestoreGroupChat.id),
              ],
            );
          },
        ),
      ),
    );
  }
}
