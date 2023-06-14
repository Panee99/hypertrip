import 'package:chatview/chatview.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/chat/firestore_user.dart';
import 'package:room_finder_flutter/utils/page_states.dart';

class ChatDetailState extends Equatable {
  final PageState status;
  final List<FirestoreMessage> messages;
  final String message;
  final String error;
  final FirestoreUser firestoreUser;
  final ChatUser? currentUser;
  final List<ChatUser> members;
  final bool isOpenMap;
  final bool isPermissionGeolocation;
  final Position? position;
  final bool isCanDrag;
  final List<String> deviceTokens;

  const ChatDetailState({
    required this.status,
    required this.error,
    required this.messages,
    required this.message,
    required this.firestoreUser,
    this.currentUser,
    required this.members,
    this.isOpenMap = false,
    this.isPermissionGeolocation = false,
    this.position,
    this.isCanDrag = false,
    required this.deviceTokens,
  });

  ChatDetailState copyWith({
    PageState? status,
    String? error,
    List<FirestoreMessage>? messages,
    String? message,
    FirestoreUser? firestoreUser,
    ChatUser? currentUser,
    List<ChatUser>? members,
    bool? isOpenMap,
    bool? isPermissionGeolocation,
    Position? position,
    bool? isCanDrag,
    List<String>? deviceTokens,
  }) {
    return ChatDetailState(
      status: status ?? this.status,
      error: error ?? this.error,
      messages: messages ?? this.messages,
      message: message ?? this.message,
      firestoreUser: firestoreUser ?? this.firestoreUser,
      members: members ?? this.members,
      currentUser: currentUser ?? this.currentUser,
      isOpenMap: isOpenMap ?? this.isOpenMap,
      isPermissionGeolocation: isPermissionGeolocation ?? this.isPermissionGeolocation,
      position: position ?? this.position,
      isCanDrag: isCanDrag ?? this.isCanDrag,
      deviceTokens: deviceTokens ?? this.deviceTokens,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        messages,
        message,
        firestoreUser,
        currentUser,
        isOpenMap,
        isPermissionGeolocation,
        position,
        isCanDrag,
        deviceTokens
      ];
}
