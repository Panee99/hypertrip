import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/tourguide/assign_group_response.dart';

abstract class ChatState extends Equatable {
  final List<AssignGroupResponse> groupChat;
  final String error;

  ChatState({required this.error, required this.groupChat});

  ChatState copyWith({
    String? error,
    List<AssignGroupResponse>? groupChat,
  });

  @override
  List<Object?> get props => [groupChat, error];
}

class ChatLoadingState extends ChatState {
  ChatLoadingState({required List<AssignGroupResponse> groupChat, required String error})
      : super(groupChat: groupChat, error: error);

  @override
  ChatState copyWith({
    String? error,
    List<AssignGroupResponse>? groupChat,
  }) {
    return ChatLoadingState(
      groupChat: groupChat ?? this.groupChat,
      error: error ?? this.error,
    );
  }
}

class ChatLoadedState extends ChatState {
  ChatLoadedState({required List<AssignGroupResponse> groupChat, required String error})
      : super(groupChat: groupChat, error: error);

  @override
  ChatState copyWith({
    String? error,
    List<AssignGroupResponse>? groupChat,
  }) {
    return ChatLoadedState(
      groupChat: groupChat ?? this.groupChat,
      error: error ?? this.error,
    );
  }
}

class ChatErrorState extends ChatState {
  ChatErrorState({required List<AssignGroupResponse> groupChat, required String error})
      : super(groupChat: groupChat, error: error);

  @override
  ChatState copyWith({
    String? error,
    List<AssignGroupResponse>? groupChat,
  }) {
    return ChatErrorState(
      groupChat: groupChat ?? this.groupChat,
      error: error ?? this.error,
    );
  }
}
