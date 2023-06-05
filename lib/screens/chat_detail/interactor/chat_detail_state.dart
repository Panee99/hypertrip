import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';

abstract class ChatDetailState extends Equatable {
  final List<FirestoreMessage> messages;
  final String message;
  final String error;

  ChatDetailState({required this.error, required this.messages, required this.message});

  ChatDetailState copyWith({String? error, List<FirestoreMessage>? messages, String? message}) {
    return ChatDetailLoadedState(
      error: error ?? this.error,
      messages: messages ?? this.messages,
      message: message ?? this.message,
    );
  }
}

class ChatDetailLoadingState extends ChatDetailState {
  ChatDetailLoadingState({required super.error, required super.messages, required super.message});

  @override
  List<Object?> get props => [messages, message];
}

class ChatDetailLoadedState extends ChatDetailState {
  ChatDetailLoadedState({required super.error, required super.messages, required super.message});

  @override
  List<Object?> get props => [messages, message];
}

class ChatDetailErrorState extends ChatDetailState {
  ChatDetailErrorState({required super.error, required super.messages, required super.message});

  @override
  List<Object?> get props => [error];
}
