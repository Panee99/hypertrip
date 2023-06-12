import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/chat/firestore_user.dart';

abstract class ChatDetailState extends Equatable {
  final List<FirestoreMessage> messages;
  final String message;
  final String error;
  final FirestoreUser firestoreUser;

  ChatDetailState(
      {required this.error,
      required this.messages,
      required this.message,
      required this.firestoreUser});

  ChatDetailState copyWith(
      {String? error,
      List<FirestoreMessage>? messages,
      String? message,
      FirestoreUser? firestoreUser}) {
    return ChatDetailLoadedState(
      error: error ?? this.error,
      messages: messages ?? this.messages,
      message: message ?? this.message,
      firestoreUser: firestoreUser ?? this.firestoreUser,
    );
  }
}

class ChatDetailLoadingState extends ChatDetailState {
  ChatDetailLoadingState(
      {required super.error,
      required super.messages,
      required super.message,
      required super.firestoreUser});

  @override
  List<Object?> get props => [messages, message, firestoreUser];
}

class ChatDetailLoadedState extends ChatDetailState {
  ChatDetailLoadedState(
      {required super.error,
      required super.messages,
      required super.message,
      required super.firestoreUser});

  @override
  List<Object?> get props => [messages, message, firestoreUser];
}

class ChatDetailErrorState extends ChatDetailState {
  ChatDetailErrorState(
      {required super.error,
      required super.messages,
      required super.message,
      required super.firestoreUser});

  @override
  List<Object?> get props => [error];
}
