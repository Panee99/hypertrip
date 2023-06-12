import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/chat/firestore_user.dart';
import 'package:room_finder_flutter/utils/page_states.dart';

abstract class ChatDetailState extends Equatable {
  final PageState status;
  final List<FirestoreMessage> messages;
  final String message;
  final String error;
  final FirestoreUser firestoreUser;

  ChatDetailState(
      {required this.status,
      required this.error,
      required this.messages,
      required this.message,
      required this.firestoreUser});

  ChatDetailState copyWith(
      {PageState? status,
      String? error,
      List<FirestoreMessage>? messages,
      String? message,
      FirestoreUser? firestoreUser}) {
    return ChatDetailLoadedState(
      status: status ?? this.status,
      error: error ?? this.error,
      messages: messages ?? this.messages,
      message: message ?? this.message,
      firestoreUser: firestoreUser ?? this.firestoreUser,
    );
  }
}

class ChatDetailLoadingState extends ChatDetailState {
  ChatDetailLoadingState(
      {required super.status,
      required super.error,
      required super.messages,
      required super.message,
      required super.firestoreUser});

  @override
  List<Object?> get props => [messages, message, firestoreUser];
}

class ChatDetailLoadedState extends ChatDetailState {
  ChatDetailLoadedState(
      {required super.status,
      required super.error,
      required super.messages,
      required super.message,
      required super.firestoreUser});

  @override
  List<Object?> get props => [messages, message, firestoreUser];
}

class ChatDetailErrorState extends ChatDetailState {
  ChatDetailErrorState(
      {required super.status,
      required super.error,
      required super.messages,
      required super.message,
      required super.firestoreUser});

  @override
  List<Object?> get props => [error];
}
