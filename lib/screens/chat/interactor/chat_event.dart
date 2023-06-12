import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class FetchGroupChat extends ChatEvent {
  final String? userid;
  const FetchGroupChat(this.userid);

  @override
  List<Object> get props => [];
}
