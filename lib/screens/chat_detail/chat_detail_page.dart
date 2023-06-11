import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/models/tourguide/assign_group_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/screens/chat_detail/components/chat_list.dart';
import 'package:room_finder_flutter/screens/chat_detail/components/member_list.dart';
import 'package:room_finder_flutter/screens/chat_detail/components/share_map.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/base_page.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class ChatDetailPage extends StatefulWidget {
  final AssignGroupResponse assignGroupResponse;

  const ChatDetailPage({Key? key, required this.assignGroupResponse}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  PanelController _panelController = PanelController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return BlocProvider(
      create: (BuildContext context) => GetIt.I.get<ChatDetailBloc>()
        ..add(GetMembersTourGroup(widget.assignGroupResponse.id, authProvider.user.id ?? ''))
        ..add(FetchMessageGroupChat(widget.assignGroupResponse.id)),
      child: BasePage(
        unFocusWhenTouchOutsideInput: true,
        child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
          builder: (context, state) => Scaffold(
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
                        icon: Image.asset(
                          rf_icon_arrow_back,
                          color: Colors.black,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      2.width,
                      commonCachedNetworkAvatar(
                        url: widget.assignGroupResponse.tourVariant?.tour?.thumbnailUrl ?? '',
                        height: 46,
                        width: 46,
                      ),
                      12.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.assignGroupResponse.groupName,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            6.width
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                  onPressed: () => _showMemberList(context, state.members),
                ),
              ],
            ),
            extendBodyBehindAppBar: true,
            body: BlocBuilder<ChatDetailBloc, ChatDetailState>(
              builder: (context, state) {
                print("state.isCanDrag ${state.isCanDrag}");
                return SlidingUpPanel(
                  defaultPanelState: PanelState.CLOSED,
                  controller: _panelController,
                  minHeight: 0.0,
                  maxHeight: 500.0,
                  disableDraggableOnScrolling: !state.isCanDrag,
                  panelBuilder: () {
                    return ShareMap(
                      onSharePosition: (position) {
                        context.read<ChatDetailBloc>().add(SendMessageGroupChat(
                              userId: authProvider.user.id ?? '',
                              // message:
                              //     'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}',
                              message:
                                  "http://maps.google.com/maps?q=${position.latitude},${position.longitude}&iwloc=A",
                              type: MessageType.custom,
                              groupId: widget.assignGroupResponse.id,
                            ));

                        _panelController.close();
                      },
                    );
                  },
                  body: ChatList(
                    tourGroupId: widget.assignGroupResponse.id,
                    onPressedMap: () {
                      context.read<ChatDetailBloc>()..add(StatusMapEvent(state.isOpenMap));
                      _panelController.open();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _showMemberList(BuildContext context, List<ChatUser> members) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 500),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: MemberList(members: members),
      ),
    );
  }
}
