import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/page_states.dart';

class ChatList extends StatefulWidget {
  final String tourGroupId;
  final VoidCallBack? onPressedMap;

  ChatList({Key? key, required this.tourGroupId, this.onPressedMap})
      : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ScrollController _scrollController = ScrollController();

  ChatController? _chatController;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      builder: (context, state) {
        if (state.status == PageState.loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (state.members.isNotEmpty && state.currentUser != null) {
            _processData(state.messages, state.members);
          }
          return _chatController != null
              ? ChatView(
                  chatController: _chatController!,
                  currentUser: state.currentUser ?? ChatUser(id: '', name: ''),
                  featureActiveConfig: FeatureActiveConfig(
                    enableSwipeToReply: false,
                    enableSwipeToSeeTime: false,
                    enableDoubleTapToLike: false,
                    enableReplySnackBar: false,
                    lastSeenAgoBuilderVisibility: false,
                    enableReactionPopup: false,
                  ),
                  chatViewState: state.members.isNotEmpty
                      ? ChatViewState.hasMessages
                      : state.currentUser != null
                          ? ChatViewState.noData
                          : ChatViewState.error,
                  chatViewStateConfig: ChatViewStateConfiguration(
                    loadingWidgetConfig: ChatViewStateWidgetConfiguration(
                      loadingIndicatorColor: repliedMessageColor,
                    ),
                    onReloadButtonTap: () {},
                  ),
                  chatBackgroundConfig: ChatBackgroundConfiguration(
                    messageTimeIconColor: Colors.white,
                    messageTimeTextStyle: TextStyle(color: Colors.white),
                    defaultGroupSeparatorConfig:
                        DefaultGroupSeparatorConfiguration(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    backgroundColor: rf_background_chat,
                  ),
                  chatBubbleConfig: ChatBubbleConfiguration(
                    inComingChatBubbleConfig: ChatBubble(
                      linkPreviewConfig: LinkPreviewConfiguration(
                          titleStyle: TextStyle(color: Colors.transparent),
                          bodyStyle: TextStyle(color: Colors.transparent)),
                    ),
                    outgoingChatBubbleConfig: ChatBubble(
                        linkPreviewConfig: LinkPreviewConfiguration(
                          titleStyle: TextStyle(color: Colors.transparent),
                          bodyStyle: TextStyle(color: Colors.transparent),
                          linkStyle: TextStyle(color: Colors.black),
                        ),
                        textStyle: TextStyle(color: Colors.black)),
                  ),
                  sendMessageConfig: SendMessageConfiguration(
                    imagePickerIconsConfig: ImagePickerIconsConfiguration(
                      cameraIconColor: rf_IconColor,
                      galleryIconColor: rf_IconColor,
                      mapIconColor: rf_IconColor,
                      cameraImagePickerIcon:
                          SvgPicture.asset(rf_icon_camera, color: rf_IconColor),
                      galleryImagePickerIcon: SvgPicture.asset(rf_icon_picture,
                          color: rf_IconColor),
                      mapIcon: SvgPicture.asset(rf_icon_map,
                          width: 24, height: 24, color: rf_IconColor),
                    ),
                    replyMessageColor: Colors.grey,
                    replyDialogColor: Color(0xffFCD8DC),
                    replyTitleColor: Color(0xffEE5366),
                    textFieldBackgroundColor: Colors.white,
                    closeIconColor: appTextColorPrimary,
                    textFieldConfig: TextFieldConfiguration(
                      textStyle: TextStyle(color: appTextColorPrimary),
                    ),
                    allowRecordingVoice: false,
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
                    replyPopupBuilder: (message, sendByCurrentUser) =>
                        SizedBox(),
                  ),
                  onPressedMap: widget.onPressedMap,
                  onSendTap: (message, replyMessage, messageType) {
                    print("onSendTap ${message} - messageType ${messageType}");
                    context.read<ChatDetailBloc>().add(SendMessageGroupChat(
                          userId: authProvider.user.id ?? '',
                          message: message,
                          type: messageType,
                          groupId: widget.tourGroupId,
                        ));
                    FocusScope.of(context).unfocus();
                  },
                )
              : Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _processData(List<FirestoreMessage> msg, List<ChatUser> members) async {
    if (_chatController == null) {
      List<Message> messages = [];
      for (final message in msg) {
        messages.add(message.toMessage());
      }
      _chatController = ChatController(
        initialMessageList: messages,
        scrollController: _scrollController,
        chatUsers: members,
      );
    } else {
      List<Message> messages = [];
      for (final message in msg) {
        messages.add(message.toMessage());
      }

      _chatController?.messageStreamController.add(messages);
    }
  }
}
