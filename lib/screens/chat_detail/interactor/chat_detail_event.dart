import 'package:equatable/equatable.dart';

abstract class ChatDetailEvent extends Equatable {
  const ChatDetailEvent();
}

class FetchMessageGroupChat extends ChatDetailEvent {
  final String groupId;
  const FetchMessageGroupChat(this.groupId);

  @override
  List<Object> get props => [];
}

class SendMessageGroupChat extends ChatDetailEvent {
  final String message;
  final String groupId;
  final String userId;
  const SendMessageGroupChat({required this.message, required this.groupId, required this.userId});

  @override
  List<Object> get props => [];
}

class UpdateMessage extends ChatDetailEvent {
  final String message;
  const UpdateMessage(this.message);

  @override
  List<Object> get props => [];
}
