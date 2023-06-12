import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/tourguide/assign_group_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/base_page.dart';
import 'package:room_finder_flutter/utils/page_states.dart';

class ChatDetailPage extends StatefulWidget {
  final AssignGroupResponse assignGroupResponse;

  const ChatDetailPage({Key? key, required this.assignGroupResponse}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  ScrollController _scrollController = ScrollController();
  ChatController? _chatController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    print(
        'widget.assignGroupResponse.tourVariant?.id ${widget.assignGroupResponse.tourVariant?.tour?.id}');

    return BlocProvider(
      create: (BuildContext context) => GetIt.I.get<ChatDetailBloc>()
        ..add(FetchMessageGroupChat(widget.assignGroupResponse.tourVariant?.tour?.id ?? '')),
      child: BasePage(
        unFocusWhenTouchOutsideInput: true,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: rf_primaryColor,
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
          ),
          body: BlocBuilder<ChatDetailBloc, ChatDetailState>(
            builder: (context, state) {
              if (state.status == PageState.loading) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (state.messages.isNotEmpty) {
                  _processData(state.messages);
                }
                return _chatController != null
                    ? ChatView(
                        chatController: _chatController!,
                        currentUser: ChatUser(
                          id: '1',
                          name: '${authProvider.user.firstName} ${authProvider.user.lastName}',
                          profilePhoto: authProvider.user.avatarUrl,
                        ),
                        chatViewState: ChatViewState.hasMessages,
                        chatViewStateConfig: ChatViewStateConfiguration(
                          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
                            loadingIndicatorColor: repliedMessageColor,
                          ),
                          onReloadButtonTap: () {},
                        ),
                        chatBackgroundConfig: ChatBackgroundConfiguration(
                          messageTimeIconColor: Colors.white,
                          messageTimeTextStyle: TextStyle(color: Colors.white),
                          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          backgroundColor: rf_primaryColor,
                        ),
                        sendMessageConfig: SendMessageConfiguration(
                          imagePickerIconsConfig: ImagePickerIconsConfiguration(
                            cameraIconColor: Color(0xff757575),
                            galleryIconColor: Color(0xff757575),
                          ),
                          replyMessageColor: Colors.grey,
                          replyDialogColor: Color(0xffFCD8DC),
                          replyTitleColor: Color(0xffEE5366),
                          textFieldBackgroundColor: Colors.white,
                          closeIconColor: appTextColorPrimary,
                          textFieldConfig: TextFieldConfiguration(
                            textStyle: TextStyle(color: appTextColorPrimary),
                          ),
                          allowRecordingVoice: true,
                          micIconColor: Colors.white,
                          voiceRecordingConfiguration: VoiceRecordingConfiguration(
                            backgroundColor: Color(0xff383152),
                            recorderIconColor: Color(0xff757575),
                            waveStyle: WaveStyle(
                              showMiddleLine: false,
                              waveColor: Colors.white,
                              extendWaveform: true,
                            ),
                          ),
                        ),
                        swipeToReplyConfig: SwipeToReplyConfiguration(
                          replyIconColor: Colors.transparent,
                        ),
                        profileCircleConfig: ProfileCircleConfiguration(
                          profileImageUrl: authProvider.user.avatarUrl,
                        ),
                        replyPopupConfig: ReplyPopupConfiguration(
                          onReplyTap: (message) {},
                          replyPopupBuilder: (message, sendByCurrentUser) => SizedBox(),
                        ),
                        onPressedMap: () {
                          print("onPressedMap");
                        },
                        onSendTap: (message, replyMessage, messageType) {
                          print("onSendTap ${message} - messageType ${messageType}");
                          context.read<ChatDetailBloc>().add(SendMessageGroupChat(
                                userId: authProvider.user.id ?? '',
                                message: message,
                                type: messageType,
                                groupId: widget.assignGroupResponse.tourVariant?.tour?.id ?? '',
                              ));
                          FocusScope.of(context).unfocus();
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  void _processData(List<FirestoreMessage> msg) async {
    if (_chatController == null) {
      List<Message> messages = [];
      List<ChatUser> chatUsers = [];
      for (final message in msg) {
        messages.add(message.toMessage());

        chatUsers.add(ChatUser(id: message.senderId ?? '', name: '1111'));
      }
      _chatController = ChatController(
        initialMessageList: messages,
        scrollController: _scrollController,
        chatUsers: chatUsers,
      );
    } else {
      List<Message> messages = [];
      List<ChatUser> chatUsers = [];
      for (final message in msg) {
        messages.add(message.toMessage());

        chatUsers.add(ChatUser(id: message.senderId ?? '', name: '1111'));
      }
      _chatController?.chatUsers.clear();

      _chatController?.messageStreamController.add(messages);
      _chatController?.chatUsers = chatUsers;
    }
  }
}
