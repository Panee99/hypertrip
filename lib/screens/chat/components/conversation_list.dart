import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/tourguide/assign_group_response.dart';
import 'package:room_finder_flutter/models/tourguide/tour_variant.dart';
import 'package:room_finder_flutter/routers.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_bloc.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_event.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_state.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class ConversationList extends StatelessWidget {
  final AssignGroupResponse data;
  final String userID;

  const ConversationList({required this.data, required this.userID});
  @override
  Widget build(BuildContext context) {
    bool isAccepting = data.tourVariant?.status == TourVariantStatus.Accepting;
    return GestureDetector(
      onTap: () =>
          isAccepting ? Navigator.pushNamed(context, Routers.CHAT_DETAIL, arguments: data) : null,
      child: BlocBuilder<ChatBloc, ChatState>(
        bloc: GetIt.I.get<ChatBloc>()..add(FetchLastedMessage(data.id)),
        builder: (context, state) {
          print('state.message ${state.message}');
          return Opacity(
            opacity: isAccepting ? 1 : 0.5,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 32, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        commonCachedNetworkAvatar(
                          url: data.tourVariant?.tour?.thumbnailUrl ?? '',
                          width: 56,
                          height: 56,
                          radius: 80,
                        ),
                        16.width,
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  data.groupName,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                if (state.message != null)
                                  Text(
                                    state.message!.content,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
