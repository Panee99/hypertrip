import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class ChatItem extends StatelessWidget {
  final FirestoreMessage data;
  const ChatItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final bool isSender = data.sentBy == authProvider.user.id;
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      bloc: GetIt.I.get<ChatDetailBloc>()..add(GetUserFirestore(data.sentBy)),
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: (isSender ? Alignment.topRight : Alignment.topLeft),
            child: isSender
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (isSender ? Colors.blue[200] : Colors.grey.shade200),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      data.messageText,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CircleAvatar(
                          child: rfCommonCachedNetworkImage(state.firestoreUser.photoURL),
                        ),
                      ),
                      5.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.firestoreUser.displayName,
                            style: boldTextStyle(size: 16),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (isSender ? Colors.blue[200] : Colors.grey.shade200),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              data.messageText,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
