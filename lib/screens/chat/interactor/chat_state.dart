import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/chat/firestore_group_chat.dart';

abstract class ChatState extends Equatable {
  final List<FirestoreGroupChat> groupChat;
  final String error;

  ChatState({required this.error, required this.groupChat});

  ChatState copyWith({String? error, List<FirestoreGroupChat>? groupChat}) {
    return ChatLoadedState(
      error: error ?? this.error,
      groupChat: groupChat ?? this.groupChat,
    );
  }
}

class ChatLoadingState extends ChatState {
  ChatLoadingState({required super.error, required super.groupChat});

  @override
  List<Object?> get props => [groupChat];
}

class ChatLoadedState extends ChatState {
  ChatLoadedState({required super.error, required super.groupChat});

  @override
  List<Object?> get props => [groupChat];
}

class ChatErrorState extends ChatState {
  ChatErrorState({required super.error, required super.groupChat});

  @override
  List<Object?> get props => [error];
}
